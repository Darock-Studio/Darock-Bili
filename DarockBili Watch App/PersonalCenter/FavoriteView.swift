//
//  FavoriteView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
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

struct FavoriteView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var favoriteFolders = [[String: String]]()
    @State var isLoaded = false
    var body: some View {
        List {
            if favoriteFolders.count != 0 {
                ForEach(0...favoriteFolders.count - 1, id: \.self) { i in
                    NavigationLink(destination: {FavoriteDetailView(folderDatas: favoriteFolders[i])}, label: {
                        Text(favoriteFolders[i]["Title"]!)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(3)
                    })
                }
            }
        }
        .onAppear {
            if !isLoaded {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata);",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v3/fav/folder/created/list-all?up_mid=\(dedeUserID)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        if !CheckBApiError(from: respJson) { return }
                        isLoaded = true
                        let datas = respJson["data"]["list"]
                        for data in datas {
                            favoriteFolders.append(["Title": data.1["title"].string!, "ID": String(data.1["id"].int!), "Count": String(data.1["media_count"].int!)])
                        }
                    }
                }
            }
        }
    }
}

struct FavoriteDetailView: View {
    var folderDatas: [String: String]
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var details = [[String: String]]()
    @State var nowPage = 1
    @State var totalPage = 1
    var body: some View {
        List {
            if details.count != 0 {
                Section {
                    ForEach(0...details.count - 1, id: \.self) { i in
                        VideoCard(details[i])
                    }
                }
                Section {
                    if nowPage != 1 {
                        Button(action: {
                            nowPage -= 1
                            RefreshDetailData()
                        }, label: {
                            Text("上一页")
                                .bold()
                        })
                    }
                    Text("\(nowPage) / \(totalPage)")
                        .bold()
                    if nowPage != totalPage {
                        Button(action: {
                            nowPage += 1
                            RefreshDetailData()
                        }, label: {
                            Text("下一页")
                                .bold()
                        })
                    }
                }
            }
        }
        .onAppear {
            RefreshDetailData()
            totalPage = Int(Int(folderDatas["Count"]!)! / 20) + 1
        }
    }
    
    func RefreshDetailData() {
        details.removeAll()
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);",
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v3/fav/resource/list?media_id=\(folderDatas["ID"]!)&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                debugPrint(respJson)
                if !CheckBApiError(from: respJson) { return }
                let datas = respJson["data"]["medias"]
                for data in datas {
                    details.append(["Title": data.1["title"].string!, "Pic": data.1["cover"].string!, "UP": data.1["upper"]["name"].string!, "BV": data.1["bvid"].string!, "View": String(data.1["cnt_info"]["play"].int!), "Danmaku": String(data.1["cnt_info"]["danmaku"].int!)])
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
