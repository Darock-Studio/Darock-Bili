//
//  NoticeView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import SwiftUI
import DarockKit

struct NoticeView: View {
    @State var noticeDetail = ""
    var body: some View {
        List {
            Text(noticeDetail)
                .bold()
        }
        .onAppear {
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/notice/detail") { respStr, isSuccess in
                if isSuccess {
                    if respStr.apiFixed() != "" {
                        noticeDetail = respStr.apiFixed()
                    } else {
                        DarockKit.Network.shared.requestString("https://api.darock.top/bili/notice") { respStr, isSuccess in
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
