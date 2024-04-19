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
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import MobileCoreServices

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
    @State var isEmptyHistoryPresented = false
    @State var selectedEmptyAction = 0
    @State var isDoingEmpty = false
    @State var searchInput = ""
    var body: some View {
        List {
            Group {
                if histories.count != 0 {
                    ForEach(0...histories.count - 1, id: \.self) { i in
                        if searchInput.isEmpty || (((histories[i] as! [String: Any])["Title"] as? String) ?? "").contains(searchInput) {
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
            #if !os(watchOS)
            .onDrop(of: [UTType.data.identifier], isTargeted: nil) { items in
                PlayHaptic(sharpness: 0.05, intensity: 0.5)
                for item in items {
                    item.loadDataRepresentation(forTypeIdentifier: UTType.data.identifier) { (data, _) in
                        if let data = data, let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String] {
                            if dict["BV"] != nil {
                                histories.insert(dict, at: 0)
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": dict["BV"]!, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { _ in }
                            }
                        }
                    }
                }
                return true
            }
            #endif
        }
        .searchable(text: $searchInput)
        .navigationTitle("历史记录")
        .navigationBarTitleDisplayMode(.inline)
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
                                histories.append(["Type": type, "Pic": data.1["pic"].string!, "Title": data.1["title"].string!, "UP": data.1["owner"]["name"].string!, "Device": String(data.1["device"].int!), "BV": data.1["bvid"].string!, "View": String(data.1["stat"]["view"].int!), "Danmaku": String(data.1["stat"]["danmaku"].int!), "ViewTime": String(data.1["view_at"].int64 ?? 0)])
                            } else if type == "pgc" {
                                histories.append(["Type": type, "Data": BangumiData(mediaId: data.1["bangumi"]["ep_id"].int64 ?? 0, seasonId: data.1["bangumi"]["season"]["season_id"].int64 ?? 0, title: data.1["bangumi"]["long_title"].string ?? "[加载失败]", originalTitle: data.1["bangumi"]["season"]["title"].string ?? "[加载失败]", cover: data.1["bangumi"]["cover"].string ?? "E"), "ViewTime": String(data.1["view_at"].int64 ?? 0)])
                            }
                        }
                        hasData = true
                        isLoaded = true
                    }
                }
            }
        }
        .toolbar {
            if #available(watchOS 10, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isEmptyHistoryPresented = true
                    }, label: {
                        Image(systemName: "arrow.up.trash.fill")
                    })
                    .sheet(isPresented: $isEmptyHistoryPresented, onDismiss: {
                        
                    }, content: {
                        NavigationStack {
                            List {
                                Section {
                                    Button(action: {
                                        selectedEmptyAction = 0
                                    }, label: {
                                        HStack {
                                            Text("上一小时")
                                                .foregroundStyle(Color.white)
                                            Spacer()
                                            if selectedEmptyAction == 0 {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(Color.blue)
                                            }
                                        }
                                    })
                                    Button(action: {
                                        selectedEmptyAction = 1
                                    }, label: {
                                        HStack {
                                            Text("今天")
                                                .foregroundStyle(Color.white)
                                            Spacer()
                                            if selectedEmptyAction == 1 {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(Color.blue)
                                            }
                                        }
                                    })
                                    Button(action: {
                                        selectedEmptyAction = 2
                                    }, label: {
                                        HStack {
                                            Text("昨天和今天")
                                                .foregroundStyle(Color.white)
                                            Spacer()
                                            if selectedEmptyAction == 2 {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(Color.blue)
                                            }
                                        }
                                    })
                                    Button(action: {
                                        selectedEmptyAction = 3
                                    }, label: {
                                        HStack {
                                            Text("所有历史记录")
                                                .foregroundStyle(Color.white)
                                            Spacer()
                                            if selectedEmptyAction == 3 {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(Color.blue)
                                            }
                                        }
                                    })
                                } header: {
                                    Text("清除时间段")
                                }
                                Section {
                                    Button(role: .destructive, action: {
                                        isDoingEmpty = true
                                        if selectedEmptyAction == 3 {
                                            let headers: HTTPHeaders = [
                                                "cookie": "SESSDATA=\(sessdata);",
                                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                            ]
                                            AF.request("https://api.bilibili.com/x/v2/history/clear", method: .post, parameters: ["csrf": biliJct], headers: headers).response { _ in
                                                isEmptyHistoryPresented = false
                                            }
                                        } else {
                                            let clearSec: Int
                                            if selectedEmptyAction == 0 {
                                                clearSec = 3600
                                            } else if selectedEmptyAction == 1 {
                                                clearSec = 86400
                                            } else if selectedEmptyAction == 2 {
                                                clearSec = 172800
                                            } else {
                                                clearSec = 0
                                            }
                                            let headers: HTTPHeaders = [
                                                "cookie": "SESSDATA=\(sessdata);",
                                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                            ]
                                            for history in histories {
                                                let vt = Int64((history as! [String: Any])["ViewTime"]! as! String)!
                                                let ct = Int64(Date.now.timeStamp)
                                                if ct - vt < clearSec {
                                                    if (history as! [String: Any])["Type"]! as! String == "archive" {
                                                        AF.request("https://api.bilibili.com/x/v2/history/delete?kid=archive_\(bv2av(bvid: (history as! [String: String])["BV"]!))&csrf=\(biliJct)", method: .post, headers: headers).response { response in
                                                            debugPrint(response)
                                                        }
                                                    } else if (history as! [String: Any])["Type"]! as! String == "pgc" {
                                                        AF.request("https://api.bilibili.com/x/v2/history/delete?kid=pgc_\(((history as! [String: Any])["Data"] as! BangumiData).seasonId)&csrf=\(biliJct)", method: .post, headers: headers).response { response in
                                                            debugPrint(response)
                                                        }
                                                    }
                                                } else {
                                                    break
                                                }
                                            }
                                            isEmptyHistoryPresented = false
                                        }
                                    }, label: {
                                        if !isDoingEmpty {
                                            Text("清除历史记录")
                                                .bold()
                                        } else {
                                            ProgressView()
                                        }
                                    })
                                    .disabled(isDoingEmpty)
                                }
                            }
                            .navigationTitle("清除历史记录")
                        }
                    })
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
