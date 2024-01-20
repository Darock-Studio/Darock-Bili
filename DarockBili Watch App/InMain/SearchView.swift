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
import AuthenticationServices

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
    @State var articles = [[String: String]]()
    @State var bangumis = [[String: String]]()
    @State var liverooms = [String: String]()
    @State var isUserDetailPresented = [Bool]()
    @State var isLoaded = false
    @State var debugResponse = ""
    @State var searchType = SearchType.video
    var body: some View {
        ScrollView {
            VStack {
                Picker("搜索类型", selection: $searchType) {
                    Text("视频").tag(SearchType.video)
                    Text("用户").tag(SearchType.user)
                    Text("专栏").tag(SearchType.article)
                    Text("番剧").tag(SearchType.bangumi)
                    Text("直播").tag(SearchType.liveRoom)
                }
                .pickerStyle(.navigationLink)
                .onChange(of: searchType) { value in
                    NewSearch(keyword: keyword, type: value, clear: true)
                }
                Divider()
                if searchType == .video {
                    if videos.count != 0 {
                        ForEach(0...videos.count - 1, id: \.self) { i in
                            VideoCard(videos[i])
                        }
                    } else if debugResponse != "" {
                        Text("似乎在搜索时遇到了一些问题，以下是详细信息")
                        Text(debugResponse)
                    }
                } else if searchType == .user {
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
                    } else if debugResponse != "" {
                        Text("似乎在搜索时遇到了一些问题，以下是详细信息")
                        Text(debugResponse)
                    }
                } else if searchType == .article {
                    if articles.count != 0 {
                        ForEach(0..<articles.count, id: \.self) { i in
                            Button(action: {
                                let session = ASWebAuthenticationSession(url: URL(string: "https://www.bilibili.com/read/cv\(articles[i]["CV"]!)")!, callbackURLScheme: nil) { _, _ in
                                    return
                                }
                                session.prefersEphemeralWebBrowserSession = true
                                session.start()
                            }, label: {
                                VStack {
                                    Text(articles[i]["Title"]!)
                                        .font(.system(size: 16, weight: .bold))
                                        .lineLimit(3)
                                    HStack {
                                        VStack {
                                            Text(articles[i]["Summary"]!)
                                                .font(.system(size: 10, weight: .bold))
                                                .lineLimit(3)
                                                .foregroundColor(.gray)
                                            HStack {
                                                Text(articles[i]["Type"]!)
                                                    .font(.system(size: 10))
                                                    .lineLimit(1)
                                                    .foregroundColor(.gray)
                                                Label(articles[i]["View"]!, systemImage: "eye.fill")
                                                    .font(.system(size: 10))
                                                    .lineLimit(1)
                                                    .foregroundColor(.gray)
                                                Label(articles[i]["Like"]!, systemImage: "hand.thumbsup.fill")
                                                    .font(.system(size: 10))
                                                    .lineLimit(1)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        WebImage(url: URL(string: articles[i]["Pic"]! + "@60w"), options: [.progressiveLoad])
                                            .cornerRadius(5)
                                    }
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 14))
                        }
                    } else if debugResponse != "" {
                        Text("似乎在搜索时遇到了一些问题，以下是详细信息")
                        Text(debugResponse)
                    }
                }
                progressView()
            }
        }
        .onAppear {
            if !isLoaded {
                NewSearch(keyword: keyword, type: searchType)
            }
        }
    }

    func NewSearch(keyword: String, type: SearchType, page: Int = 1, clear: Bool = false) {
        debugResponse = ""
        if clear {
            debugResponse = ""
            videos.removeAll()
            users.removeAll()
            articles.removeAll()
            bangumis.removeAll()
            liverooms.removeAll()
        }
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
            "cookie": "SESSDATA=\(sessdata); bili_jct=\(biliJct); DedeUserID=\(dedeUserID); DedeUserID__ckMd5=\(dedeUserID__ckMd5); buvid3=\(globalBuvid3); buvid4=\(globalBuvid4)"
        ]
        biliWbiSign(paramEncoded: "keyword=\(keyword)&search_type=\(type.rawValue)&page=\(page)".base64Encoded()) { signed in
            if let signed {
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/wbi/search/type?\(signed)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        if !CheckBApiError(from: respJson) { return }
                        let result = respJson["data"]["result"]
                        switch type {
                        case .video:
                            for video in result {
                                videos.append(["Pic": "https:" + video.1["pic"].string ?? "E", "Title": (video.1["title"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "View": String(video.1["play"].int ?? -1), "Danmaku": String(video.1["video_review"].int ?? -1), "UP": video.1["author"].string ?? "[加载失败]", "BV": video.1["bvid"].string ?? "E"])
                            }
                        case .user:
                            for user in result {
                                isUserDetailPresented.append(false)
                                users.append(["Name": user.1["uname"].string ?? "[加载失败]", "Pic": "https:" + (user.1["upic"].string ?? "E"), "ID": String(user.1["mid"].int ?? -1), "Fans": String(user.1["fans"].int ?? -1), "VideoCount": String(user.1["videos"].int ?? -1), "Videos": { () -> [[String: String]] in
                                    var tVideos = [[String: String]]()
                                    for video in user.1["res"] {
                                        tVideos.append(["Pic": "https:" + (video.1["pic"].string ?? "E"), "Title": video.1["title"].string ?? "[加载失败]", "BV": video.1["bvid"].string ?? "E", "UP": user.1["uname"].string ?? "[加载失败]", "View": video.1["play"].string ?? "-1", "Danmaku": String(video.1["dm"].int ?? -1)])
                                    }
                                    return tVideos
                                }()])
                            }
                        case .article:
                            for article in result {
                                articles.append(["Title": (article.1["title"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "Summary": article.1["desc"].string ?? "[加载失败]", "Type": article.1["category_name"].string ?? "[加载失败]", "View": String(article.1["view"].int ?? -1), "Like": String(article.1["like"].int ?? -1), "Pic": article.1["image_urls"][0].string ?? "E", "CV": String(article.1["id"].int ?? 0)])
                            }
                        case .bangumi:
                            break
                        case .liveRoom:
                            break
                        }
                        debugResponse = respJson.debugDescription
                    } else {
                        debugResponse = "请检查您的网络连接状态"
                    }
                }
            }
        }
        isLoaded = true
    }
    enum SearchType: String {
        case video = "video"
        case bangumi = "media_bangumi"
        case liveRoom = "live_room"
        case article = "article"
        case user = "bili_user"
    }
    
    @ViewBuilder func progressView() -> some View {
        let showError: Bool = {
            if debugResponse.isEmpty { //这样是加载中或加载成功
                return !(users.isEmpty || videos.isEmpty || articles.isEmpty || bangumis.isEmpty || liverooms.isEmpty) //两个都没有的话那肯定是加载中了，否则就是加载成功了
            } else { //加载失败，有错误信息，不需要ProgressView
                return false
            }
        }()
        if showError {
            ProgressView()
                .padding(.top)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchView(keyword: "Darock")
        SearchMainView()
    }
}
