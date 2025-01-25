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
        biliWbiSign(paramEncoded: data.param.base64Encoded()) { signed in
            let signed = #require(signed)
            requestJSON(data.path + signed, headers: headers) { respJson, isSuccess in
                #expect(isSuccess && CheckBApiError(from: respJson))
            }
        }
    }
}
