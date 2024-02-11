//
//
//  HistoryView.swift
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

struct HistoryView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var histories = [Any]()
    @State var isLoaded = false
    @State var hasData = true
    @State var nowPage = 1
    @State var totalPage = 1
    var body: some View {
        List {
            if histories.count != 0 {
                ForEach(0...histories.count - 1, id: \.self) { i in
                    if (histories[i] as! [String: Any])["Type"]! as! String == "archive" {
                        VideoCard(histories[i] as! [String: String])
                            .swipeActions {
                                Button(role: .destructive, action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata);",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    AF.request("https://api.bilibili.com/x/v2/history/delete?kid=archive_\(bv2av(bvid: (histories[i] as! [String: String])["BV"]!))&csrf=\(biliJct)", method: .post, headers: headers).response { response in
                                        debugPrint(response)
                                    }
                                }, label: {
                                    Image(systemName: "xmark.bin.fill")
                                })
                            }
                    } else if (histories[i] as! [String: Any])["Type"]! as! String == "pgc" {
                        BangumiCard((histories[i] as! [String: Any])["Data"] as! BangumiData)
                            .swipeActions {
                                Button(role: .destructive, action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata);",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    AF.request("https://api.bilibili.com/x/v2/history/delete?kid=pgc_\(((histories[i] as! [String: Any])["Data"] as! BangumiData).seasonId)&csrf=\(biliJct)", method: .post, headers: headers).response { response in
                                        debugPrint(response)
                                    }
                                }, label: {
                                    Image(systemName: "xmark.bin.fill")
                                })
                            }
                    }
                }
            } else {
                if hasData {
                    ProgressView()
                } else {
                    HStack {
                        Spacer(minLength: 0)
                        Image(systemName: "xmark.bin.fill")
                        Text("History.none")
                        Spacer(minLength: 0)
                    }
                    .padding()
                }
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
                        if !CheckBApiError(from: respJson) { return }
                        let datas = respJson["data"]
                        if datas[0]["business"].string == nil {
                            hasData = false
                            isLoaded = true
                            return
                        }
                        for data in datas {
                            let type = data.1["business"].string ?? "archive"
                            if type == "archive" {
                                histories.append(["Type": type, "Pic": data.1["pic"].string!, "Title": data.1["title"].string!, "UP": data.1["owner"]["name"].string!, "Device": String(data.1["device"].int!), "BV": data.1["bvid"].string!, "View": String(data.1["stat"]["view"].int!), "Danmaku": String(data.1["stat"]["danmaku"].int!)])
                            } else if type == "pgc" {
                                histories.append(["Type": type, "Data": BangumiData(mediaId: data.1["bangumi"]["ep_id"].int64 ?? 0, seasonId: data.1["bangumi"]["season"]["season_id"].int64 ?? 0, title: data.1["bangumi"]["long_title"].string ?? "[加载失败]", originalTitle: data.1["bangumi"]["season"]["title"].string ?? "[加载失败]", cover: data.1["bangumi"]["cover"].string ?? "E")])
                            }
                        }
                        hasData = true
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
