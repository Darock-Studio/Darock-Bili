//
//  BangumiDetailView.swift
//  DarockBili Watch App
//
//  Created by 雷美淳 on 2024/1/13.
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

import SwiftUI

struct BangumiDetailView: View {
    var bangumiData: BangumiData
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    BangumiDetailView(bangumiData: BangumiData(mediaId: 28224080, seasonId: 29310, title: "异度侵入 ID:INVADED", originalTitle: "イド：インヴェイデッド", cover: "https://i0.hdslb.com/bfs/bangumi/image/9bf9e66968f85b33ec3769a16c86b36dc984abbc.png", area: "日本", style: "原创/科幻/推理", cvs: ["酒井户：津田健次郎", "百贵：细谷佳正", "富久田：竹内良太", "本堂町：M・A・O", "东乡：布里德卡特·塞拉·惠美", "早濑浦：村治学", "白岳：近藤隆", "羽二重：岩濑周平", "若鹿：榎木淳弥", "国府：加藤涉", "西村：落合福嗣", "松冈：西凛太朗"], staffs: ["监督：青木英", "脚本：舞城王太郎", "角色原案：小玉有起", "角色设计：碇谷敦", "美术：曽野由大", "作画监督：又贺大介", "副监督：久保田雄大", "色彩设计：千叶絵美", "动画制作：NAZ"], description: "本片讲述利用能检测出人们杀意的装置以及利用思想粒子做出的“井”，来探知事件真相的科幻故事。", pubtime: 1578240000))
}
