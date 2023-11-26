//
//  UserDynamicMainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/28.
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

struct UserDynamicMainView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var dynamics = [[String: Any?]]()
    @State var isSenderDetailsPresented = [Bool]()
    @State var isDynamicImagePresented = [[Bool]]()
    @State var isLoaded = false
    @State var nextLoadPage = 1
    @State var lastDynamicID = ""
    @State var isLoadingNew = false
    var body: some View {
        if sessdata != "" {
            ScrollView {
                LazyVStack {
                    if dynamics.count != 0 {
                        ForEach(0..<dynamics.count, id: \.self) { i in
                            VStack {
                                HStack {
                                    WebImage(url: URL(string: dynamics[i]["SenderPic"]! as! String + "@30w"), options: [.progressiveLoad])
                                        .cornerRadius(100)
                                    VStack {
                                        NavigationLink("", isActive: $isSenderDetailsPresented[i], destination: {UserDetailView(uid: dynamics[i]["SenderID"]! as! String)})
                                            .frame(width: 0, height: 0)
                                        HStack {
                                            Text(dynamics[i]["SenderName"]! as! String)
                                                .font(.system(size: 14, weight: .bold))
                                                .lineLimit(1)
                                            Spacer()
                                        }
                                        HStack {
                                            Text(dynamics[i]["SendTimeStr"]! as! String + { () -> String in
                                                switch dynamics[i]["MajorType"]! as! BiliDynamicMajorType {
                                                case .majorTypeDraw:
                                                    return ""
                                                case .majorTypeArchive:
                                                    return " · 投稿了视频"
                                                case .majorTypeLiveRcmd:
                                                    return "直播了"
                                                }
                                            }())
                                            .font(.system(size: 10))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                }
                                .onTapGesture {
                                    isSenderDetailsPresented[i] = true
                                }
                                if dynamics[i]["WithText"]! as! String != "" {
                                    HStack {
                                        Text(dynamics[i]["WithText"]! as! String)
                                            .font(.system(size: 16))
                                        Spacer()
                                    }
                                }
                                if dynamics[i]["MajorType"]! as! BiliDynamicMajorType == .majorTypeDraw {
                                    if let draws = dynamics[i]["Draws"] as? [[String: String]] {
                                        LazyVGrid(columns: [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]) {
                                            ForEach(0..<draws.count, id: \.self) { j in
                                                if isDynamicImagePresented[i].count > j {
                                                    VStack {
                                                        NavigationLink("", isActive: $isDynamicImagePresented[i][j], destination: {ImageViewerView(url: draws[j]["Src"]!)})
                                                            .frame(width: 0, height: 0)
                                                        WebImage(url: URL(string: draws[j]["Src"]! + "@60w_40h"), options: [.progressiveLoad])
                                                            .cornerRadius(5)
                                                            .onTapGesture {
                                                                isDynamicImagePresented[i][j] = true
                                                            }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else if dynamics[i]["MajorType"]! as! BiliDynamicMajorType == .majorTypeArchive {
                                    if let archive = dynamics[i]["Archive"] as? [String: String] {
                                        VideoCard(archive)
                                    }
                                } else if dynamics[i]["MajorType"]! as! BiliDynamicMajorType == .majorTypeLiveRcmd {
                                    if let liveInfo = dynamics[i]["Live"] as? [String: String] {
                                        NavigationLink(destination: {LivePlayerView(id: liveInfo["ID"]!)}, label: {
                                            VStack {
                                                HStack {
                                                    WebImage(url: URL(string: liveInfo["Cover"]! + "@50w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                                                        .placeholder {
                                                            RoundedRectangle(cornerRadius: 7)
                                                                .frame(width: 50)
                                                                .foregroundColor(Color(hex: 0x3D3D3D))
                                                                .redacted(reason: .placeholder)
                                                        }
                                                        .cornerRadius(7)
                                                    Text(liveInfo["Title"]!)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .lineLimit(2)
                                                    Spacer()
                                                }
                                                HStack {
                                                    Text("\(liveInfo["Type"]!) · \(liveInfo["ViewStr"]!)")
                                                    Spacer()
                                                }
                                                .lineLimit(1)
                                                .font(.system(size: 11))
                                                .foregroundColor(.gray)
                                            }
                                        })
                                        .buttonBorderShape(.roundedRectangle(radius: 14))
                                    }
                                }
                                Divider()
                            }
                        }
                        Button(action: {
                            ContinueLoadDynamic()
                        }, label: {
                            if !isLoadingNew {
                                Text("继续加载")
                                    .font(.system(size: 18, weight: .bold))
                            } else {
                                ProgressView()
                            }
                        })
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("动态")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if #available(watchOS 10, *) {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            lastDynamicID = ""
                            dynamics.removeAll()
                            ContinueLoadDynamic()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.accentColor)
                        })
                    }
                }
            }
            .onAppear {
                if !isLoaded {
                    ContinueLoadDynamic()
                    isLoaded = true
                }
            }
        } else {
            Text("需要登录")
                .navigationTitle("动态")
        }
    }
    
    func ContinueLoadDynamic() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);"
        ]
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/all?type=all\({ () -> String in if lastDynamicID != "" { return "&offset=\(lastDynamicID)"; } else { return ""; }; }())&page=\(nextLoadPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                debugPrint(respJson)
                let items = respJson["data"]["items"]
                var itemForCount = 0
                for item in items {
                    isSenderDetailsPresented.append(false)
                    isDynamicImagePresented.append([])
                    dynamics.append([
                        "WithText": item.1["modules"]["module_dynamic"]["desc"]["text"].string ?? "",
                        "MajorType": BiliDynamicMajorType(rawValue: item.1["modules"]["module_dynamic"]["major"]["type"].string ?? "MAJOR_TYPE_DRAW") ?? .majorTypeDraw,
                        "Draws": { () -> [[String: String]]? in
                            if BiliDynamicMajorType(rawValue: item.1["modules"]["module_dynamic"]["major"]["type"].string ?? "MAJOR_TYPE_DRAW") == .majorTypeDraw {
                                var dTmp = [[String: String]]()
                                for draw in item.1["modules"]["module_dynamic"]["major"]["draw"]["items"] {
                                    isDynamicImagePresented[itemForCount].append(false)
                                    dTmp.append(["Src": draw.1["src"].string!])
                                }
                                return dTmp
                            } else {
                                return nil
                            }
                        }(),
                        "Archive": { () -> [String: String]? in
                            if BiliDynamicMajorType(rawValue: item.1["modules"]["module_dynamic"]["major"]["type"].string ?? "MAJOR_TYPE_DRAW") == .majorTypeArchive {
                                let archive = item.1["modules"]["module_dynamic"]["major"]["archive"]
                                return ["Pic": archive["cover"].string!, "Title": archive["title"].string!, "BV": archive["bvid"].string!, "UP": item.1["modules"]["module_author"]["name"].string!, "View": archive["stat"]["play"].string!, "Danmaku": archive["stat"]["danmaku"].string!]
                            } else {
                                return nil
                            }
                        }(),
                        "Live": { () -> [String: String]? in
                            if BiliDynamicMajorType(rawValue: item.1["modules"]["module_dynamic"]["major"]["type"].string ?? "MAJOR_TYPE_DRAW") == .majorTypeLiveRcmd {
                                do {
                                    let liveContentJson = try JSON(data: (item.1["modules"]["module_dynamic"]["major"]["live_rcmd"]["content"].string ?? "").data(using: .utf8) ?? Data())
                                    debugPrint(liveContentJson)
                                    return ["Cover": liveContentJson["live_play_info"]["cover"].string!, "Title": liveContentJson["live_play_info"]["title"].string!, "ID": String(liveContentJson["live_play_info"]["room_id"].int!), "Type": liveContentJson["live_play_info"]["area_name"].string!, "ViewStr": liveContentJson["live_play_info"]["watched_show"]["text_large"].string!]
                                } catch {
                                    return nil
                                }
                            } else {
                                return nil
                            }
                        }(),
                        "SenderPic": item.1["modules"]["module_author"]["face"].string!,
                        "SenderName": item.1["modules"]["module_author"]["name"].string!,
                        "SenderID": String(item.1["modules"]["module_author"]["mid"].int!),
                        "SendTimeStr": item.1["modules"]["module_author"]["pub_time"].string!,
                        "SharedCount": String(item.1["modules"]["module_stat"]["forward"]["count"].int!),
                        "LikedCount": String(item.1["modules"]["module_stat"]["like"]["count"].int!),
                        "IsLiked": item.1["modules"]["module_stat"]["like"]["status"].bool!,
                        "CommentCount": String(item.1["modules"]["module_stat"]["comment"]["count"].int!),
                        "DynamicID": item.1["id_str"].string!
                    ])
                    itemForCount += 1
                }
                lastDynamicID = dynamics.last?["DynamicID"] as! String
                nextLoadPage += 1
                isLoadingNew = false
            }
        }
    }
}

enum BiliDynamicMajorType: String {
    case majorTypeDraw = "MAJOR_TYPE_DRAW" //图片？
    case majorTypeArchive = "MAJOR_TYPE_ARCHIVE" //投稿视频
    case majorTypeLiveRcmd = "MAJOR_TYPE_LIVE_RCMD" //直播
}

struct UserDynamicMainView_Previews: PreviewProvider {
    static var previews: some View {
        UserDynamicMainView()
    }
}
