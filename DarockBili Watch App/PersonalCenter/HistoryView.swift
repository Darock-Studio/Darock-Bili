//
//  HistoryView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/3.
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
import DarockKit
import Alamofire
import SwiftyJSON

struct HistoryView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var histories = [[String: String]]()
    @State var isLoaded = false
    @State var nowPage = 1
    @State var totalPage = 1
    var body: some View {
        List {
            if histories.count != 0 {
                ForEach(0...histories.count - 1, id: \.self) { i in
                    VideoCard(histories[i])
//                    HStack {
//                        switch Int(histories[i]["Device"]!)! {
//                        case 1, 3, 5, 7:
//                            Image(systemName: "iphone")
//                                .resizable()
//                                .frame(width: 10, height: 16)
//                        case 2:
//                            Image(systemName: "desktopcomputer")
//                                .resizable()
//                                .frame(width: 16, height: 10)
//                        case 4, 6:
//                            Image(systemName: "ipad.landscape")
//                                .resizable()
//                                .frame(width: 16, height: 10)
//                        case 33:
//                            Image(systemName: "tv")
//                                .resizable()
//                                .frame(width: 16, height: 10)
//                        default:
//                            Image(systemName: "iphone")
//                                .resizable()
//                                .frame(width: 10, height: 16)
//                        }
//                        Spacer()
//                    }
//                    .foregroundColor(.gray)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if !isLoaded {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata);",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/history", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        let datas = respJson["data"]
                        for data in datas {
                            histories.append(["Type": data.1["business"].string!, "Pic": data.1["pic"].string!, "Title": data.1["title"].string!, "UP": data.1["owner"]["name"].string!, "Device": String(data.1["device"].int!), "BV": data.1["bvid"].string!, "View": String(data.1["stat"]["view"].int!), "Danmaku": String(data.1["stat"]["danmaku"].int!)])
                        }
                        isLoaded = true
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
