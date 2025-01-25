//
//
//  FavoriteView.swift
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
import Alamofire
import SwiftyJSON
import DarockFoundation
import MobileCoreServices

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
                    NavigationLink(destination: { FavoriteDetailView(folderDatas: favoriteFolders[i]) }, label: {
                        Text(favoriteFolders[i]["Title"]!)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(3)
                    })
                }
            }
        }
        .navigationTitle("我的收藏")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if !isLoaded {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata);",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                requestJSON("https://api.bilibili.com/x/v3/fav/folder/created/list-all?up_mid=\(dedeUserID)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        if !CheckBApiError(from: respJson) { return }
                        isLoaded = true
                        let datas = respJson["data"]["list"]
                        for data in datas {
                            favoriteFolders.append(["Title": data.1["title"].string!, "ID": String(data.1["id"].int64!), "Count": String(data.1["media_count"].int!)])
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
                        #if !os(watchOS)
                            .onDrop(of: [UTType.data.identifier], isTargeted: nil) { items in
                                PlayHaptic(sharpness: 0.05, intensity: 0.5)
                                for item in items {
                                    item.loadDataRepresentation(forTypeIdentifier: UTType.data.identifier) { (data, _) in
                                        if let data = data, let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String] {
                                            if dict["BV"] != nil {
                                                details.insert(dict, at: 0)
                                                let headers: HTTPHeaders = [
                                                    "cookie": "SESSDATA=\(sessdata)",
                                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                ]
                                                let avid = bv2av(bvid: dict["BV"]!)
                                                AF.request("https://api.bilibili.com/x/v3/fav/resource/deal", method: .post, parameters: ["rid": avid, "type": 2, "add_media_ids": Int64(folderDatas["ID"]!)!, "csrf": biliJct], headers: headers).response { _ in }
                                            }
                                        }
                                    }
                                }
                                return true
                            }
                        #endif
                    }
                }
                Section {
                    HStack {
                        if nowPage != 1 {
                            Button(action: {
                                nowPage -= 1
                                refreshDetailData()
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
                        Text("\(nowPage) / \(totalPage)")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                        if nowPage != totalPage {
                            Button(action: {
                                nowPage += 1
                                refreshDetailData()
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
            }
        }
        .navigationTitle(folderDatas["Title"]!)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            refreshDetailData()
            totalPage = Int(Int(folderDatas["Count"]!)! / 20) + 1
        }
    }
    
    func refreshDetailData() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);",
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        requestJSON("https://api.bilibili.com/x/v3/fav/resource/list?media_id=\(folderDatas["ID"]!)&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                details.removeAll()
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
