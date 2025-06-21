//
//
//  UserDetailView.swift
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
import DarockUI
import Alamofire
import SwiftyJSON
import DarockFoundation
import AuthenticationServices
import SDWebImageSwiftUI

struct UserDetailView: View {
    var uid: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("CachedBiliTicket") var cachedBiliTicket = ""
    @State var userFaceUrl = ""
    @State var userFaceAvgColor = ""
    @State var backgroundPicOpacity = 0.0
    @State var username = ""
    @State var userLevel = 0
    @State var officialType = -1
    @State var officialTitle = ""
    @State var userSign = ""
    @State var followCount = -1
    @State var fansCount = -1
    @State var vipLabel = ""
    @State var videos = [[String: String]]()
    @State var viewSelector: UserDetailViewPubsType = .video
    @State var articles = [[String: String]]()
    @State var videoCount = 0
    @State var articalCount = 0
    @State var coinCount = -1
    @State var isFollowed = false
    @State var isInfoSheetPresented = false
    @State var currentExp = 0
    @State var nextExp = 0
    @State var minExp = 0
    #if os(watchOS)
    @State var isSendbMessagePresented = false
    #endif
    let levelColors = [Color(red: 192/255, green: 192/255, blue: 192/255), //0
                       Color(red: 192/255, green: 192/255, blue: 192/255), //1
                       Color(red: 155/255, green: 208/255, blue: 160/255), //2
                       Color(red: 142/255, green: 203/255, blue: 235/255), //3
                       Color(red: 244/255, green: 190/255, blue: 146/255), //4
                       Color(red: 222/255, green: 111/255, blue: 60/255), //5
                       Color(red: 234/255, green: 51/255, blue: 35/255)]  //6
    var body: some View {
        Group {
            #if !os(watchOS)
            TabView {
                ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: 20)
                        HStack {
                            Spacer()
                            WebImage(url: URL(string: userFaceUrl))
                                .resizable()
                                .placeholder {
                                    Circle()
                                        .redacted(reason: .placeholder)
                                }
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            VStack {
                                if followCount != -1 {
                                    Text(String(followCount))
                                        .font(.system(size: 18))
                                } else {
                                    Text("114")
                                        .font(.system(size: 18))
                                        .redacted(reason: .placeholder)
                                }
                                Text("Account.subscribed")
                                    .font(.system(size: 16))
                                    .opacity(0.6)
                                    .lineLimit(1)
                            }
                            Spacer()
                            VStack {
                                if fansCount != -1 {
                                    Text(String(fansCount).shorter())
                                        .font(.system(size: 18))
                                } else {
                                    Text("114")
                                        .font(.system(size: 18))
                                        .redacted(reason: .placeholder)
                                }
                                Text("Account.followers")
                                    .font(.system(size: 16))
                                    .opacity(0.6)
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                        if dedeUserID == uid {
                            HStack {
                                Text("")
                                    .font(.custom("bilibili", size: 20))
                                    .opacity(0.55)
                                    .offset(y: 1)
                                Text(String(coinCount))
                                    .font(.system(size: 20))
                            }
                        }
                        HStack {
                            if dedeUserID != uid {
                                Button(action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata);",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(uid)!, act: isFollowed ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                                        debugPrint(response)
                                        let json = try! JSON(data: response.data!)
                                        let code = json["code"].int!
                                        if code == 0 {
                                            tipWithText(isFollowed ? String(localized: "Account.tips.unfollowed") : String(localized: "Account.tips.followed"), symbol: "checkmark.circle.fill")
                                            isFollowed.toggle()
                                        } else {
                                            tipWithText(json["message"].string!, symbol: "checkmark.circle.fill")
                                        }
                                    }
                                }, label: {
                                    HStack {
                                        Image(systemName: isFollowed ? "person.badge.minus" : "person.badge.plus")
                                        Text(isFollowed ? String(localized: "Account.unfollow") : String(localized: "Account.follow"))
                                    }
                                })
                                .buttonStyle(.borderedProminent)
                            }
                            NavigationLink(destination: { bMessageSendView(uid: Int64(uid)!, username: username) }, label: {
                                HStack {
                                    Image(systemName: "ellipsis.bubble")
                                    Text("Account.direct-message")
                                }
                            })
                            .buttonStyle(.borderedProminent)
                        }
                        if uid == dedeUserID {
                            if userLevel > 0 {
                                Gauge(value: Double(currentExp), in: Double(min(minExp, nextExp))...Double(max(minExp, nextExp)), label: {
                                    Text("经验")
                                }, currentValueLabel: {
                                    Text(String(currentExp))
                                }, minimumValueLabel: {
                                    Text(String(minExp))
                                }, maximumValueLabel: {
                                    Text(String(nextExp))
                                })
                                .gaugeStyle(.accessoryLinear)
                                .tint(Gradient(colors: [levelColors[userLevel - 1], levelColors[userLevel]]))
                            }
                        }
                        HStack {
                            Image(systemName: "person.text.rectangle")
                                .foregroundColor(.secondary)
                                .frame(width: 20, height: 20)
                            Text(uid)
                                .font(.system(size: 15))
                            Spacer()
                        }
                        if officialType != -1 {
                            HStack {
                                Image(systemName: "bolt.circle")
                                    .foregroundColor(officialType == 0 ? Color(hex: 0xFDD663) : Color(hex: 0xA0C0F4))
                                    .frame(width: 20, height: 20)
                                Text("\(Text(String(localized: "Account.certification")).bold())\n\(officialTitle)")
                                    .font(.system(size: 15))
                                Spacer()
                            }
                        }
                        if !vipLabel.isEmpty {
                            HStack {
                                WebImage(url: URL(string: "https://s1.hdslb.com/bfs/seed/jinkela/short/user-avatar/big-vip.svg"))
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(vipLabel)
                                    .font(.system(size: 15))
                                    .bold()
                                Spacer()
                            }
                        }
                        HStack {
                            Image(systemName: "graduationcap.circle")
                                .foregroundColor(levelColors[userLevel])
                                .frame(width: 20, height: 20)
                            Text("Lv\(userLevel)")
                                .font(.system(size: 15))
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.secondary)
                                .frame(width: 20, height: 20)
                            Text(userSign)
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                    .padding()
                }
                .tag(1)
                .tabItem {
                    Label("详情", systemImage: "ellipsis")
                }
                UserDynamicListView(uid: uid)
                    .tag(2)
                    .tabItem {
                        Label("动态", systemImage: "rectangle.stack.fill")
                    }
                VideosListBase(uid: uid, username: $username, videos: $videos, articles: $articles, viewSelector: $viewSelector, videoCount: $videoCount, articalCount: $articalCount)
                    .tag(3)
                    .navigationTitle(viewSelector == .video ? "Account.videos.\(videoCount)" : "Account.articals.\(articalCount)")
                    .tabItem {
                        Label("稿件", systemImage: "doc.on.doc.fill")
                    }
            }
            #else
            TabView {
                FirstPageBase(uid: uid, userFaceUrl: $userFaceUrl, username: $username, followCount: $followCount, fansCount: $fansCount, coinCount: $coinCount, isFollowed: $isFollowed, isSendbMessagePresented: $isSendbMessagePresented)
                    .navigationDestination(isPresented: $isSendbMessagePresented, destination: { bMessageSendView(uid: Int64(uid)!, username: username) })
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata);"
                                ]
                                AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(uid)!, act: isFollowed ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                                    debugPrint(response)
                                    let json = try! JSON(data: response.data!)
                                    let code = json["code"].int!
                                    if code == 0 {
                                        tipWithText(isFollowed ? String(localized: "Account.tips.unfollowed") : String(localized: "Account.tips.followed"), symbol: "checkmark.circle.fill")
                                        isFollowed.toggle()
                                    } else {
                                        tipWithText(json["message"].string!, symbol: "xmark.circle.fill")
                                    }
                                }
                            }, label: {
                                Image(systemName: isFollowed ? "person.badge.minus" : "person.badge.plus")
                            })
                            VStack {
                                if dedeUserID == uid {
                                    HStack {
                                        Image(systemName: "b.circle")
                                            .font(.system(size: 12))
                                            .opacity(0.55)
                                            .offset(y: 1)
                                        if coinCount != -1 {
                                            Text(String(coinCount))
                                                .font(.system(size: 14))
                                        } else {
                                            Text("114")
                                                .font(.system(size: 14))
                                                .redacted(reason: .placeholder)
                                        }
                                    }
                                }
                                Button(action: {
                                    isInfoSheetPresented = true
                                }, label: {
                                    Text(officialType == -1 ? "Account.info" : "Account.certification")
                                })
                                .buttonStyle(.borderless)
                                .font(.caption)
                            }
                            Button(action: {
                                isSendbMessagePresented = true
                            }, label: {
                                Image(systemName: "ellipsis.bubble")
                            })
                        }
                    }
                    .navigationTitle(username)
                    .sheet(isPresented: $isInfoSheetPresented, content: {
                        ScrollView {
                            SecondPageBase(uid: uid, officialType: $officialType, officialTitle: $officialTitle, userSign: $userSign, userLevel: $userLevel, vipLabel: $vipLabel)
                        }
                    })
                    .tag(1)
                VideosListBase(uid: uid, username: $username, videos: $videos, articles: $articles, viewSelector: $viewSelector, videoCount: $videoCount, articalCount: $articalCount)
                    .tag(2)
                    .navigationTitle(viewSelector == .video ? "Account.videos.\(videoCount)" : "Account.articals.\(articalCount)")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                if viewSelector == .video {
                                    viewSelector = .article
                                } else if viewSelector == .article {
                                    viewSelector = .dynamic
                                } else if viewSelector == .dynamic {
                                    viewSelector = .video
                                }
                            }, label: {
                                Image(systemName: viewSelector == .video ? "play.circle" : viewSelector == .article ? "doc.text.image" : "doc.richtext")
                            })
                        }
                    }
            }
            .tabViewStyle(.verticalPage)
            .containerBackground(userFaceAvgColor.isEmpty ? Color.accentColor.gradient : {
                let hexSanitized = userFaceAvgColor.hasPrefix("#") ? String(userFaceAvgColor.dropFirst()) : userFaceAvgColor
                guard hexSanitized.count == 6, let intValue = Int(hexSanitized, radix: 16) else {
                    return Color.accentColor.gradient
                }
                let red = Double((intValue >> 16) & 0xFF) / 255.0
                let green = Double((intValue >> 8) & 0xFF) / 255.0
                let blue = Double(intValue & 0xFF) / 255.0
                return Color(red: red, green: green, blue: blue).gradient
            }(), for: .navigation)
            #endif
        }
        .onAppear {
            Task {
                if let info = await BiliAPI.shared.userInfo(of: uid) {
                    userFaceUrl = info.face
                    username = info.name
                    userLevel = info.level
                    officialType = info.official.type
                    officialTitle = info.official.title
                    userSign = info.sign
                    coinCount = Int(info.coins)
                    vipLabel = info.vip?.label.text ?? ""
                    if let relation = await BiliAPI.shared.userRelation(of: uid) {
                        followCount = relation.following
                        fansCount = relation.follower
                    }
                    requestJSON("\(userFaceUrl)@.avg_color") { respJson, isSuccess in
                        if isSuccess {
                            withAnimation(.easeOut) {
                                userFaceAvgColor = respJson["RGB"].string ?? ""
                            }
                        }
                    }
                }
            }
            Task {
                isFollowed = await BiliAPI.shared.isFollowed(user: uid)
            }
            if uid == dedeUserID {
                Task {
                    if let exp = await BiliAPI.shared.currentUserExperience() {
                        currentExp = exp.current
                        nextExp = exp.next
                        minExp = exp.min
                    }
                }
            }
        }
    }
    
    #if !os(watchOS)
    struct VideosListBase: View {
        var uid: String
        @Binding var username: String
        @Binding var videos: [[String: String]]
        @Binding var articles: [[String: String]]
        @Binding var viewSelector: UserDetailViewPubsType
        @Binding var videoCount: Int
        @Binding var articalCount: Int
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var isNoVideo = false
        @State var isNoArticle = false
        @State var isVideosLoaded = false
        @State var isArticlesLoaded = false
        @State var videoTotalPage = 1
        @State var videoNowPage = 1
        @State var articleTotalPage = 1
        @State var articleNowPage = 1
        @State var isVideoPageJumpPresented = false
        @State var videoTargetJumpPageCache = ""
        @State var isArticalPageJumpPresented = false
        @State var articleTargetJumpPageCache = ""
        var body: some View {
            List {
                Section {
                    Button(action: {
                        if viewSelector == .video {
                            viewSelector = .article
                            RefreshArticles()
                        } else if viewSelector == .article {
                            articles.removeAll()
                            viewSelector = .video
                        }
                    }, label: {
                        HStack {
                            Image(systemName: viewSelector == .video ? "play.circle" : "doc.text.image")
                            Text(viewSelector == .video ? String(localized: "Account.check-videos") : String(localized: "Account.check-articles"))
                        }
                    })
                }
                if viewSelector == .video {
                    if videos.count != 0 {
                        Section {
                            ForEach(0...videos.count - 1, id: \.self) { i in
                                VideoCard(["Pic": videos[i]["PicUrl"]!, "Title": videos[i]["Title"]!, "BV": videos[i]["BV"]!, "UP": username, "View": videos[i]["PlayCount"]!, "Danmaku": videos[i]["DanmakuCount"]!])
                            }
                        }
                        Section {
                            if videoNowPage != 1 {
                                Button(action: {
                                    videoNowPage -= 1
                                    RefreshVideos()
                                }, label: {
                                    Text("Account.list.last-page")
                                        .bold()
                                })
                            }
                            Text("\(videoNowPage) / \(videoTotalPage)")
                                .font(.system(size: 18, weight: .bold))
                                .sheet(isPresented: $isVideoPageJumpPresented, content: {
                                    VStack {
                                        Text("Account.list.goto")
                                            .font(.system(size: 20, weight: .bold))
                                        HStack {
                                            TextField("Account.list.destination", text: $videoTargetJumpPageCache) {
                                                if let cInt = Int(videoTargetJumpPageCache) {
                                                    if cInt <= 0 {
                                                        videoTargetJumpPageCache = "1"
                                                    }
                                                    if cInt > videoTotalPage {
                                                        videoTargetJumpPageCache = String(videoTotalPage)
                                                    }
                                                } else {
                                                    videoTargetJumpPageCache = String(videoNowPage)
                                                }
                                            }
                                            Text(" / \(videoTotalPage)")
                                        }
                                        Button(action: {
                                            if let cInt = Int(videoTargetJumpPageCache) {
                                                videoNowPage = cInt
                                                RefreshVideos()
                                            }
                                            isVideoPageJumpPresented = false
                                        }, label: {
                                            Text("Account.list.go")
                                        })
                                    }
                                })
                                .onTapGesture {
                                    videoTargetJumpPageCache = String(videoNowPage)
                                    isVideoPageJumpPresented = true
                                }
                            if videoNowPage != videoTotalPage {
                                Button(action: {
                                    videoNowPage += 1
                                    RefreshVideos()
                                }, label: {
                                    Text("Account.list.next-page")
                                        .bold()
                                })
                            }
                        }
                    } else {
                        if isNoVideo {
                            Text("Account.list.no-video")
                        } else {
                            ProgressView()
                        }
                    }
                } else if viewSelector == .article {
                    if articles.count != 0 {
                        Section {
                            ForEach(0...articles.count - 1, id: \.self) { i in
                                ArticleCard(articles[i])
                            }
                        }
                        Section {
                            if articleNowPage != 1 {
                                Button(action: {
                                    articleNowPage -= 1
                                    RefreshArticles()
                                }, label: {
                                    Text("Account.list.last-page")
                                        .bold()
                                })
                            }
                            Text("\(articleNowPage) / \(articleTotalPage)")
                                .font(.system(size: 18, weight: .bold))
                                .sheet(isPresented: $isArticalPageJumpPresented, content: {
                                    VStack {
                                        Text("Account.list.goto")
                                            .font(.system(size: 20, weight: .bold))
                                        HStack {
                                            TextField("Account.list.destination", text: $articleTargetJumpPageCache) {
                                                if let cInt = Int(articleTargetJumpPageCache) {
                                                    if cInt <= 0 {
                                                        articleTargetJumpPageCache = "1"
                                                    }
                                                    if cInt > articleTotalPage {
                                                        articleTargetJumpPageCache = String(articleTotalPage)
                                                    }
                                                } else {
                                                    articleTargetJumpPageCache = String(articleNowPage)
                                                }
                                            }
                                            Text(" / \(articleTotalPage)")
                                        }
                                        Button(action: {
                                            if let cInt = Int(articleTargetJumpPageCache) {
                                                articleNowPage = cInt
                                                RefreshArticles()
                                            }
                                            isArticalPageJumpPresented = false
                                        }, label: {
                                            Text("Account.list.go")
                                        })
                                    }
                                })
                                .onTapGesture {
                                    articleTargetJumpPageCache = String(articleNowPage)
                                    isArticalPageJumpPresented = true
                                }
                            if articleNowPage != articleTotalPage {
                                Button(action: {
                                    articleNowPage += 1
                                    RefreshArticles()
                                }, label: {
                                    Text("Account.list.next-page")
                                        .bold()
                                })
                            }
                        }
                    } else {
                        if isNoArticle {
                            Text("Account.list.no-article")
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            .onAppear {
                if !isVideosLoaded {
                    RefreshVideos()
                }
            }
        }
        
        func RefreshVideos() {
            videos = [[String: String]]()
            let headers: HTTPHeaders = [
                //"accept": "*/*",
                //"accept-encoding": "gzip, deflate, br",
                //"accept-language": "zh-CN,zh;q=0.9",
                //"cookie": "\(sessdata == "" ? "" : "SESSDATA=\(sessdata); ")buvid3=\(globalBuvid3); b_nut=\(Date.now.timeStamp); buvid4=\(globalBuvid4);",
                "cookie": "SESSDATA=\(sessdata); buvid_fp=e651c1a382430ea93631e09474e0b395; buvid3=\(UuidInfoc.gen()); buvid4=buvid4-failed-1",
                //"origin": "https://space.bilibili.com",
                //"referer": "https://space.bilibili.com/\(uid)/video",
                //"User-Agent": "Mozilla/5.0" // Bypass? rdar://gh/SocialSisterYi/bilibili-API-collect/issues/868#1859065874
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            biliWbiSign(paramEncoded: "mid=\(uid)&ps=50&pn=\(videoNowPage)&dm_img_list=[]&dm_img_str=V2ViR0wgMS4wIChPcGVuR0wgRVMgMi4wIENocm9taXVtKQ&dm_cover_img_str=VjNEIDQuMkJyb2FkY2".base64Encoded()) { signed in
                if let signed {
                    debugPrint(signed)
                    autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/arc/search?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            if !CheckBApiError(from: respJson) { return }
                            let vlist = respJson["data"]["list"]["vlist"]
                            for video in vlist {
                                videos.append(["Title": video.1["title"].string ?? "[加载失败]", "Length": video.1["length"].string ?? "E", "PlayCount": String(video.1["play"].int ?? -1), "PicUrl": video.1["pic"].string ?? "E", "BV": video.1["bvid"].string ?? "E", "Timestamp": String(video.1["created"].int ?? 0), "DanmakuCount": String(video.1["video_review"].int ?? -1)])
                            }
                            debugPrint(respJson["data"]["page"]["count"].int ?? 0)
                            videoTotalPage = Int((respJson["data"]["page"]["count"].int ?? 0) / 50) + 1
                            videoCount = respJson["data"]["page"]["count"].int ?? 0
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
                "accept-language": "en,zh-CN;q=0.9,zh;q=0.8",
                "cookie": "SESSDATA=\(sessdata);buvid3=\(globalBuvid3); buvid4=\(globalBuvid4);",
                "User-Agent": "Mozilla/5.0" // Bypass? rdar://gh/SocialSisterYi/bilibili-API-collect/issues/868#1859065874
            ]
            biliWbiSign(paramEncoded: "mid=\(uid)&ps=30&pn=\(articleNowPage)&sort=publish_time&platform=web".base64Encoded()) { signed in
                if let signed {
                    debugPrint(signed)
                    requestJSON("https://api.bilibili.com/x/space/wbi/article?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            if !CheckBApiError(from: respJson) { return }
                            let articlesJson = respJson["data"]["articles"]
                            for article in articlesJson {
                                articles.append(["Title": article.1["title"].string ?? "[加载失败]", "Summary": article.1["summary"].string ?? "[加载失败]", "Type": article.1["categories"][0]["name"].string ?? "[加载失败]", "View": String(article.1["stats"]["view"].int ?? -1), "Like": String(article.1["stats"]["like"].int ?? -1), "Pic": article.1["image_urls"][0].string ?? "E", "CV": String(article.1["id"].int ?? 0)])
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
    #else
    struct FirstPageBase: View {
        var uid: String
        @Binding var userFaceUrl: String
        @Binding var username: String
        @Binding var followCount: Int
        @Binding var fansCount: Int
        @Binding var coinCount: Int
        @Binding var isFollowed: Bool
        @Binding var isSendbMessagePresented: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var isAvatorViewPresented = false
        var body: some View {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if userFaceUrl != "" {
                        WebImage(url: URL(string: userFaceUrl + "@100w_100h"))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .onTapGesture {
                                isAvatorViewPresented = true
                            }
                    }
                    Spacer()
                }
                .sheet(isPresented: $isAvatorViewPresented, content: { ImageViewerView(url: userFaceUrl) })
                HStack {
                    Spacer()
                    NavigationLink(destination: { FollowListView(viewUserId: uid) }, label: {
                        VStack {
                            if followCount != -1 {
                                Text(String(followCount))
                                    .font(.system(size: 14))
                            } else {
                                Text("114")
                                    .font(.system(size: 14))
                                    .redacted(reason: .placeholder)
                            }
                            Text("Account.subscribed")
                                .font(.system(size: 12))
                                .opacity(0.6)
                                .lineLimit(1)
                        }
                    })
                    .buttonStyle(.plain)
                    Spacer()
                    NavigationLink(destination: { FansListView(viewUserId: uid) }, label: {
                        VStack {
                            if fansCount != -1 {
                                Text(String(fansCount).shorter())
                                    .font(.system(size: 14))
                            } else {
                                Text("114")
                                    .font(.system(size: 14))
                                    .redacted(reason: .placeholder)
                            }
                            Text("Account.followers")
                                .font(.system(size: 12))
                                .opacity(0.6)
                                .lineLimit(1)
                        }
                    })
                    .buttonStyle(.plain)
                    Spacer()
                }
                if #unavailable(watchOS 10) {
                    if dedeUserID == uid {
                        HStack {
                            Image(systemName: "b.circle")
                                .font(.system(size: 12))
                                .opacity(0.55)
                                .offset(y: 1)
                            Text(String(coinCount))
                                .font(.system(size: 14))
                        }
                    }
                    Button(action: {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata);",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(uid)!, act: isFollowed ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                            debugPrint(response)
                            let json = try! JSON(data: response.data!)
                            let code = json["code"].int!
                            if code == 0 {
                                tipWithText(isFollowed ? String(localized: "Account.tips.unfollowed") : String(localized: "Account.tips.followed"), symbol: "checkmark.circle.fill")
                                isFollowed.toggle()
                            } else {
                                tipWithText(json["message"].string!, symbol: "xmark.circle.fill")
                            }
                        }
                    }, label: {
                        HStack {
                            Image(systemName: isFollowed ? "person.badge.minus" : "person.badge.plus")
                            Text(isFollowed ? String(localized: "Account.unfollow") : String(localized: "Account.follow"))
                        }
                    })
                    NavigationLink("", isActive: $isSendbMessagePresented, destination: { bMessageSendView(uid: Int64(uid)!, username: username) })
                        .frame(width: 0, height: 0)
                    Button(action: {
                        isSendbMessagePresented = true
                    }, label: {
                        HStack {
                            Image(systemName: "ellipsis.bubble")
                            Text("Account.direct-message")
                        }
                    })
                }
                Spacer()
            }
        }
    }
    struct SecondPageBase: View {
        var uid: String
        @Binding var officialType: Int
        @Binding var officialTitle: String
        @Binding var userSign: String
        @Binding var userLevel: Int
        @Binding var vipLabel: String
        let levelColors = [Color(red: 192/255, green: 192/255, blue: 192/255), //0
                           Color(red: 192/255, green: 192/255, blue: 192/255), //1
                           Color(red: 155/255, green: 208/255, blue: 160/255), //2
                           Color(red: 142/255, green: 203/255, blue: 235/255), //3
                           Color(red: 244/255, green: 190/255, blue: 146/255), //4
                           Color(red: 222/255, green: 111/255, blue: 60/255), //5
                           Color(red: 234/255, green: 51/255, blue: 35/255)]  //6
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: "person.text.rectangle")
                        .foregroundColor(.secondary)
                        .frame(width: 20, height: 20)
                    Text(uid)
                        .font(.system(size: 15))
                    Spacer()
                }
                if officialType != -1 {
                    HStack {
                        Image(systemName: "bolt.circle")
                            .foregroundColor(officialType == 0 ? Color(hex: 0xFDD663) : Color(hex: 0xA0C0F4))
                            .frame(width: 20, height: 20)
                        Text("\(Text(String(localized: "Account.certification")).bold())\n\(officialTitle)")
                            .font(.system(size: 15))
                        Spacer()
                    }
                }
                if !vipLabel.isEmpty {
                    HStack {
                        WebImage(url: URL(string: "https://s1.hdslb.com/bfs/seed/jinkela/short/user-avatar/big-vip.svg"))
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(vipLabel)
                            .font(.system(size: 15))
                            .bold()
                        Spacer()
                    }
                }
                HStack {
                    Image(systemName: "graduationcap.circle")
                        .foregroundColor(levelColors[userLevel])
                        .frame(width: 20, height: 20)
                    Text("Lv\(userLevel)")
                        .font(.system(size: 15))
                        .bold()
                    Spacer()
                }
                HStack {
                    VStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.secondary)
                            .frame(width: 20, height: 20)
                        Spacer()
                    }
                    Text(userSign)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    //                            .opacity(0.6)
                    Spacer()
                }
            }
            .padding()
        }
    }
    struct VideosListBase: View {
        var uid: String
        @Binding var username: String
        @Binding var videos: [[String: String]]
        @Binding var articles: [[String: String]]
        @Binding var viewSelector: UserDetailViewPubsType
        @Binding var videoCount: Int
        @Binding var articalCount: Int
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @AppStorage("CachedBiliTicket") var cachedBiliTicket = ""
        @State var isNoVideo = false
        @State var isNoArticle = false
        @State var isVideosLoaded = false
        @State var isArticlesLoaded = false
        @State var videoTotalPage = 1
        @State var videoNowPage = 1
        @State var articleTotalPage = 1
        @State var articleNowPage = 1
        @State var isVideoPageJumpPresented = false
        @State var videoTargetJumpPageCache = ""
        @State var isArticalPageJumpPresented = false
        @State var articleTargetJumpPageCache = ""
        var body: some View {
            VStack {
                ifContainer(viewSelector != .dynamic) { content in
                    List { content }
                } false: { content in
                    ScrollView {
                        VStack {
                            content
                        }
                    }
                } containing: {
                    if #unavailable(watchOS 10) {
                        Button(action: {
                            if viewSelector == .video {
                                viewSelector = .article
                            } else if viewSelector == .article {
                                viewSelector = .dynamic
                            } else if viewSelector == .dynamic {
                                viewSelector = .video
                            }
                        }, label: {
                            HStack {
                                Image(systemName: viewSelector == .video ? "play.circle" : "doc.text.image")
                                Text(viewSelector == .video ? String(localized: "Account.check-videos") : String(localized: "Account.check-articles"))
                            }
                        })
                        Spacer()
                            .frame(height: 20)
                    }
                    if viewSelector == .video {
                        if !videos.isEmpty {
                            Section {
                                ForEach(0..<videos.count, id: \.self) { i in
                                    if videos[i]["IsSeasonArchive"] != "true" {
                                        VideoCard(["Pic": videos[i]["PicUrl"]!, "Title": videos[i]["Title"]!, "BV": videos[i]["BV"]!, "UP": username, "View": videos[i]["PlayCount"]!, "Danmaku": videos[i]["DanmakuCount"]!])
                                    } else {
                                        NavigationLink(destination: { SeasonArchiveListView(mid: videos[i]["MID"]!, seasonID: videos[i]["SeasonID"]!, username: username) }, label: {
                                            VStack {
                                                HStack {
                                                    WebImage(url: URL(string: videos[i]["PicUrl"]! + "@100w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                                                        .placeholder {
                                                            RoundedRectangle(cornerRadius: 7)
                                                                .frame(width: 50, height: 30)
                                                                .foregroundColor(Color(hex: 0x3D3D3D))
                                                                .redacted(reason: .placeholder)
                                                        }
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 50)
                                                        .cornerRadius(7)
                                                    Text(videos[i]["Title"]!)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .lineLimit(2)
                                                        .multilineTextAlignment(.leading)
                                                    Spacer()
                                                }
                                                HStack {
                                                    Image(systemName: "play.circle")
                                                    Text(videos[i]["PlayCount"]!.shorter())
                                                        .offset(x: -3)
                                                    Image(systemName: "square.3.layers.3d")
                                                    Text(videos[i]["EPCount"]!)
                                                        .offset(x: -3)
                                                    Spacer()
                                                }
                                                .lineLimit(1)
                                                .font(.system(size: 11))
                                                .foregroundColor(.gray)
                                            }
                                        })
                                    }
                                }
                            }
                            Section {
                                HStack {
                                    if videoNowPage != 1 {
                                        Button(action: {
                                            videoNowPage -= 1
                                            refreshVideos()
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
                                    Text("\(videoNowPage) / \(videoTotalPage)")
                                        .font(.system(size: 18, weight: .bold))
                                        .sheet(isPresented: $isVideoPageJumpPresented, content: {
                                            VStack {
                                                Text("Account.list.goto")
                                                    .font(.system(size: 20, weight: .bold))
                                                HStack {
                                                    TextField("Account.list.destination", text: $videoTargetJumpPageCache) {
                                                        if let cInt = Int(videoTargetJumpPageCache) {
                                                            if cInt <= 0 {
                                                                videoTargetJumpPageCache = "1"
                                                            }
                                                            if cInt > videoTotalPage {
                                                                videoTargetJumpPageCache = String(videoTotalPage)
                                                            }
                                                        } else {
                                                            videoTargetJumpPageCache = String(videoNowPage)
                                                        }
                                                    }
                                                    Text(" / \(videoTotalPage)")
                                                }
                                                Button(action: {
                                                    if let cInt = Int(videoTargetJumpPageCache) {
                                                        videoNowPage = cInt
                                                        refreshVideos()
                                                    }
                                                    isVideoPageJumpPresented = false
                                                }, label: {
                                                    Text("Account.list.go")
                                                })
                                            }
                                        })
                                        .onTapGesture {
                                            videoTargetJumpPageCache = String(videoNowPage)
                                            isVideoPageJumpPresented = true
                                        }
                                    Spacer()
                                    if videoNowPage != videoTotalPage {
                                        Button(action: {
                                            videoNowPage += 1
                                            refreshVideos()
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
                        } else {
                            if isNoVideo {
                                Text("Account.list.no-video")
                            } else {
                                ProgressView()
                            }
                        }
                    } else if viewSelector == .article {
                        Section {
                            if articles.count != 0 {
                                ForEach(0...articles.count - 1, id: \.self) { i in
                                    NavigationLink(destination: { ArticleView(cvid: articles[i]["CV"]!) }, label: {
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
                            } else {
                                if isNoArticle {
                                    Text("Account.list.no-article")
                                } else {
                                    ProgressView()
                                }
                            }
                        }
                        Section {
                            HStack {
                                if articleNowPage != 1 {
                                    Button(action: {
                                        articleNowPage -= 1
                                        refreshArticles()
                                    }, label: {
                                        Image(systemName: "chevron.left")
                                            .bold()
                                    })
                                    .buttonStyle(.bordered)
                                    .buttonBorderShape(.roundedRectangle(radius: 0))
                                    .frame(width: 30)
                                }
                                Spacer()
                                Text("\(articleNowPage) / \(articleTotalPage)")
                                    .font(.system(size: 18, weight: .bold))
                                    .sheet(isPresented: $isArticalPageJumpPresented, content: {
                                        VStack {
                                            Text("Account.list.goto")
                                                .font(.system(size: 20, weight: .bold))
                                            HStack {
                                                TextField("Account.list.destination", text: $articleTargetJumpPageCache) {
                                                    if let cInt = Int(articleTargetJumpPageCache) {
                                                        if cInt <= 0 {
                                                            articleTargetJumpPageCache = "1"
                                                        }
                                                        if cInt > articleTotalPage {
                                                            articleTargetJumpPageCache = String(articleTotalPage)
                                                        }
                                                    } else {
                                                        articleTargetJumpPageCache = String(articleNowPage)
                                                    }
                                                }
                                                Text(" / \(articleTotalPage)")
                                            }
                                            Button(action: {
                                                if let cInt = Int(articleTargetJumpPageCache) {
                                                    articleNowPage = cInt
                                                    refreshArticles()
                                                }
                                                isArticalPageJumpPresented = false
                                            }, label: {
                                                Text("Account.list.go")
                                            })
                                        }
                                    })
                                    .onTapGesture {
                                        articleTargetJumpPageCache = String(articleNowPage)
                                        isArticalPageJumpPresented = true
                                    }
                                Spacer()
                                if articleNowPage != articleTotalPage {
                                    Button(action: {
                                        articleNowPage += 1
                                        refreshArticles()
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
                    } else if viewSelector == .dynamic {
                        UserDynamicListView(uid: uid)
                    }
                }
            }
            .onAppear {
                if !isVideosLoaded {
                    refreshVideos()
                }
            }
            .onChange(of: viewSelector) {
                switch viewSelector {
                case .video:
                    break
                case .article:
                    refreshArticles()
                case .dynamic:
                    break
                }
            }
        }
        
        func refreshVideos() {
            videos.removeAll()
            let headers: HTTPHeaders = [
                "accept": "*/*",
                "accept-encoding": "gzip, deflate, br",
                "accept-language": "zh-CN,zh;q=0.9",
                "cookie": "SESSDATA=\(sessdata); buvid_fp=e651c1a382430ea93631e09474e0b395; buvid3=\(UuidInfoc.gen()); buvid4=buvid4-failed-1; bili_ticket=\(cachedBiliTicket)",
                "origin": "https://space.bilibili.com",
                "referer": "https://space.bilibili.com/\(uid)/video",
//                "User-Agent": "Mozilla/5.0" // Bypass? rdar://gh/SocialSisterYi/bilibili-API-collect/issues/868#1859065874
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            biliWbiSign(paramEncoded: "mid=\(uid)&ps=50&pn=\(videoNowPage)&dm_img_list=[]&dm_img_str=V2ViR0wgMS4wIChPcGVuR0wgRVMgMi4wIENocm9taXVtKQ&dm_cover_img_str=VjNEIDQuMkJyb2FkY2".base64Encoded()) { signed in
                if let signed {
                    requestJSON("https://api.bilibili.com/x/space/wbi/arc/search?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            DispatchQueue(label: "com.darock.DarockBili.Video-Load", qos: .userInitiated).async {
                                if !CheckBApiError(from: respJson) { return }
                                let vlist = respJson["data"]["list"]["vlist"]
                                for video in vlist {
                                    var data = ["Title": video.1["title"].string ?? "[加载失败]", "Length": video.1["length"].string ?? "E", "PlayCount": String(video.1["play"].int ?? -1), "PicUrl": video.1["pic"].string ?? "E", "BV": video.1["bvid"].string ?? "E", "Timestamp": String(video.1["created"].int ?? 0), "DanmakuCount": String(video.1["video_review"].int ?? -1)]
                                    if video.1["meta"].dictionary != nil && video.1["meta"]["sign_state"].int != 0 {
                                        let season = video.1["meta"]
                                        data.updateValue(season["title"].string ?? "[加载失败]", forKey: "Title")
                                        data.updateValue(season["cover"].string ?? "E", forKey: "PicUrl")
                                        data.updateValue(String(season["id"].int ?? -1), forKey: "SeasonID")
                                        data.updateValue(String(season["mid"].int64 ?? 1), forKey: "MID")
                                        data.updateValue(String(season["ep_count"].int ?? -1), forKey: "EPCount")
                                        data.updateValue("true", forKey: "IsSeasonArchive")
                                    }
                                    videos.append(data)
                                }
                                videoTotalPage = Int((respJson["data"]["page"]["count"].int ?? 0) / 50) + 1
                                videoCount = respJson["data"]["page"]["count"].int ?? 0
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
        }
        func refreshArticles() {
            articles = [[String: String]]()
            let headers: HTTPHeaders = [
                "accept-language": "en,zh-CN;q=0.9,zh;q=0.8",
                "cookie": "SESSDATA=\(sessdata);buvid3=\(globalBuvid3); buvid4=\(globalBuvid4);",
                "User-Agent": "Mozilla/5.0" // Bypass? rdar://gh/SocialSisterYi/bilibili-API-collect/issues/868#1859065874
            ]
            biliWbiSign(paramEncoded: "mid=\(uid)&ps=30&pn=\(articleNowPage)&sort=publish_time&platform=web".base64Encoded()) { signed in
                if let signed {
                    requestJSON("https://api.bilibili.com/x/space/wbi/article?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            DispatchQueue(label: "com.darock.DarockBili.Article-Load", qos: .userInitiated).async {
                                if !CheckBApiError(from: respJson) { return }
                                let articlesJson = respJson["data"]["articles"]
                                for article in articlesJson {
                                    articles.append(["Title": article.1["title"].string ?? "[加载失败]", "Summary": article.1["summary"].string ?? "[加载失败]", "Type": article.1["categories"][0]["name"].string ?? "[加载失败]", "View": String(article.1["stats"]["view"].int ?? -1), "Like": String(article.1["stats"]["like"].int ?? -1), "Pic": article.1["image_urls"][0].string ?? "E", "CV": String(article.1["id"].int ?? 0)])
                                }
                                articleTotalPage = Int((respJson["data"]["count"].int ?? 0) / 30) + 1
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
    }
    #endif
}

struct ModifyUserRelation: Codable {
    let fid: Int64
    let act: Int
    var re_src: Int = 11
    let csrf: String
}

enum UserDetailViewPubsType {
    case video
    case article
    case dynamic
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(uid: "356891781")
    }
}
