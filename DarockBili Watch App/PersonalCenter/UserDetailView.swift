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
    @State var followCount = 0
    @State var fansCount = 0
    @State var videos = [[String: String]]()
    @State var isNoVideo = false
    @State var isVideosLoaded = false
    @State var isArticlesLoaded = false
    @State var viewSelector: UserDetailViewPubsType = .video
    @State var articles = [[String: String]]()
    @State var isNoArticle = false
    @State var videoTotalPage = 1
    @State var videoNowPage = 1
    @State var articleTotalPage = 1
    @State var articleNowPage = 1
    @State var videoCount = 0
    @State var articalCount = 0
    @State var coinCount = 0
    var body: some View {
        TabView {
            TabView {
                VStack {
                    HStack {
                        Spacer()
                        AsyncImage(url: URL(string: userFaceUrl + "@50w_50h"))
                            .cornerRadius(100)
                        Spacer()
                    }
                    HStack {
                        VStack {
                            Text(String(followCount))
                                .font(.system(size: 14))
                            Text("关注")
                                .font(.system(size: 12))
                                .opacity(0.6)
                        }
                        Spacer()
                        VStack {
                            Text(String(fansCount))
                                .font(.system(size: 14))
                            Text("粉丝")
                                .font(.system(size: 12))
                                .opacity(0.6)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "bell")
                        })
                        HStack {
                            Image(systemName: "b.circle")
                                .font(.system(size: 12))
                                .opacity(0.55)
                                .offset(y: 1)
                            Text(String(coinCount))
                                .font(.system(size: 14))
                        }
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "ellipsis.bubble")
                        })
                    }
                }
                .offset(y: -10)
                .navigationTitle(username)
                .tag(1)
                .containerBackground(Color.accentColor.gradient, for: .navigation)
                ScrollView {
                    VStack {
                        if officialType != -1 {
                            HStack {
                                Image(systemName: "bolt.circle")
                                    .foregroundColor(officialType == 0 ? Color(hex: 0xFDD663) : Color(hex: 0xA0C0F4))
                                    .frame(width: 20, height: 20)
                                Text("\(Text("UP 主认证").bold())\n\(officialTitle)")
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            .padding(.horizontal, 6)
                        }
                        Spacer()
                            .frame(height: 10)
                        HStack {
                            Image(systemName: "info.circle")
                                .font(.system(size: 14))
                                .opacity(0.6)
                            Text(userSign)
                                .font(.system(size: 14))
                                .opacity(0.6)
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .tag(2)
                .containerBackground(Color.accentColor.gradient, for: .navigation)
            }
            .tabViewStyle(.verticalPage)
        ScrollView {
            VStack {
                    Group {
                        if viewSelector == .video {
                            VStack {
                                if videos.count != 0 {
                                    ForEach(0...videos.count - 1, id: \.self) { i in
                                        VideoCard(["Pic": videos[i]["PicUrl"]!, "Title": videos[i]["Title"]!, "BV": videos[i]["BV"]!, "UP": username, "View": videos[i]["PlayCount"]!, "Danmaku": videos[i]["DanmakuCount"]!])
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
                                    if isNoVideo {
                                        Text("该用户无视频")
                                    } else {
                                        ProgressView()
                                    }
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
                                    
                                    if articleNowPage != 1 {
                                        Button(action: {
                                            articleNowPage -= 1
                                            RefreshArticles()
                                        }, label: {
                                            Text("上一页")
                                                .bold()
                                        })
                                    }
                                    Text("\(articleNowPage) / \(articleTotalPage)")
                                        .font(.system(size: 18, weight: .bold))
                                    if articleNowPage != articleTotalPage {
                                        Button(action: {
                                            articleNowPage += 1
                                            RefreshArticles()
                                        }, label: {
                                            Text("下一页")
                                                .bold()
                                        })
                                    }
                                } else {
                                    if isNoArticle {
                                        Text("该用户无专栏")
                                    } else {
                                        ProgressView()
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
                .tag(2)
                .navigationTitle(viewSelector == .video ? "\(videoCount) 视频" : "\(articalCount) 专栏")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            if viewSelector == .video {
                                viewSelector = .article
                            } else if viewSelector == .article {
                                viewSelector = .video
                            }
                        }, label: {
                            Image(systemName: viewSelector == .video ? "play.circle" : "doc.text.image")
                        })
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
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/followings?vmid=\(uid)") { respJson, isSuccess in
                                if isSuccess {
                                    followCount = respJson["data"]["total"].int ?? -1
                                }
                            }
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
                        videoCount = respJson["data"]["page"]["count"].int!
                        if !isVideosLoaded {
                            if videos.count == 0 {
                                isNoVideo = true
                            }
                            isVideosLoaded = true
                        }
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
                        articalCount = respJson["data"]["count"].int ?? 0
                        if !isArticlesLoaded {
                            if articles.count == 0 {
                                isNoArticle = true
                            }
                            isArticlesLoaded = true
                        }
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
