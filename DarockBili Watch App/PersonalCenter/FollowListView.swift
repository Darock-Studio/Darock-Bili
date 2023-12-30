//
//  FollowListView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/1.
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
import SDWebImageSwiftUI

struct FollowListView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    var viewUserId: String
    @State var users = [[String: String]]()
    @State var nowPage = 1
    @State var totalPage = 1
    @State var isLoadedFollows = false
    @State var isLoadingNew = false
    @State var pinnedUsers = [String]()
    var body: some View {
        List {
            if users.count != 0 {
                Section {
                    ForEach(0...users.count - 1, id: \.self) { i in
                        NavigationLink(destination: {UserDetailView(uid: users[i]["UID"]!)}, label: {
                            HStack {
                                if pinnedUsers.contains(users[i]["UID"]!) {
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(.gray)
                                }
                                WebImage(url: URL(string: users[i]["Face"]! + "@28w"), options: [.progressiveLoad])
                                    .cornerRadius(100)
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
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(action: {
                                if pinnedUsers.contains(users[i]["UID"]!) {
                                    for j in 0..<pinnedUsers.count {
                                        if pinnedUsers[j] == users[i]["UID"]! {
                                            pinnedUsers.remove(at: j)
                                            break
                                        }
                                    }
                                } else {
                                    pinnedUsers.append(users[i]["UID"]!)
                                    let ud = users.remove(at: i)
                                    users.insert(ud, at: 0)
                                }
                                UserDefaults.standard.set(pinnedUsers, forKey: "PinnedFollows")
                            }, label: {
                                if pinnedUsers.contains(users[i]["UID"]!) {
                                    Image(systemName: "pin.slash.fill")
                                } else {
                                    Image(systemName: "pin.fill")
                                }
                            })
                        }
                    }
                }
            } else {
                ProgressView()
            }
            if nowPage < totalPage {
                Section {
                    if !isLoadingNew {
                        Button(action: {
                            isLoadingNew = true
                            nowPage += 1
                            RefreshNew()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("继续加载")
                                Spacer()
                            }
                        })
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .navigationTitle("关注")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            pinnedUsers = UserDefaults.standard.stringArray(forKey: "PinnedFollows") ?? [String]()
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
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/followings?vmid=\(viewUserId)&order_type=&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                let datas = respJson["data"]["list"]
                for data in datas {
                    if pinnedUsers.contains(String(data.1["mid"].int ?? 0)) {
                        users.insert(["Name": data.1["uname"].string ?? "[加载失败]", "Face": data.1["face"].string ?? "E", "Sign": data.1["sign"].string ?? "[加载失败]", "UID": String(data.1["mid"].int64 ?? 0)], at: 0)
                    } else {
                        users.append(["Name": data.1["uname"].string ?? "[加载失败]", "Face": data.1["face"].string ?? "E", "Sign": data.1["sign"].string ?? "[加载失败]", "UID": String(data.1["mid"].int64 ?? 0)])
                    }
                }
                totalPage = respJson["data"]["total"].int ?? 0 / 20 + 1
                isLoadingNew = false
            }
        }
    }
}

struct FollowListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowListView(viewUserId: "356891781")
    }
}
