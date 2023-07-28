//
//  UserDynamicMainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/28.
//

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
    var body: some View {
        if sessdata != "" {
            ScrollView {
                VStack {
                    if dynamics.count != 0 {
                        ForEach(0..<dynamics.count, id: \.self) { i in
                            VStack {
                                HStack {
                                    WebImage(url: URL(string: dynamics[i]["SenderPic"]! as! String + "@30w"), options: [.progressiveLoad])
                                        .cornerRadius(100)
                                    VStack {
                                        NavigationLink("", isActive: $isSenderDetailsPresented[i], destination: {UserDetailView(uid: dynamics[i]["SenderID"]! as! String)})
                                            .frame(width: 0, height: 0)
                                        Text(dynamics[i]["SenderName"]! as! String)
                                            .font(.system(size: 14, weight: .bold))
                                            .lineLimit(1)
                                        Text(dynamics[i]["SendTimeStr"]! as! String)
                                            .font(.system(size: 10))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Text(dynamics[i]["WithText"]! as! String)
                                        .font(.system(size: 16))
                                    Spacer()
                                }
                                if dynamics[i]["MajorType"]! as! BiliDynamicMajorType == .majorTypeDraw {
                                    if let draws = dynamics[i]["Draws"] as? [[String: String]] {
                                        LazyVGrid(columns: [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]) {
                                            ForEach(0..<draws.count, id: \.self) { j in
                                                WebImage(url: URL(string: draws[j]["Src"]! + "@50w"), options: [.progressiveLoad])
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                } else if dynamics[i]["MajorType"]! as! BiliDynamicMajorType == .majorTypeArchive {
                                    if let archive = dynamics[i]["Archive"] as? [String: String] {
                                        VideoCard(archive)
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle("动态")
            .onAppear {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata);"
                ]
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/all?type=all&page=1", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        let items = respJson["data"]["items"]
                        for item in items {
                            isSenderDetailsPresented.append(false)
                            dynamics.append([
                                "WithText": item.1["modules"]["module_dynamic"]["desc"]["text"].string ?? "",
                                "MajorType": BiliDynamicMajorType(rawValue: item.1["modules"]["module_dynamic"]["major"]["type"].string ?? "MAJOR_TYPE_DRAW") ?? .majorTypeDraw,
                                "Draws": { () -> [[String: String]]? in
                                    if BiliDynamicMajorType(rawValue: item.1["modules"]["module_dynamic"]["major"]["type"].string ?? "MAJOR_TYPE_DRAW") == .majorTypeDraw {
                                        var dTmp = [[String: String]]()
                                        for draw in item.1["modules"]["module_dynamic"]["major"]["draw"]["items"] {
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
                                "SenderPic": item.1["modules"]["module_author"]["face"].string!,
                                "SenderName": item.1["modules"]["module_author"]["name"].string!,
                                "SenderID": String(item.1["modules"]["module_author"]["mid"].int!),
                                "SendTimeStr": item.1["modules"]["module_author"]["pub_time"].string!,
                                "SharedCount": String(item.1["modules"]["module_stat"]["forward"]["count"].int!),
                                "LikedCount": String(item.1["modules"]["module_stat"]["like"]["count"].int!),
                                "IsLiked": item.1["modules"]["module_stat"]["like"]["status"].bool!,
                                "CommentCount": String(item.1["modules"]["module_stat"]["comment"]["count"].int!)
                            ])
                        }
                    }
                }
            }
        } else {
            Text("需要登录")
                .navigationTitle("动态")
        }
    }
}

enum BiliDynamicMajorType: String {
    case majorTypeDraw = "MAJOR_TYPE_DRAW" //图片？
    case majorTypeArchive = "MAJOR_TYPE_ARCHIVE" //投稿视频
    
}

struct UserDynamicMainView_Previews: PreviewProvider {
    static var previews: some View {
        UserDynamicMainView()
    }
}
