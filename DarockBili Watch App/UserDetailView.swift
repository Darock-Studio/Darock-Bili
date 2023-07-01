//
//  UserDetailView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/1.
//

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct UserDetailView: View {
    var uid: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var userFaceUrl = ""
    @State var username = ""
    @State var userLevel = 0
    @State var officialType = -1
    @State var officialTitle = ""
    @State var userSign = ""
    @State var videos = [[String: String]]()
    @State var isVideosLoaded = false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: userFaceUrl + "@60w"))
                    Spacer()
                }
                HStack {
                    Text(username)
                        .font(.system(size: 16, weight: .bold))
                    switch userLevel {
                    case 0:
                        Image("Lv0Icon")
                    case 1:
                        Image("Lv1Icon")
                    case 2:
                        Image("Lv2Icon")
                    case 3:
                        Image("Lv3Icon")
                    case 4:
                        Image("Lv4Icon")
                    case 5:
                        Image("Lv5Icon")
                    case 6:
                        Image("Lv6Icon")
                    case 7:
                        Image("Lv7Icon")
                    case 8:
                        Image("Lv8Icon")
                    case 9:
                        Image("Lv9Icon")
                    default:
                        Image("Lv9Icon")
                    }
                    Spacer()
                }
                if officialType != -1 {
                    HStack {
                        WebImage(url: URL(string: officialType == 0 ? "https://s1.hdslb.com/bfs/seed/jinkela/short/user-avatar/personal.svg" : "https://s1.hdslb.com/bfs/seed/jinkela/short/user-avatar/business.svg"))
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("bilibili UP主认证：\(officialTitle)")
                    }
                }
                HStack {
                    Text(userSign)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    Spacer(minLength: 0)
                }
                Spacer()
                    .frame(height: 20)
                VStack {
                    if videos.count != 0 {
                        ForEach(0...videos.count - 1, id: \.self) { i in
                            NavigationLink(destination: {VideoDetailView(videoDetails: ["Pic": videos[i]["PicUrl"]!, "Title": videos[i]["Title"]!, "BV": videos[i]["BV"]!, "UP": username, "View": videos[i]["PlayCount"]!, "Danmaku": videos[i]["DanmakuCount"]!])}, label: {
                                HStack {
                                    WebImage(url: URL(string: videos[i]["PicUrl"]! + "@40w"))
                                    VStack {
                                        Text(videos[i]["Title"]!)
                                            .font(.system(size: 14, weight: .bold))
                                            .lineLimit(3)
                                        
                                        HStack {
                                            Label(videos[i]["PlayCount"]!, systemImage: "play.rectangle")
                                            Label(videos[i]["DanmakuCount"]!, systemImage: "text.word.spacing")
                                        }
                                        .font(.system(size: 10))
                                    }
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 8))
                        }
                    }
                }
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);"
            ]
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(uid)".base64Encoded())") { respStr, isSuccess in
                if isSuccess {
                    debugPrint(respStr.apiFixed())
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            userFaceUrl = respJson["data"]["face"].string!
                            username = respJson["data"]["name"].string!
                            userLevel = respJson["data"]["level"].int!
                            officialType = respJson["data"]["official"]["type"].int!
                            officialTitle = respJson["data"]["official"]["title"].string!
                            userSign = respJson["data"]["sign"].string!
                            
                            
                        }
                    }
                }
            }
            if !isVideosLoaded {
                RefreshVideos()
            }
        }
    }
    
    func RefreshVideos() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);"
        ]
        DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(uid)&ps=50&pn=1".base64Encoded())") { respStr, isSuccess in
            if isSuccess {
                debugPrint(respStr.apiFixed())
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/arc/search?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        let vlist = respJson["data"]["list"]["vlist"]
                        for video in vlist {
                            videos.append(["Title": video.1["title"].string!, "Length": video.1["length"].string!, "PlayCount": String(video.1["play"].int!), "PicUrl": video.1["pic"].string!, "BV": video.1["bvid"].string!, "Timestamp": String(video.1["created"].int!), "DanmakuCount": String(video.1["video_review"].int!)])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserDetailView(uid: "356891781")
}
