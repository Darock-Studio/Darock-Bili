//
//
//  MeowBiliTests.swift
//  MeowBiliTests
//
//  Created by memz233 on 7/22/24.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Testing
import Alamofire
import SwiftyJSON
import Foundation
import DarockFoundation
@testable import MeowBili

struct BiliAPITests {
    let headers: HTTPHeaders = [
        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    ]
    
    @Test(arguments: [
        "https://api.bilibili.com/x/web-interface/archive/has/like?bvid=BV1UW4y1N79w",
        "https://api.bilibili.com/x/web-interface/archive/coins?bvid=BV1UW4y1N79w",
        "https://api.bilibili.com/x/v2/fav/video/favoured?aid=BV1UW4y1N79w",
        "https://api.bilibili.com/x/web-interface/archive/related?bvid=BV1UW4y1N79w",
        "https://api.bilibili.com/x/web-interface/view?bvid=BV1UW4y1N79w",
        "https://api.bilibili.com/x/tag/archive/tags?bvid=BV1UW4y1N79w",
        "https://s.search.bilibili.com/main/hotword"
    ])
    func testAPIError(_ path: String) async throws {
        requestJSON(path, headers: headers) { respJson, isSuccess in
            #expect(isSuccess && CheckBApiError(from: respJson))
        }
    }
    
    @Test(arguments: [
        ("https://api.bilibili.com/x/web-interface/wbi/index/top/feed/rcmd?", "y_num=5&fresh_type=3&feed_version=V_FAVOR_WATCH_LATER&fresh_idx_1h=1&fetch_row=1&fresh_idx=1&brush=4&homepage_ver=1&ps=20&last_y_num=5&screen=2353-686"),
        ("https://api.bilibili.com/x/web-interface/wbi/search/type?", "keyword=Darock&search_type=video&page=1")
    ])
    func testWbiAPIError(_ data: (path: String, param: String)) async throws {
        let signedQuery: String? = await withCheckedContinuation { continuation in
            biliWbiSign(paramEncoded: data.param.base64Encoded()) { signed in
                continuation.resume(returning: signed)
            }
        }
        let signed = try #require(signedQuery)
        let (response, isSuccess): (JSON, Bool) = await withCheckedContinuation { continuation in
            requestJSON(data.path + signed, headers: headers) { response, isSuccess in
                continuation.resume(returning: (response, isSuccess))
            }
        }
        #expect(isSuccess && CheckBApiError(from: response, noTip: true))
    }
}

struct BiliWbiSigningTests {
    private let imgKey = "7cd084941338484aae1ad9425b84077c"
    private let subKey = "4932caff0ff746eab6f01bf08b70ac45"
    
    @Test
    func matchesDocumentedSignature() {
        let query = biliWbiSignedQuery(
            parameters: ["foo": "114", "bar": "514", "zab": "1919810"],
            imgKey: imgKey,
            subKey: subKey,
            timestamp: 1702204169
        )
        #expect(query == "bar=514&foo=114&wts=1702204169&zab=1919810&w_rid=8f6f2b5b3d485fe1886cec6a0be8c5d4")
    }
    
    @Test
    func encodesSearchKeywordAndFiltersSpecialCharacters() throws {
        let query = try #require(biliWbiSignedQuery(
            parameters: ["keyword": "中文 空格+&=/%?#:!'()*", "search_type": "video", "page": "1"],
            imgKey: imgKey,
            subKey: subKey,
            timestamp: 1702204169
        ))
        #expect(query == "keyword=%E4%B8%AD%E6%96%87%20%E7%A9%BA%E6%A0%BC%2B%26%3D%2F%25%3F%23%3A&page=1&search_type=video&wts=1702204169&w_rid=ae4a9743b3fc155481de9f450590ea60")
        let components = try #require(URLComponents(string: "https://api.bilibili.com/?" + query))
        #expect(components.queryItems?.first?.value == "中文 空格+&=/%?#:")
        #expect(components.queryItems?.count == 5)
    }
    
    @Test
    func preservesEmptyValuesAndLiteralPercentEscapes() {
        let query = biliWbiSignedQuery(
            parameters: ["empty": "", "token": "a=b=c", "percent": "%2F"],
            imgKey: imgKey,
            subKey: subKey,
            timestamp: 1702204169
        )
        #expect(query == "empty=&percent=%252F&token=a%3Db%3Dc&wts=1702204169&w_rid=ad6d5569d50887084f0360983499f742")
    }
    
    @Test
    func replacesExistingSignatureAndTimestamp() {
        let query = biliWbiSignedQuery(
            parameters: ["foo": "114", "bar": "514", "zab": "1919810", "wts": "1", "w_rid": "old"],
            imgKey: imgKey,
            subKey: subKey,
            timestamp: 1702204169
        )
        #expect(query == "bar=514&foo=114&wts=1702204169&zab=1919810&w_rid=8f6f2b5b3d485fe1886cec6a0be8c5d4")
    }
    
    @Test(arguments: ["", "short", String(repeating: "g", count: 32), String(repeating: "中", count: 32)])
    func rejectsInvalidKeys(_ key: String) {
        #expect(biliWbiSignedQuery(parameters: [:], imgKey: key, subKey: subKey, timestamp: 1) == nil)
        #expect(biliWbiSignedQuery(parameters: [:], imgKey: imgKey, subKey: key, timestamp: 1) == nil)
    }
    
    @Test
    func rejectsVoucherResponseWithSuccessCode() {
        let response: JSON = ["code": 0, "message": "OK", "data": ["v_voucher": "voucher_test"]]
        #expect(!CheckBApiError(from: response, noTip: true))
        #expect(CheckBApiError(from: ["code": 0, "data": ["result": []]], noTip: true))
    }
}
