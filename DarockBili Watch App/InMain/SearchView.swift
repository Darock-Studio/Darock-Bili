//
//  SearchView.swift
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

struct SearchMainView: View {
    @State var searchText = ""
    @State var isSearchPresented = false
    @State var searchHistory = [String]()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("\(Image(systemName: "magnifyingglass")) 搜索...", text: $searchText)
                        .onSubmit {
                            isSearchPresented = true
                            UserDefaults.standard.set([searchText] + (UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? [String]()), forKey: "SearchHistory")
                        }
                        .sheet(isPresented: $isSearchPresented, content: {NavigationStack { SearchView(keyword: searchText) }})
                        .onDisappear {
                            searchText = ""
                        }
                        .accessibilityIdentifier("SearchInput")
                    if debug {
                        Button(action: {
                            searchText = "Darock"
                            isSearchPresented = true
                        }, label: {
                            Text("Debug Search")
                        })
                        .accessibilityIdentifier("SearchDebugButton")
                    }
                }
                if searchHistory.count != 0 {
                    Section(header: Text("历史记录")) {
                        ForEach(0...searchHistory.count - 1, id: \.self) { i in
                            NavigationLink(destination: {SearchView(keyword: searchHistory[i])}, label: {
                                Text(searchHistory[i])
                            })
                        }
                    }
                }
            }
            .onAppear {
                searchHistory.removeAll()
                searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? [String]()
            }
        }
    }
}

struct SearchView: View {
    var keyword: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var videos = [[String: String]]()
    @State var users = [[String: Any]]()
    @State var isUserDetailPresented = [Bool]()
    @State var isLoaded = false
    @State var debugResponse = ""
    var body: some View {
        ScrollView {
            VStack {
                if users.count != 0 {
                    ForEach(0..<users.count, id: \.self) { i in
                        VStack {
                            HStack {
                                WebImage(url: URL(string: users[i]["Pic"]! as! String + "@30w"), options: [.progressiveLoad])
                                    .cornerRadius(100)
                                VStack {
                                    NavigationLink("", isActive: $isUserDetailPresented[i], destination: {UserDetailView(uid: users[i]["ID"]! as! String)})
                                        .frame(width: 0, height: 0)
                                    HStack {
                                        Text(users[i]["Name"]! as! String)
                                            .font(.system(size: 14, weight: .bold))
                                            .lineLimit(1)
                                    }
                                    Text("\(users[i]["VideoCount"]! as! String) 视频")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 5)
                            .onTapGesture {
                                isUserDetailPresented[i] = true
                            }
                            if (users[i]["Videos"]! as! Array<Dictionary<String, String>>).count != 0 {
                                ForEach(0..<(users[i]["Videos"]! as! Array<Dictionary<String, String>>).count, id: \.self) { j in
                                    VideoCard((users[i]["Videos"]! as! Array<Dictionary<String, String>>)[j])
                                        .padding(.horizontal, 5)
                                }
                                Divider()
                                Spacer()
                                    .frame(height: 20)
                            }
                        }
                    }
                }
                if videos.count != 0 {
                    ForEach(0...videos.count - 1, id: \.self) { i in
                        VideoCard(videos[i])
                    }
                } else if debugResponse != "" {
                    Text("似乎在搜索时遇到了一些问题，以下是详细信息")
                    Text(debugResponse)
                }
            }
        }
        .onAppear {
            if !isLoaded {
                debugResponse = ""
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/frontend/finger/spi") { respJson, isSuccess in
                    if isSuccess {
                        debugControlStdout += "SEARCH/FINGER/SPI SUCCEEDED: \n\(respJson.debugDescription)"
                        let headers: HTTPHeaders = [
                            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                            "accept-encoding": "gzip, deflate, br",
                            "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
                            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.30 Safari/537.36 Edg/84.0.522.11",
                            "sec-fetch-dest": "document",
                            "sec-fetch-mode": "navigate",
                            "sec-fetch-site": "none",
                            "sec-fetch-user": "?1",
                            "upgrade-insecure-requests": "1",
                            "referer": "https://www.bilibili.com/",
                            "cookie": "SESSDATA=\(sessdata); bili_jct=\(biliJct); DedeUserID=\(dedeUserID); DedeUserID__ckMd5=\(dedeUserID__ckMd5); buvid3=\(respJson["data"]["b_3"].string ?? ""); buvid4=\(respJson["data"]["b_4"].string ?? "")"
                        ]
                        biliWbiSign(paramEncoded: "keyword=\(keyword)".base64Encoded()) { signed in
                            if let signed {
                                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/wbi/search/all/v2?\(signed)", headers: headers) { respJson, isSuccess in
                                    if isSuccess {
                                        debugPrint(respJson)
                                        debugControlStdout += "SEARCH/ALL/V2 SUCCEEDED: \n\(respJson.debugDescription)"
                                        let userDatas = respJson["data"]["result"][8]["data"]
                                        for user in userDatas {
                                            isUserDetailPresented.append(false)
                                            users.append(["Name": user.1["uname"].string ?? "[加载失败]", "Pic": "https:" + (user.1["upic"].string ?? "E"), "ID": String(user.1["mid"].int ?? -1), "Fans": String(user.1["fans"].int ?? -1), "VideoCount": String(user.1["videos"].int ?? -1), "Videos": { () -> [[String: String]] in
                                                var tVideos = [[String: String]]()
                                                for video in user.1["res"] {
                                                    tVideos.append(["Pic": "https:" + (video.1["pic"].string ?? "E"), "Title": video.1["title"].string ?? "[加载失败]", "BV": video.1["bvid"].string ?? "E", "UP": user.1["uname"].string ?? "[加载失败]", "View": video.1["play"].string ?? "-1", "Danmaku": String(video.1["coin"].int ?? -1)])
                                                }
                                                return tVideos
                                            }()])
                                        }
                                        let videoDatas = respJson["data"]["result"][11]["data"]
                                        for video in videoDatas {
                                            videos.append(["Pic": "https:" + video.1["pic"].string!, "Title": video.1["title"].string!.replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "View": String(video.1["play"].int!), "Danmaku": String(video.1["danmaku"].int!), "UP": video.1["author"].string!, "BV": video.1["bvid"].string!])
                                        }
                                        debugResponse = respJson.debugDescription
                                    }
                                }
                            }
                        }
                    }
                }
                isLoaded = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchView(keyword: "Darock")
        SearchMainView()
    }
}
