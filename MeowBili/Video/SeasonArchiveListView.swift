//
//
//  SeasonArchiveListView.swift
//  DarockBili
//
//  Created by memz233 on 10/13/24.
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
import Alamofire
import SwiftyJSON
import DarockFoundation

struct SeasonArchiveListView: View {
    var mid: String
    var seasonID: String
    var username: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("CachedBiliTicket") var cachedBiliTicket = ""
    @State var backgroundImageUrl: URL?
    @State var seasonName = ""
    @State var videos = [[String: String]]()
    @State var currentPage = 1
    @State var totalPage = 1
    var body: some View {
        List {
            if !videos.isEmpty {
                Section {
                    ForEach(0..<videos.count, id: \.self) { i in
                        VideoCard(["Pic": videos[i]["PicUrl"]!, "Title": videos[i]["Title"]!, "BV": videos[i]["BV"]!, "UP": username, "View": videos[i]["PlayCount"]!, "Danmaku": "1"])
                    }
                }
                // Pager
                Section {
                    HStack {
                        if currentPage != 1 {
                            Button(action: {
                                currentPage -= 1
                                refresh()
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .bold()
                            })
                            // rdar://so?56576298
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle(radius: 0))
                            .frame(width: 30)
                        }
                        Spacer()
                        Text("\(currentPage) / \(totalPage)")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                        if currentPage != totalPage {
                            Button(action: {
                                currentPage += 1
                                refresh()
                            }, label: {
                                Image(systemName: "chevron.right")
                                    .bold()
                            })
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle(radius: 0))
                            .frame(width: 30)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .listRowBackground(Color.clear)
            } else {
                ProgressView()
            }
        }
        #if os(watchOS)
        .modifier(BlurBackground(imageUrl: backgroundImageUrl))
        #endif
        .navigationTitle(seasonName)
        .onAppear {
            refresh()
        }
    }
    
    func refresh() {
        let headers: HTTPHeaders = [
            "Cookie": "SESSDATA=\(sessdata); buvid_fp=e651c1a382430ea93631e09474e0b395; buvid3=\(UuidInfoc.gen()); buvid4=buvid4-failed-1; bili_ticket=\(cachedBiliTicket)",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1 Safari/605.1.15"
        ]
        biliWbiSign(paramEncoded: "mid=\(mid)&season_id=\(seasonID)&page_num=\(currentPage)&page_size=20".base64Encoded()) { signed in
            if let signed {
                requestJSON("https://api.bilibili.com/x/polymer/web-space/seasons_archives_list?\(signed)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        if !CheckBApiError(from: respJson) { return }
                        backgroundImageUrl = URL(string: respJson["data"]["meta"]["cover"].string ?? "E")
                        seasonName = respJson["data"]["meta"]["name"].string ?? "[加载失败]"
                        videos.removeAll()
                        for video in respJson["data"]["archives"] {
                            videos.append(["Title": video.1["title"].string ?? "[加载失败]", "PlayCount": String(video.1["stat"]["view"].int ?? -1), "PicUrl": video.1["pic"].string ?? "E", "BV": video.1["bvid"].string ?? "E"])
                        }
                        totalPage = Int((respJson["data"]["page"]["total"].int ?? 0) / 20) + 1
                    }
                }
            }
        }
    }
}
