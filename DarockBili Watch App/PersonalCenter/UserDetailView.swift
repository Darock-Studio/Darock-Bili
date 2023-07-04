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
import AuthenticationServices

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
    @State var viewSelector: UserDetailViewPubsType = .video
    @State var articles = [[String: String]]()
    @State var videoTotalPage = 1
    @State var videoNowPage = 1
    @State var articleTotalPage = 1
    @State var articleNowPage = 1
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: userFaceUrl + "@60w"))
                        .cornerRadius(100)
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
                Group {
                    HStack {
                        Button(action: {
                            viewSelector = .video
                        }, label: {
                            Text("视频")
                                .foregroundColor(viewSelector == .video ? Color(hex: 0xfa678e) : .white)
                        })
                        .buttonBorderShape(.roundedRectangle(radius: 14))
                        Button(action: {
                            viewSelector = .article
                        }, label: {
                            Text("专栏")
                                .foregroundColor(viewSelector == .article ? Color(hex: 0xfa678e) : .white)
                        })
                        .buttonBorderShape(.roundedRectangle(radius: 14))
                    }
                    if viewSelector == .video {
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
                                Spacer()
                                    .frame(height: 20)
                                VStack {
                                    if videoNowPage != 1 {
                                        Button(action: {
                                            videoNowPage -= 1
                                            RefreshVideos()
                                        }, label: {
                                            Text("上一页")
                                                .bold()
                                        })
                                    }
                                    Text("\(videoNowPage) / \(videoTotalPage)")
                                        .font(.system(size: 18, weight: .bold))
                                    if videoNowPage != videoTotalPage {
                                        Button(action: {
                                            videoNowPage += 1
                                            RefreshVideos()
                                        }, label: {
                                            Text("下一页")
                                                .bold()
                                        })
                                    }
                                }
                            } else {
                                ProgressView()
                            }
                        }
                    } else if viewSelector == .article {
                        VStack {
                            if articles.count != 0 {
                                ForEach(0...articles.count - 1, id: \.self) { i in
//                                    NavigationLink(destination: {ArticleView(cvid: articles[i]["CV"]!)}, label: {
//                                        VStack {
//                                            Text(articles[i]["Title"]!)
//                                                .font(.system(size: 16, weight: .bold))
//                                                .lineLimit(3)
//                                            HStack {
//                                                VStack {
//                                                    Text(articles[i]["Summary"]!)
//                                                        .font(.system(size: 10, weight: .bold))
//                                                        .lineLimit(3)
//                                                        .foregroundColor(.gray)
//                                                    HStack {
//                                                        Text(articles[i]["Type"]!)
//                                                            .font(.system(size: 10))
//                                                            .lineLimit(1)
//                                                            .foregroundColor(.gray)
//                                                        Label(articles[i]["View"]!, systemImage: "eye.fill")
//                                                            .font(.system(size: 10))
//                                                            .lineLimit(1)
//                                                            .foregroundColor(.gray)
//                                                        Label(articles[i]["Like"]!, systemImage: "hand.thumbsup.fill")
//                                                            .font(.system(size: 10))
//                                                            .lineLimit(1)
//                                                            .foregroundColor(.gray)
//                                                    }
//                                                }
//                                                WebImage(url: URL(string: articles[i]["Pic"]! + "@60w"), options: [.progressiveLoad])
//                                                    .cornerRadius(5)
//                                            }
//                                        }
//                                    })
//                                    .buttonBorderShape(.roundedRectangle(radius: 14))
                                    Button(action: {
                                        let session = ASWebAuthenticationSession(url: URL(string: "https://www.bilibili.com/read/cv\(articles[i]["CV"]!)")!, callbackURLScheme: nil) { _, _ in
                                            return
                                        }
                                        session.prefersEphemeralWebBrowserSession = true
                                        session.start()
                                    }, label: {
                                        VStack {
                                            Text(articles[i]["Title"]!)
                                                .font(.system(size: 16, weight: .bold))
                                                .lineLimit(3)
                                            HStack {
                                                VStack {
                                                    Text(articles[i]["Summary"]!)
                                                        .font(.system(size: 10, weight: .bold))
                                                        .lineLimit(3)
                                                        .foregroundColor(.gray)
                                                    HStack {
                                                        Text(articles[i]["Type"]!)
                                                            .font(.system(size: 10))
                                                            .lineLimit(1)
                                                            .foregroundColor(.gray)
                                                        Label(articles[i]["View"]!, systemImage: "eye.fill")
                                                            .font(.system(size: 10))
                                                            .lineLimit(1)
                                                            .foregroundColor(.gray)
                                                        Label(articles[i]["Like"]!, systemImage: "hand.thumbsup.fill")
                                                            .font(.system(size: 10))
                                                            .lineLimit(1)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                WebImage(url: URL(string: articles[i]["Pic"]! + "@60w"), options: [.progressiveLoad])
                                                    .cornerRadius(5)
                                            }
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 14))
                                }
                            }
                        }
                        .onAppear {
                            RefreshArticles()
                        }
                        .onDisappear {
                            articles = [[String: String]]()
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
        videos = [[String: String]]()
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);"
        ]
        DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(uid)&ps=50&pn=\(videoNowPage)".base64Encoded())") { respStr, isSuccess in
            if isSuccess {
                debugPrint(respStr.apiFixed())
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/arc/search?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        let vlist = respJson["data"]["list"]["vlist"]
                        for video in vlist {
                            videos.append(["Title": video.1["title"].string!, "Length": video.1["length"].string!, "PlayCount": String(video.1["play"].int!), "PicUrl": video.1["pic"].string!, "BV": video.1["bvid"].string!, "Timestamp": String(video.1["created"].int!), "DanmakuCount": String(video.1["video_review"].int!)])
                        }
                        videoTotalPage = Int(respJson["data"]["page"]["count"].int! / 50) + 1
                    }
                }
            }
        }
    }
    func RefreshArticles() {
        articles = [[String: String]]()
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);"
        ]
        DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(uid)&ps=30&pn=\(articleNowPage)&sort=publish_time&platform=web".base64Encoded())") { respStr, isSuccess in
            if isSuccess {
                debugPrint(respStr.apiFixed())
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/article?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        debugPrint(respJson)
                        let articlesJson = respJson["data"]["articles"]
                        for article in articlesJson {
                            articles.append(["Title": article.1["title"].string!, "Summary": article.1["summary"].string!, "Type": article.1["categories"][0]["name"].string!, "View": String(article.1["stats"]["view"].int!), "Like": String(article.1["stats"]["like"].int!), "Pic": article.1["image_urls"][0].string!, "CV": String(article.1["id"].int!)])
                        }
                        articleTotalPage = Int(respJson["data"]["count"].int ?? 0 / 30) + 1
                    }
                }
            }
        }
    }
}

enum UserDetailViewPubsType {
    case video
    case article
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(uid: "356891781")
    }
}
