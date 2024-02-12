//
//
//  ArticleView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
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

import WebKit
import SwiftUI
import DarockKit
import SwiftSoup

struct ArticleView: View {
    var cvid: String
    var body: some View {
        WebView(url: URL(string: "https://www.bilibili.com/read/cv\(cvid)")!)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(cvid: "24554473")
    }
}
