//
//
//  WatchLaterView.swift
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

struct WatchLaterView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var laters = [[String: String]]()
    @State var isMoreMenuPresented = false
    var body: some View {
        List {
            Group {
                if laters.count != 0 {
                    ForEach(0...laters.count - 1, id: \.self) { i in
                        VideoCard(laters[i])
                            .swipeActions {
                                Button(role: .destructive, action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata)",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    AF.request("https://api.bilibili.com/x/v2/history/toview/del", method: .post, parameters: ["aid": bv2av(bvid: laters[i]["BV"]!), "csrf": biliJct], headers: headers).response { response in
                                        debugPrint(response)
                                        #if !os(visionOS) && !os(watchOS)
                                        AlertKitAPI.present(title: "已移除", subtitle: "视频已从稍后再看中移除", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                        #else
                                        tipWithText("已移除", symbol: "checkmark.circle.fill")
                                        #endif
                                    }
                                }, label: {
                                    Image(systemName: "trash.fill")
                                })
                            }
                    }
                }
            }
            .navigationTitle("稍后再看")
            .navigationBarTitleDisplayMode(.large)
            #if !os(watchOS)
            .onDrop(of: [UTType.data.identifier], isTargeted: nil) { items in
                PlayHaptic(sharpness: 0.05, intensity: 0.5)
                for item in items {
                    item.loadDataRepresentation(forTypeIdentifier: UTType.data.identifier) { (data, _) in
                        if let data = data, let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String] {
                            if dict["BV"] != nil {
                                laters.insert(dict, at: 0)
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                AF.request("https://api.bilibili.com/x/v2/history/toview/add", method: .post, parameters: ["bvid": dict["BV"]!, "csrf": biliJct], headers: headers).response { _ in }
                            }
                        }
                    }
                }
                return true
            }
            #endif
        }
        .toolbar {
            #if !os(watchOS)
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isMoreMenuPresented = true
                }, label: {
                    Image(systemName: "ellipsis.circle")
                })
            }
            #endif
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/history/toview", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint(respJson)
                    if !CheckBApiError(from: respJson) { return }
                    let datas = respJson["data"]["list"]
                    for data in datas {
                        laters.append(["Title": data.1["title"].string!, "Pic": data.1["pic"].string!, "UP": data.1["owner"]["name"].string!, "View": String(data.1["stat"]["view"].int!), "Danmaku": String(data.1["stat"]["danmaku"].int!), "BV": data.1["bvid"].string!])
                    }
                }
            }
        }
        .sheet(isPresented: $isMoreMenuPresented) {
            List {
                Section {
                    Button(role: .destructive, action: {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata)",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        AF.request("https://api.bilibili.com/x/v2/history/toview/del", method: .post, parameters: ["viewed": true, "csrf": biliJct], headers: headers).response { response in
                            debugPrint(response)
                            #if !os(visionOS) && !os(watchOS)
                            AlertKitAPI.present(title: "已清除", subtitle: "所有已观看视频已清除", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                            #else
                            tipWithText("已清除", symbol: "checkmark.circle.fill")
                            #endif
                            isMoreMenuPresented = false
                        }
                    }, label: {
                        Label("清除所有已观看视频", systemImage: "trash.slash.square.fill")
                    })
                }
            }
            .presentationDetents([.medium])
        }
    }
}

struct WatchLaterView_Previews: PreviewProvider {
    static var previews: some View {
        WatchLaterView()
    }
}
