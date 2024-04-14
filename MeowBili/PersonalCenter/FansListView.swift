//
//
//  FansListView.swift
//  DarockBili
//
//  Created by memz233 on 2024/4/14.
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
import SDWebImageSwiftUI

struct FansListView: View {
    var viewUserId: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var users = [[String: String]]()
    @State var nowPage = 1
    @State var totalPage = 1
    @State var isLoadedFollows = false
    @State var isLoadingNew = false
    var body: some View {
        List {
            if users.count != 0 {
                Section {
                    ForEach(0...users.count - 1, id: \.self) { i in
                        NavigationLink(destination: { UserDetailView(uid: users[i]["UID"]!) }, label: {
                            HStack {
                                WebImage(url: URL(string: users[i]["Face"]! + "@56w"), options: [.progressiveLoad])
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .clipShape(Circle())
                                VStack {
                                    HStack {
                                        Text(users[i]["Name"]!)
                                            .font(.system(size: 16))
                                            .lineLimit(2)
                                        Spacer()
                                    }
                                }
                            }
                        })
                        .onAppear {
                            if (nowPage < totalPage) && i == users.count - 1 {
                                isLoadingNew = true
                                nowPage += 1
                                RefreshNew()
                            }
                        }
                    }
                }
            } else {
                ProgressView()
            }
            if isLoadingNew {
                Section {
                    ProgressView()
                }
            }
        }
        .navigationTitle("粉丝列表")
        .navigationBarTitleDisplayMode(.large)
        .scrollIndicators(.never)
        .onAppear {
            if !isLoadedFollows {
                RefreshNew()
                isLoadedFollows = true
            }
        }
    }
    func RefreshNew() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);",
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/followers?vmid=\(viewUserId)&order_type=&ps=50&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                if !CheckBApiError(from: respJson) { return }
                let datas = respJson["data"]["list"]
                for data in datas {
                    users.append(["Name": data.1["uname"].string ?? "[加载失败]", "Face": data.1["face"].string ?? "E", "Sign": data.1["sign"].string ?? "[加载失败]", "UID": String(data.1["mid"].int64 ?? 0)])
                }
                totalPage = (respJson["data"]["total"].int ?? 0) / 50 + 1
                isLoadingNew = false
            }
        }
    }
}
