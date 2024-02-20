//
//
//  SearchView.swift
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

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import AuthenticationServices
#if !os(visionOS)
import SDWebImageSwiftUI
#endif
#if os(watchOS)
import WatchKit
#endif

struct SearchMainView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var searchText = ""
    @State var isSearchPresented = false
    @State var searchHistory = [String]()
    @State var suggestions = [String]()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack {
                        NavigationLink("", destination: SearchView(keyword: searchText), isActive: $isSearchPresented)
                            .frame(width: 0, height: 0)
                            .hidden()
                        TextField("Search.\(Image(systemName: "magnifyingglass"))", text: $searchText)
                            .submitLabel(.search)
                            .onSubmit {
                                isSearchPresented = true
                                if searchText != (searchHistory.first ?? "") {
                                    UserDefaults.standard.set([searchText] + searchHistory, forKey: "SearchHistory")
                                }
                            }
                            .onDisappear {
                                searchText = ""
                            }
                            .onChange(of: searchText) { value in
                                if value != "" {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3);",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    DarockKit.Network.shared.requestJSON("https://s.search.bilibili.com/main/suggest", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            suggestions.removeAll()
                                            for result in respJson["result"]["tag"] {
                                                if let v = result.1["value"].string {
                                                    suggestions.append(v)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    if debug {
                        Button(action: {
                            searchText = "Darock"
                            isSearchPresented = true
                        }, label: {
                            Text("Search.debug")
                        })
                        .accessibilityIdentifier("SearchDebugButton")
                    }
                }
                if searchHistory.count != 0 {
                    Section(header: Text("Search.history")) {
                        ForEach(0...searchHistory.count - 1, id: \.self) { i in
                            NavigationLink(destination: {SearchView(keyword: searchHistory[i])}, label: {
                                Text(searchHistory[i])
                            })
                            .swipeActions {
                                Button(role: .destructive, action: {
                                    searchHistory.remove(at: i)
                                    UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            }
                        }
                    }
                }
            }
            .onAppear {
                searchHistory.removeAll()
                searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? [String]()
            }
            .searchSuggestions {
                if suggestions.count != 0 {
                    
                }
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
    @State var bangumis = [BangumiData]()
    @State var liverooms = [[String: String]]()
    @State var isUserDetailPresented = [Bool]()
    @State var isLoaded = false
    @State var searchType = SearchType.video
    @State var isNoResult = false
    var body: some View {
        ScrollView {
            VStack {
                // FIXME: Wtf is Apple doing? It shows a really fking bad view when the selecter presents.
                Picker("Search.type", selection: $searchType) {
                    Text("Search.type.video").tag(SearchType.video)
                    Text("Search.type.user").tag(SearchType.user)
                    Text("Search.type.article").tag(SearchType.article)
                    Text("Search.type.bangumi").tag(SearchType.bangumi)
                    Text("Search.type.live").tag(SearchType.liveRoom)
                }
                #if os(watchOS)
                .pickerStyle(.navigationLink)
                .buttonBorderShape(.roundedRectangle(radius: 16))
                #endif
                .onChange(of: searchType) { value in
                    NewSearch(keyword: keyword, type: value, clear: true)
                }
                Divider()
                Group {
                    if searchType == .video {
                        if videos.count != 0 {
                            ForEach(0...videos.count - 1, id: \.self) { i in
                                VideoCard(videos[i])
                            }
                        } else if isNoResult {
                            Text("Search.no-result")
                        }
                    } else if searchType == .user {
                        if users.count != 0 {
                            ForEach(0..<users.count, id: \.self) { i in
                                VStack {
                                    HStack {
                                        #if !os(visionOS)
                                        WebImage(url: URL(string: users[i]["Pic"]! as! String + "@30w"), options: [.progressiveLoad])
                                            .clipShape(Circle())
                                        #else
                                        AsyncImage(url: URL(string: users[i]["Pic"]! as! String + "@30w"))
                                            .clipShape(Circle())
                                        #endif
                                        VStack {
                                            NavigationLink("", isActive: $isUserDetailPresented[i], destination: {UserDetailView(uid: users[i]["ID"]! as! String)})
                                                .frame(width: 0, height: 0)
                                            HStack {
                                                Text(users[i]["Name"]! as! String)
                                                    .font(.system(size: 14, weight: .bold))
                                                    .lineLimit(1)
                                            }
                                            Text("Account.videos.\(Int(users[i]["VideoCount"]! as! String) ?? 0)")
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
                        } else if isNoResult {
                            Text("Search.no-result")
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
                                            #if !os(visionOS)
                                            WebImage(url: URL(string: articles[i]["Pic"]! + "@60w"), options: [.progressiveLoad])
                                                .cornerRadius(5)
                                            #else
                                            AsyncImage(url: URL(string: articles[i]["Pic"]! + "@60w"))
                                                .cornerRadius(5)
                                            #endif
                                        }
                                    }
                                })
                                .buttonBorderShape(.roundedRectangle(radius: 14))
                            }
                        } else if isNoResult {
                            Text("Search.no-result")
                        }
                    } else if searchType == .bangumi {
                        if bangumis.count != 0 {
                            ForEach(0..<bangumis.count, id: \.self) { i in
                                BangumiCard(bangumis[i])
                            }
                        } else if isNoResult {
                            Text("Search.no-result")
                        }
                    } else if searchType == .liveRoom {
                        if liverooms.count != 0 {
                            ForEach(0..<liverooms.count, id: \.self) { i in
                                LiveCard(liverooms[i])
                            }
                        } else if isNoResult {
                            Text("Search.no-result")
                        }
                    }
                }
                .padding(.horizontal)
                if videos.isEmpty && users.isEmpty && articles.isEmpty && bangumis.isEmpty && liverooms.isEmpty && !isNoResult {
                    ProgressView()
                }
            }
        }
        .onAppear {
            if !isLoaded {
                NewSearch(keyword: keyword, type: searchType)
            }
        }
    }

    func NewSearch(keyword: String, type: SearchType, page: Int = 1, clear: Bool = false) {
        // It takes a long period of time when changing search type and re-request,
        // only gods know why, so we must make it async.
        DispatchQueue.global().async {
            if clear {
                isNoResult = false
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
                "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.30 Safari/537.36 Edge/84.0.522.11",
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
                            if (respJson["data"]["numResults"].int ?? -1) == 0 {
                                isNoResult = true
                                return
                            }
                            let result = respJson["data"]["result"]
                            switch type {
                            case .video:
                                for video in result {
                                    videos.append(["Pic": "https:" + (video.1["pic"].string ?? "E"), "Title": (video.1["title"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "View": String(video.1["play"].int ?? -1), "Danmaku": String(video.1["video_review"].int ?? -1), "UP": video.1["author"].string ?? "[加载失败]", "BV": video.1["bvid"].string ?? "E"])
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
                                    articles.append(["Title": (article.1["title"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "Summary": article.1["desc"].string ?? "[加载失败]", "Type": article.1["category_name"].string ?? "[加载失败]", "View": String(article.1["view"].int ?? -1), "Like": String(article.1["like"].int ?? -1), "Pic": "https:" + (article.1["image_urls"][0].string ?? "E"), "CV": String(article.1["id"].int ?? 0)])
                                }
                            case .bangumi:
                                for bangumi in result {
                                    if (bangumi.1["type"].string ?? "") == "media_bangumi" {
                                        bangumis.append(BangumiData(mediaId: bangumi.1["media_id"].int64 ?? 0, seasonId: bangumi.1["season_id"].int64 ?? 0, title: (bangumi.1["title"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), originalTitle: bangumi.1["org_title"].string ?? "[加载失败]", cover: /*"https:" + */(bangumi.1["cover"].string ?? "E"), area: bangumi.1["areas"].string ?? "[加载失败]", style: bangumi.1["styles"].string ?? "[加载失败]", cvs: (bangumi.1["cv"].string ?? "[加载失败]").split(separator: "\\n").map { String($0) }, staffs: (bangumi.1["staff"].string ?? "[加载失败]").split(separator: "\\n").map { String($0) }, description: bangumi.1["desc"].string ?? "[加载失败]", pubtime: bangumi.1["pubtime"].int ?? 0, eps: { () -> [BangumiEp] in
                                            let eps = bangumi.1["eps"]
                                            var tmp = [BangumiEp]()
                                            for ep in eps {
                                                tmp.append(BangumiEp(epid: ep.1["id"].int64 ?? 0, cover: ep.1["cover"].string ?? "E", title: ep.1["title"].string ?? "[加载失败]", indexTitle: ep.1["index_title"].string ?? "[加载失败]", longTitle: ep.1["long_title"].string ?? "[加载失败]"))
                                            }
                                            return tmp
                                        }(), score: { () -> BangumiData.Score? in
                                            if let score = bangumi.1["media_score"]["score"].float {
                                                return .init(userCount: bangumi.1["media_score"]["user_count"].int ?? 0, score: score)
                                            } else {
                                                return nil
                                            }
                                        }(), isFollow: Bool(bangumi.1["is_follow"].int ?? 0)))
                                    }
                                }
                            case .liveRoom:
                                for liveRoom in result {
                                    liverooms.append(["Cover": "https:" + (liveRoom.1["user_cover"].string ?? "E"), "Title": (liveRoom.1["title"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "ID": String(liveRoom.1["roomid"].int ?? 0), "Type": (liveRoom.1["cate_name"].string ?? "[加载失败]").replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: "")])
                                }
                            }
                        }
                    }
                }
            }
            isLoaded = true
        }
    }
    enum SearchType: String {
        case video = "video"
        case bangumi = "media_bangumi"
        case liveRoom = "live_room"
        case article = "article"
        case user = "bili_user"
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchView(keyword: "Darock")
        SearchMainView()
    }
}
