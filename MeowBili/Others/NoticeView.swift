//
//
//  NoticeView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import DarockFoundation

struct NoticeView: View {
    @State var noticeDetail = ""
    var body: some View {
        List {
            Text(noticeDetail)
                .bold()
        }
        .onAppear {
            requestString("https://fapi.darock.top:65535/bili/notice/detail") { respStr, isSuccess in
                if isSuccess {
                    if respStr.apiFixed() != "" {
                        noticeDetail = respStr.apiFixed().replacingOccurrences(of: "\\n", with: "\n")
                    } else {
                        requestString("https://fapi.darock.top:65535/bili/notice") { respStr, isSuccess in
                            if isSuccess {
                                noticeDetail = respStr.apiFixed()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
