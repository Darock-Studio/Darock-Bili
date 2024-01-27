//
//
//  Bangumi.swift
//  DarockBili Watch App
//
//  Created by memz233 on 2024/1/24.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Foundation

struct BangumiData {
    var mediaId: Int64
    var seasonId: Int64
    var title: String
    var originalTitle: String
    var cover: String
    var area: String?
    var style: String?
    var cvs: [String]?
    var staffs: [String]?
    var description: String?
    var pubtime: Int?
    var eps: [BangumiEp]?
    var score: Score?
    var isFollow: Bool = false
    
    struct Score {
        var userCount: Int
        var score: Float
    }
}

struct BangumiEp: Identifiable, Hashable {
    var id: Int64
    
    var aid: Int64?
    var epid: Int64
    var cid: Int64?
    var cover: String
    var title: String
    var indexTitle: String?
    var longTitle: String
    
    init(aid: Int64? = nil, epid: Int64, cid: Int64? = nil, cover: String, title: String, indexTitle: String? = nil, longTitle: String) {
        self.id = epid
        self.aid = aid
        self.epid = epid
        self.cid = cid
        self.cover = cover
        self.title = title
        self.indexTitle = indexTitle
        self.longTitle = longTitle
    }
}

struct BangumiPayment {
    var discount: Int
    var tip: String
    var promotion: String
}
