//
//
//  UserDynamicMainView.swift
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
    @State var isDynamicSendPresented = false
    var body: some View {
        if sessdata != "" {
            ScrollView {
                LazyVStack {
                    if dynamics.count != 0 {
                        Button(action: {
                            isDynamicSendPresented = true
                        }, label: {
                            Label("发送动态", systemImage: "square.and.pencil")
                        })
                        .buttonStyle(.borderedProminent)
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
                                                switch dynamics[i]["Type"]! as! BiliDynamicType {
                                                case .draw, .text:
                                                    return ""
                                                case .video:
                                                    return " · 投稿了视频"
                                                case .live:
                                                    return "直播了"
                                                case .forward:
                                                    return " · 转发动态"
                                                case .article:
                                                    return " · 投稿了专栏"
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
                                    NavigationLink(destination: {DynamicDetailView(dynamicDetails: dynamics[i])}, label: {
                                        HStack {
                                            Text(dynamics[i]["WithText"]! as! String)
                                                .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonStyle(.plain)
                                }
                                if dynamics[i]["Type"]! as! BiliDynamicType == .draw {
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
                                } else if dynamics[i]["Type"]! as! BiliDynamicType == .video {
                                    if let archive = dynamics[i]["Archive"] as? [String: String] {
                                        VideoCard(archive)
                                    }
                                } else if dynamics[i]["Type"]! as! BiliDynamicType == .live {
                                    if let liveInfo = dynamics[i]["Live"] as? [String: String] {
                                        NavigationLink(destination: {LiveDetailView(liveDetails: liveInfo)}, label: {
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
                                } else if dynamics[i]["Type"]! as! BiliDynamicType == .forward {
                                    if let origData = dynamics[i]["Forward"] as? [String: Any?]? {
                                        if let orig = origData {
                                            NavigationLink(destination: {DynamicDetailView(dynamicDetails: orig)}, label: {
                                                VStack {
                                                    HStack {
                                                        WebImage(url: URL(string: orig["SenderPic"]! as! String + "@30w"), options: [.progressiveLoad])
                                                            .cornerRadius(100)
                                                        VStack {
                                                            NavigationLink("", isActive: $isSenderDetailsPresented[i], destination: {UserDetailView(uid: orig["SenderID"]! as! String)})
                                                                .frame(width: 0, height: 0)
                                                            HStack {
                                                                Text(orig["SenderName"]! as! String)
                                                                    .font(.system(size: 14, weight: .bold))
                                                                    .lineLimit(1)
                                                                Spacer()
                                                            }
                                                            HStack {
                                                                Text(orig["SendTimeStr"]! as! String + { () -> String in
                                                                    switch orig["Type"]! as! BiliDynamicType {
                                                                    case .draw, .text:
                                                                        return ""
                                                                    case .video:
                                                                        return "投稿了视频"
                                                                    case .live:
                                                                        return "直播了"
                                                                    case .forward:
                                                                        return "转发动态"
                                                                    case .article:
                                                                        return "投稿了专栏"
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
                                                    if orig["WithText"]! as! String != "" {
                                                        HStack {
                                                            Text(orig["WithText"]! as! String)
                                                                .font(.system(size: 16))
                                                                .lineLimit(5)
                                                            Spacer()
                                                        }
                                                    }
                                                    if orig["Type"]! as! BiliDynamicType == .draw {
                                                        if let draws = orig["Draws"] as? [[String: String]] {
                                                            LazyVGrid(columns: [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]) {
                                                                ForEach(0..<draws.count, id: \.self) { j in
                                                                    VStack {
                                                                        WebImage(url: URL(string: draws[j]["Src"]! + "@60w_40h"), options: [.progressiveLoad])
                                                                            .cornerRadius(5)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    } else if orig["Type"]! as! BiliDynamicType == .video {
                                                        if let archive = orig["Archive"] as? [String: String] {
                                                            VideoCard(archive)
                                                                .disabled(true)
                                                        }
                                                    } else if orig["Type"]! as! BiliDynamicType == .live {
                                                        if let liveInfo = orig["Live"] as? [String: String] {
                                                            NavigationLink(destination: {LiveDetailView(liveDetails: liveInfo)}, label: {
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
                                                            .disabled(true)
                                                        }
                                                    }
                                                }
                                            })
                                            .buttonBorderShape(.roundedRectangle(radius: 14))
                                        }
                                    }
                                }
                                Divider()
                            }
                        }
                        Button(action: {
                            ContinueLoadDynamic()
                        }, label: {
                            if !isLoadingNew {
                                Text("Home.more")
                                    .font(.system(size: 18, weight: .bold))
                            } else {
                                ProgressView()
                            }
                        })
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            }
            .navigationTitle("Moments")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                lastDynamicID = ""
                dynamics.removeAll()
                ContinueLoadDynamic()
            }
            .sheet(isPresented: $isDynamicSendPresented, content: {DynamicSendView()})
            .onAppear {
                if !isLoaded {
                    ContinueLoadDynamic()
                    isLoaded = true
                }
            }
        } else {
            Text("Moments.requires-login")
                .navigationTitle("Moments")
        }
    }
    
    func ContinueLoadDynamic() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);",
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/all?type=all\({ () -> String in if lastDynamicID != "" { return "&offset=\(lastDynamicID)"; } else { return ""; }; }())&page=\(nextLoadPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                debugPrint(respJson)
                if !CheckBApiError(from: respJson) { return }
                let items = respJson["data"]["items"]
                var itemForCount = 0
                for item in items {
                    isSenderDetailsPresented.append(false)
                    isDynamicImagePresented.append([])
                    dynamics.append([
                        "WithText": item.1["modules"]["module_dynamic"]["desc"]["text"].string ?? "",
                        "Type": BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") ?? .text,
                        "Draws": { () -> [[String: String]]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .draw {
                                var dTmp = [[String: String]]()
                                for draw in item.1["modules"]["module_dynamic"]["major"]["draw"]["items"] {
                                    isDynamicImagePresented[itemForCount].append(false)
                                    dTmp.append(["Src": draw.1["src"].string ?? ""])
                                }
                                return dTmp
                            } else {
                                return nil
                            }
                        }(),
                        "Archive": { () -> [String: String]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .video {
                                let archive = item.1["modules"]["module_dynamic"]["major"]["archive"]
                                return ["Pic": archive["cover"].string ?? "", "Title": archive["title"].string ?? "", "BV": archive["bvid"].string ?? "", "UP": item.1["modules"]["module_author"]["name"].string ?? "", "View": archive["stat"]["play"].string ?? "-1", "Danmaku": archive["stat"]["danmaku"].string ?? "-1"]
                            } else {
                                return nil
                            }
                        }(),
                        "Live": { () -> [String: String]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .live {
                                do {
                                    let liveContentJson = try JSON(data: (item.1["modules"]["module_dynamic"]["major"]["live_rcmd"]["content"].string ?? "").data(using: .utf8) ?? Data())
                                    debugPrint(liveContentJson)
                                    return ["Cover": liveContentJson["live_play_info"]["cover"].string ?? "", "Title": liveContentJson["live_play_info"]["title"].string ?? "", "ID": String(liveContentJson["live_play_info"]["room_id"].int ?? 0), "Type": liveContentJson["live_play_info"]["area_name"].string ?? "", "ViewStr": liveContentJson["live_play_info"]["watched_show"]["text_large"].string ?? "-1"]
                                } catch {
                                    return nil
                                }
                            } else {
                                return nil
                            }
                        }(),
                        "Forward": { () -> [String: Any?]? in
                            if BiliDynamicType(rawValue: item.1["type"].string ?? "DYNAMIC_TYPE_WORD") == .forward {
                                let origData = item.1["orig"]
                                return [
                                    "WithText": origData["modules"]["module_dynamic"]["desc"]["text"].string ?? "",
                                    "Type": BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") ?? .text,
                                    "Draws": { () -> [[String: String]]? in
                                        if BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") == .draw {
                                            var dTmp = [[String: String]]()
                                            for draw in origData["modules"]["module_dynamic"]["major"]["draw"]["items"] {
                                                isDynamicImagePresented[itemForCount].append(false)
                                                dTmp.append(["Src": draw.1["src"].string ?? ""])
                                            }
                                            return dTmp
                                        } else {
                                            return nil
                                        }
                                    }(),
                                    "Archive": { () -> [String: String]? in
                                        if BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") == .video {
                                            let archive = origData["modules"]["module_dynamic"]["major"]["archive"]
                                            return ["Pic": archive["cover"].string ?? "", "Title": archive["title"].string ?? "", "BV": archive["bvid"].string ?? "", "UP": origData["modules"]["module_author"]["name"].string ?? "", "View": archive["stat"]["play"].string ?? "-1", "Danmaku": archive["stat"]["danmaku"].string ?? "-1"]
                                        } else {
                                            return nil
                                        }
                                    }(),
                                    "Live": { () -> [String: String]? in
                                        if BiliDynamicType(rawValue: origData["type"].string ?? "DYNAMIC_TYPE_WORD") == .live {
                                            do {
                                                let liveContentJson = try JSON(data: (origData["modules"]["module_dynamic"]["major"]["live_rcmd"]["content"].string ?? "").data(using: .utf8) ?? Data())
                                                debugPrint(liveContentJson)
                                                return ["Cover": liveContentJson["live_play_info"]["cover"].string ?? "", "Title": liveContentJson["live_play_info"]["title"].string ?? "", "ID": String(liveContentJson["live_play_info"]["room_id"].int ?? 0), "Type": liveContentJson["live_play_info"]["area_name"].string ?? "", "ViewStr": liveContentJson["live_play_info"]["watched_show"]["text_large"].string ?? "-1"]
                                            } catch {
                                                return nil
                                            }
                                        } else {
                                            return nil
                                        }
                                    }(),
                                    "SenderPic": origData["modules"]["module_author"]["face"].string ?? "",
                                    "SenderName": origData["modules"]["module_author"]["name"].string ?? "",
                                    "SenderID": String(origData["modules"]["module_author"]["mid"].int ?? 0),
                                    "SendTimeStr": origData["modules"]["module_author"]["pub_time"].string ?? "0000/00/00",
                                    "SharedCount": String(origData["modules"]["module_stat"]["forward"]["count"].int ?? -1),
                                    "LikedCount": String(origData["modules"]["module_stat"]["like"]["count"].int ?? -1),
                                    "IsLiked": origData["modules"]["module_stat"]["like"]["status"].bool ?? false,
                                    "CommentCount": String(origData["modules"]["module_stat"]["comment"]["count"].int ?? -1),
                                    "DynamicID": origData["id_str"].string ?? ""
                                ]
                            } else {
                                return nil
                            }
                        }(),
                        "SenderPic": item.1["modules"]["module_author"]["face"].string ?? "",
                        "SenderName": item.1["modules"]["module_author"]["name"].string ?? "",
                        "SenderID": String(item.1["modules"]["module_author"]["mid"].int ?? 0),
                        "SendTimeStr": item.1["modules"]["module_author"]["pub_time"].string ?? "0000/00/00",
                        "SharedCount": String(item.1["modules"]["module_stat"]["forward"]["count"].int ?? -1),
                        "LikedCount": String(item.1["modules"]["module_stat"]["like"]["count"].int ?? -1),
                        "IsLiked": item.1["modules"]["module_stat"]["like"]["status"].bool ?? false,
                        "CommentCount": String(item.1["modules"]["module_stat"]["comment"]["count"].int ?? -1),
                        "DynamicID": item.1["id_str"].string ?? ""
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

enum BiliDynamicType: String {
    case forward = "DYNAMIC_TYPE_FORWARD" // 转发
    case video = "DYNAMIC_TYPE_AV" // 投稿视频
    case text = "DYNAMIC_TYPE_WORD" // 纯文本
    case draw = "DYNAMIC_TYPE_DRAW" // 带图
    case article = "DYNAMIC_TYPE_ARTICLE" // 专栏
    case live = "DYNAMIC_TYPE_LIVE_RCMD" // 直播开播
}

struct UserDynamicMainView_Previews: PreviewProvider {
    static var previews: some View {
        UserDynamicMainView()
    }
}
