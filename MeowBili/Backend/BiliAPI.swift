//
//
//  BiliAPI.swift
//  DarockBili
//
//  Created by memz233 on 10/19/24.
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

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON

class BiliAPI {
    static let shared = BiliAPI()
    
    @AppStorage("DedeUserID") private var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") private var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") private var sessdata = ""
    @AppStorage("bili_jct") private var biliJct = ""
    @AppStorage("CachedBiliTicket") private var cachedBiliTicket = ""
    
    /// 获取指定用户详情
    /// - Parameter uid: 用户 UID
    /// - Returns: 用户详情数据
    func userInfo(of uid: String? = nil) async -> UserInfo? {
        let uid = uid ?? dedeUserID
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata)",
            "referer": "https://message.bilibili.com/", // rdar://gh/SocialSisterYi/bilibili-API-collect/issues/631#issuecomment-2099276628
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        return await withCheckedContinuation { continuation in
            biliWbiSign(paramEncoded: "mid=\(uid)".base64Encoded()) { signed in
                if let signed {
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            if !CheckBApiError(from: respJson) {
                                continuation.resume(returning: nil)
                                return
                            }
                            continuation.resume(returning: UserInfo(json: respJson))
                        } else {
                            continuation.resume(returning: nil)
                        }
                    }
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    func userRelation(of uid: String) async -> UserRelation? {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3); bili_ticket=\(cachedBiliTicket)",
            "referer": "https://message.bilibili.com/", // rdar://gh/SocialSisterYi/bilibili-API-collect/issues/631#issuecomment-2099276628
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        if case .success(let json) = await DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/stat?vmid=\(uid)", headers: headers) {
            if !CheckBApiError(from: json) { return nil }
            return UserRelation(json: json["data"])
        } else {
            return nil
        }
    }
    
    func isFollowed(user uid: String) async -> Bool {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3); bili_ticket=\(cachedBiliTicket)",
            "referer": "https://message.bilibili.com/", // rdar://gh/SocialSisterYi/bilibili-API-collect/issues/631#issuecomment-2099276628
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        if case let .success(json) = await DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation?fid=\(uid)", headers: headers) {
            if !CheckBApiError(from: json) { return false }
            if json["data"]["attribute"].int ?? 0 == 2 || json["data"]["attribute"].int ?? 0 == 6 {
                return true
            }
        }
        return false
    }
    
    func currentUserExperience() async -> (current: Int, next: Int, min: Int)? {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3); bili_ticket=\(cachedBiliTicket)",
            "referer": "https://message.bilibili.com/", // rdar://gh/SocialSisterYi/bilibili-API-collect/issues/631#issuecomment-2099276628
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        if case let .success(json) = await DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/nav", headers: headers) {
            if !CheckBApiError(from: json) { return nil }
            let currentExp = json["data"]["level_info"]["current_exp"].int ?? 0
            let nextExp = json["data"]["level_info"]["next_exp"].int ?? 0
            let minExp = json["data"]["level_info"]["current_min"].int ?? 0
            return (currentExp, nextExp, minExp)
        }
        return nil
    }
}
