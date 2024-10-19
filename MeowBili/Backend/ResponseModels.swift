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
    let coins: Double?
    let face: String
    let vip: VIPDetail?
    let birthday: String
    let official: OfficialDetail?
    let name: String
    let sign: String
    
    init(json: JSON) {
        self.id = json["mid"].int64Value
        self.sex = json["sex"].string/
        self.level = json["level"].int ?? 0
        self.coins = json["coins"].double ?? 0
        self.face = json["face"].string/
        if json["vip"].dictionary != nil {
            self.vip = .init(json: json["vip"])
        }
        self.birthday = json["birthday"].string ?? "01-01"
        if json["official"].dictionary != nil {
            self.official = .init(json: json["official"])
        }
        self.name = json["name"].string/
        self.sign = json["sign"].string/
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
