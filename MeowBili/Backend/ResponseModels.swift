//
//
//  ResponseModels.swift
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

import Foundation
import SwiftyJSON

struct UserInfo: Identifiable {
    let id: Int64
    let sex: String
    let level: Int
    let coins: Double
    let face: String
    let vip: VIPDetail?
    let birthday: String
    let official: OfficialDetail
    let name: String
    let sign: String
    
    init(json: JSON) {
        self.id = json["data"]["mid"].int64Value
        self.sex = json["data"]["sex"].string/
        self.level = json["data"]["level"].int ?? 0
        self.coins = json["data"]["coins"].double ?? -1
        self.face = json["data"]["face"].string/
        if json["data"]["vip"].dictionary != nil {
            self.vip = .init(json: json["data"]["vip"])
        } else {
            self.vip = nil
        }
        self.birthday = json["data"]["birthday"].string ?? "01-01"
        self.official = .init(json: json["data"]["official"])
        self.name = json["data"]["name"].string/
        self.sign = json["data"]["sign"].string/
    }
    
    struct VIPDetail {
        let label: Label
        
        init(json: JSON) {
            self.label = .init(json: json["label"])
        }
        
        struct Label {
            let text: String
            
            init(json: JSON) {
                self.text = json["text"].string/
            }
        }
    }
    struct OfficialDetail {
        let title: String
        let desc: String
        let role: Int
        let type: Int
        
        init(json: JSON) {
            self.title = json["title"].string/
            self.desc = json["desc"].string/
            self.role = json["role"].int ?? 0
            self.type = json["type"].int ?? 0
        }
    }
}

struct UserRelation {
    let following: Int
    let follower: Int
    
    init(json: JSON) {
        self.following = json["following"].int ?? -1
        self.follower = json["follower"].int ?? -1
    }
}
