//
//  SearchView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/1.
//

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
    var body: some View {
        //NavigationStack {
            List {
                if videos.count != 0 {
                    ForEach(0...videos.count - 1, id: \.self) { i in
                        VideoCard(videos[i])
                    }
                }
            }
        //}
        .onAppear {
            AF.request("bilibili.com").response { response in
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
                    "cookie": "SESSDATA=\(sessdata); bili_jct=\(biliJct); DedeUserID=\(dedeUserID); DedeUserID__ckMd5=\(dedeUserID__ckMd5)"
                ]
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/search/all/v2?keyword=\(keyword)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        let videoDatas = respJson["data"]["result"][11]["data"]
                        debugPrint(videoDatas)
                        for video in videoDatas {
                            videos.append(["Pic": "https:" + video.1["pic"].string!, "Title": video.1["title"].string!.replacingOccurrences(of: "<em class=\"keyword\">", with: "").replacingOccurrences(of: "</em>", with: ""), "View": String(video.1["play"].int!), "Danmaku": String(video.1["danmaku"].int!), "UP": video.1["author"].string!, "BV": video.1["bvid"].string!])
                        }
                    }
                }
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
