//
//
//  VideoDetailView.swift
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

import UIKit
import AVKit
import SwiftUI
import Marquee
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation
import CachedAsyncImage
import SDWebImageSwiftUI

struct VideoDetailView: View {
    public static var willPlayVideoLink = ""
    public static var willPlayVideoBV = ""
    public static var willPlayVideoCID: Int64 = 0
    @State var videoDetails: [String: String]
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("VideoGetterSource") var videoGetterSource = "official"
    @AppStorage("IsDanmakuEnabled") var isDanmakuEnabled = true
    @State var isDecoded = false
    @State var isLiked = false
    @State var isCoined = false
    @State var isFavoured = false
    @State var isCoinViewPresented = false
    @State var videoPages = [[String: String]]()
    @State var goodVideos = [[String: String]]()
    @State var owner = [String: String]()
    @State var stat = [String: String]()
    @State var honors = [String]()
    @State var tags = [String]()
    @State var subTitles = [[String: String]]()
    @State var ownerFansCount: Int64 = 0
    @State var nowPlayingCount = "0"
    @State var publishTime = ""
    @State var videoDesc = ""
    @State var isVideoPlayerPresented = false
    @State var isMoreMenuPresented = false
    @State var isDownloadPresented = false
    @State var isNowPlayingPresented = false
    @State var backgroundPicOpacity = 0.0
    @State var mainVerticalTabViewSelection = 1
    @State var videoPartShouldShowDownloadTip = false
    @State var isCoverImageViewPresented = false
    @State var tagText = ""
    @State var isFavoriteChoosePresented = false
    @State var tagDisplayedNum = 0
    @State var currentDetailSelection = 1
    var body: some View {
        VStack {
            if isDecoded {
                VideoPlayerView(isDanmakuEnabled: $isDanmakuEnabled)
                    .frame(height: 240)
            } else {
                Rectangle()
                    .frame(height: 240)
                    .redacted(reason: .placeholder)
            }
            HStack {
                Spacer()
                Button(action: {
                    isDanmakuEnabled.toggle()
                }, label: {
                    Text(isDanmakuEnabled ? "" : "")
                        .font(.custom("bilibili", size: 28))
                        .foregroundColor(isDanmakuEnabled ? .accentColor : .gray)
                })
            }
            .padding(.horizontal)
            VStack {
                Picker("", selection: $currentDetailSelection) {
                    Text("详情").tag(1)
                    Text("评论").tag(2)
                    if goodVideos.count != 0 {
                        Text("推荐").tag(3)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                if currentDetailSelection == 1 {
                    ScrollView {
                        VStack {
                            HStack {
                                if honors.count >= 4 {
                                    if honors[3] != "" {
                                        HStack {
                                            Image(systemName: "flame.fill")
                                            Text("Video.trending")
                                        }
                                        .font(.system(size: 11))
                                        .foregroundColor(.red)
                                        .padding(5)
                                        .background {
                                            Capsule()
                                                .fill(.white)
                                                .opacity(0.3)
                                        }
                                    }
                                }
                                Marquee {
                                    HStack {
                                        Text(videoDetails["Title"]!)
                                            .lineLimit(1)
                                            .font(.system(size: 18, weight: .bold))
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .marqueeWhenNotFit(true)
                                .marqueeDuration(10)
                                .frame(height: 20)
                                .padding(.horizontal, 10)
                            }
                            Spacer()
                                .frame(height: 20)
                            if #unavailable(watchOS 10) {
                                NavigationLink("", isActive: $isNowPlayingPresented, destination: {AudioPlayerView(videoDetails: videoDetails, subTitles: subTitles)})
                                    .frame(width: 0, height: 0)
                                Button(action: {
                                    if videoGetterSource == "official" {
                                        let headers: HTTPHeaders = [
                                            "cookie": "SESSDATA=\(sessdata)",
                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                        ]
                                        AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers).response { response in
                                            let cid = Int64((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                            VideoDetailView.willPlayVideoCID = cid
                                            AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                                VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                isNowPlayingPresented = true
                                                
                                            }
                                        }
                                    } else if videoGetterSource == "injahow" {
                                        DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                            if isSuccess {
                                                VideoDetailView.willPlayVideoLink = respStr
                                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                isNowPlayingPresented = true
                                                
                                            }
                                        }
                                    }
                                }, label: {
                                    Label("Video.play-in-audio", systemImage: "waveform")
                                })
                                Button(action: {
                                    isMoreMenuPresented = true
                                }, label: {
                                    Label("Video.more", systemImage: "ellipsis")
                                })
                                .sheet(isPresented: $isMoreMenuPresented, content: {
                                    List {
                                        Button(action: {
                                            isDownloadPresented = true
                                        }, label: {
                                            Label("Video.download", image: "arrow.down.doc")
                                        })
                                        .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                                        Button(action: {
                                            let headers: HTTPHeaders = [
                                                "cookie": "SESSDATA=\(sessdata)",
                                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                            ]
                                            AF.request("https://api.bilibili.com/x/v2/history/toview/add", method: .post, parameters: ["bvid": videoDetails["BV"]!, "csrf": biliJct], headers: headers).response { response in
                                                do {
                                                    let json = try JSON(data: response.data ?? Data())
                                                    if let code = json["code"].int {
                                                        if code == 0 {
                                                            AlertKitAPI.present(title: String(localized: "Video.added"), icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                                        } else {
                                                            AlertKitAPI.present(title: json["message"].string ?? String(localized: "Video.unkonwn-error"), icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                                        }
                                                    } else {
                                                        AlertKitAPI.present(title: String(localized: "Video.unkonwn-error"), icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                                    }
                                                } catch {
                                                    AlertKitAPI.present(title: String(localized: "Video.unkonwn-error"), icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                                }
                                            }
                                        }, label: {
                                            Label("Video.watch-later", systemImage: "memories.badge.plus")
                                        })
                                    }
                                })
                            }
                            if owner["ID"] != nil {
                                NavigationLink(destination: {UserDetailView(uid: owner["ID"]!)}, label: {
                                    HStack {
                                        AsyncImage(url: URL(string: owner["Face"]! + "@40w"))
                                            .cornerRadius(100)
                                            .frame(width: 40, height: 40)
                                        VStack {
                                            HStack {
                                                Text(owner["Name"]!)
                                                    .font(.system(size: 16, weight: .bold))
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.1)
                                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("Video.fans.\(String(ownerFansCount).shorter())")
                                                    .font(.system(size: 11))
                                                    .lineLimit(1)
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(5)
                                    .background(Color.gray.opacity(0.35))
                                    .cornerRadius(12)
                                })
                            }
                            LazyVStack {
                                HStack {
                                    Button(action: {
                                        let headers: HTTPHeaders = [
                                            "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3)",
                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                        ]
                                        AF.request("https://api.bilibili.com/x/web-interface/archive/like", method: .post, parameters: ["bvid": videoDetails["BV"]!, "like": isLiked ? 2 : 1, "eab_x": 2, "ramval": 0, "source": "web_normal", "ga": 1, "csrf": biliJct], headers: headers).response { response in
                                            debugPrint(response)
                                            isLiked ? AlertKitAPI.present(title: String(localized: "Video.action.canceled"), icon: .done, style: .iOS17AppleMusic, haptic: .success) : AlertKitAPI.present(title: String(localized: "Video.action.liked"), icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                            isLiked.toggle()
                                        }
                                    }, label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundStyle(isLiked ? Color(hex: 0xfa678e) : Color.gray.opacity(0.35))
                                            VStack {
                                                Text(isLiked ? "" : "")
                                                    .font(.custom("bilibili", size: 20))
                                                    .foregroundColor(isLiked ? .white : (colorScheme == .dark ? .white : .black))
                                                Text(stat["Like"]?.shorter() ?? "")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(isLiked ? .white : (colorScheme == .dark ? .white : .black))
                                                    .opacity(isLiked ? 1 : 0.6)
                                                    .minimumScaleFactor(0.1)
                                                    .scaledToFit()
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    })
                                    Button(action: {
                                        if !isCoined {
                                            isCoinViewPresented = true
                                        }
                                    }, label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundStyle(isCoined ? Color(hex: 0xfa678e) : Color.gray.opacity(0.35))
                                            VStack {
                                                Text(isCoined ? "" : "")
                                                    .font(.custom("bilibili", size: 20))
                                                    .foregroundColor(isCoined ? .white : (colorScheme == .dark ? .white : .black))
                                                Text(stat["Coin"]?.shorter() ?? "")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(isCoined ? .white : (colorScheme == .dark ? .white : .black))
                                                    .opacity(isCoined ? 1 : 0.6)
                                                    .minimumScaleFactor(0.1)
                                                    .scaledToFit()
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    })
                                    .sheet(isPresented: $isCoinViewPresented, content: {
                                        VideoThrowCoinView(bvid: videoDetails["BV"]!)
                                            .presentationDetents([.medium])
                                    })
                                    Button(action: {
                                        isFavoriteChoosePresented = true
                                    }, label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundStyle(isFavoured ? Color(hex: 0xfa678e) : Color.gray.opacity(0.35))
                                            VStack {
                                                Text(isFavoured ? "" : "")
                                                    .font(.custom("bilibili", size: 20))
                                                    .foregroundColor(isFavoured ? .white : (colorScheme == .dark ? .white : .black))
                                                Text(stat["Favorite"]?.shorter() ?? "")
                                                    .font(.system(size: 11))
                                                    .foregroundColor(isFavoured ? .white : (colorScheme == .dark ? .white : .black))
                                                    .opacity(isFavoured ? 1 : 0.6)
                                                    .minimumScaleFactor(0.1)
                                                    .scaledToFit()
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    })
                                }
                                .buttonBorderShape(.roundedRectangle(radius: 18))
                                .sheet(isPresented: $isFavoriteChoosePresented, content: {VideoFavoriteAddView(videoDetails: $videoDetails, isFavoured: $isFavoured)})
                                Spacer()
                                    .frame(height: 10)
                                VStack {
                                    // !!!: 不要为了本地化将此处字符串内插值进行类型转换
                                    HStack {
                                        Image(systemName: "text.word.spacing")
                                        Text("\(videoDetails["Danmaku"]!.shorter()) 弹幕")
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "person.2")
                                        Text("\(nowPlayingCount) 人在看")
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "play.circle")
                                        Text("\(videoDetails["View"]!.shorter()) 播放")
                                            .offset(x: 1)
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "clock")
                                        Text("发布于 \(publishTime)")
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "movieclapper")
                                        Text(videoDetails["BV"]!)
                                        Spacer()
                                    }
                                }
                                .font(.system(size: 11))
                                .opacity(0.6)
                                .padding(.horizontal, 10)
                                Spacer()
                                    .frame(height: 5)
                                HStack {
                                    VStack {
                                        Image(systemName: "info.circle")
                                        Spacer()
                                    }
                                    Text(videoDesc)
                                    Spacer()
                                }
                                .font(.system(size: 12))
                                .opacity(0.65)
                                .padding(.horizontal, 8)
                                HStack {
                                    VStack {
                                        Image(systemName: "tag")
                                        Spacer()
                                    }
                                    Text(tagText)
                                    Spacer()
                                }
                                .font(.system(size: 12))
                                .opacity(0.65)
                                .padding(.horizontal, 8)
                                .onAppear {
                                    tagDisplayedNum = 0
                                    tagText = ""
                                    for text in tags {
                                        tagDisplayedNum += 1
                                        if tagDisplayedNum == tags.count {
                                            tagText += text
                                        } else {
                                            tagText += text + " / "
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                } else if currentDetailSelection == 2 {
                    CommentsView(oid: String(videoDetails["BV"]!.dropFirst().dropFirst()))
                } else if currentDetailSelection == 3 {
                    if goodVideos.count != 0 {
                        List {
                            ForEach(0...goodVideos.count - 1, id: \.self) { i in
                                VideoCard(goodVideos[i])
                            }
                        }
                    } else {
                        
                    }
                }
            }
        }
        .navigationTitle("Video")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/has/like?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"].int ?? 0 == 1 {
                        isLiked = true
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/coins?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"]["multiply"].int ?? 0 != 0 {
                        isCoined = true
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/fav/video/favoured?aid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"]["favoured"].bool ?? false == true {
                        isFavoured = true
                    }
                }
            }
            
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/related?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    let datas = respJson["data"]
                    for data in datas {
                        if data.1["bvid"].string == nil {
                            return
                        }
                        goodVideos.append(["Pic": data.1["pic"].string ?? "E", "Title": data.1["title"].string ?? "[加载失败]", "BV": data.1["bvid"].string!, "UP": data.1["owner"]["name"].string ?? "[加载失败]", "View": String(data.1["stat"]["view"].int ?? -1), "Danmaku": String(data.1["stat"]["danmaku"].int ?? -1)])
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/view)----------")
                    debugPrint(respJson)
                    if !CheckBApiError(from: respJson) { return }
                    owner = ["Name": respJson["data"]["owner"]["name"].string ?? "[加载失败]", "Face": respJson["data"]["owner"]["face"].string ?? "E", "ID": String(respJson["data"]["owner"]["mid"].int64 ?? -1)]
                    stat = ["Like": String(respJson["data"]["stat"]["like"].int ?? -1), "Coin": String(respJson["data"]["stat"]["coin"].int ?? -1), "Favorite": String(respJson["data"]["stat"]["favorite"].int ?? -1)]
                    videoDesc = respJson["data"]["desc"].string ?? "[加载失败]".replacingOccurrences(of: "\\n", with: "\n")

                    // Publish time calculation
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let pubTimestamp = respJson["data"]["pubdate"].int ?? 1
                    publishTime = df.string(from: Date(timeIntervalSince1970: Double(pubTimestamp)))
                    
                    for _ in 1...4 {
                        honors.append("")
                    }
                    for honor in respJson["data"]["honor_reply"]["honor"] {
                        honors[honor.1["type"].int! - 1] = honor.1["desc"].string ?? "[加载失败]"
                    }
                    for page in respJson["data"]["pages"] {
                        videoPages.append(["CID": String(page.1["cid"].int ?? 0), "Index": String(page.1["page"].int ?? 0), "Title": page.1["part"].string ?? "[加载失败]"])
                    }
                    if let mid = respJson["data"]["owner"]["mid"].int {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/stat?vmid=\(mid)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                ownerFansCount = respJson["data"]["follower"].int64 ?? -1
                            }
                        }
                    }
                    if let cid = respJson["data"]["pages"][0]["cid"].int {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/online/total?bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                nowPlayingCount = respJson["data"]["total"].string ?? "[加载失败]"
                            }
                        }
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/v2?bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                            debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/player/v2)----------")
                            debugPrint(respJson)
                            if let subTitleUrl = respJson["data"]["subtitle"]["subtitles"][0]["subtitle_url"].string {
                                DarockKit.Network.shared.requestJSON(subTitleUrl) { respJson, isSuccess in
                                    let subTitles = respJson["body"]
                                    for subTitle in subTitles {
                                        self.subTitles.append(["Start": String(subTitle.1["from"].double!), "End": String(subTitle.1["to"].double!), "Content": subTitle.1["content"].string!])
                                    }
                                }
                            }
                        }
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/tag/archive/tags?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/tags)----------")
                    debugPrint(respJson)
                    for tag in respJson["data"] {
                        tags.append(tag.1["tag_name"].string ?? "[加载失败]")
                    }
                }
            }
            if recordHistoryTime == "into" {
                AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": videoDetails["BV"]!, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
                    debugPrint(response)
                }
            }
            
            if videoDetails["Title"]!.contains("<em class=\"keyword\">") {
                videoDetails["Title"] = "\(String(videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? "" : (videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[0])))\(String(videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? 0 : 1].split(separator: "</em>")[0]))\(String(videoDetails["Title"]!.hasSuffix("</em>") ? "" : videoDetails["Title"]!.split(separator: "</em>")[1]))"
            }
            
            if videoGetterSource == "official" {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                    if !CheckBApiError(from: respJson) { return }
                    let cid = respJson["data"]["pages"][0]["cid"].int64!
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?bvid=\(videoDetails["BV"]!)&cid=\(cid)&qn=\(sessdata == "" ? 64 : 80)", headers: headers) { respJson, isSuccess in
                        if !CheckBApiError(from: respJson) { return }
                        VideoDetailView.willPlayVideoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                        VideoDetailView.willPlayVideoCID = cid
                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                        isVideoPlayerPresented = true
                        isDecoded = true
                    }
                }
            } else if videoGetterSource == "injahow" {
                DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=80&format=mp4&otype=url") { respStr, isSuccess in
                    if isSuccess {
                        VideoDetailView.willPlayVideoLink = respStr
                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                        isVideoPlayerPresented = true
                        isDecoded = true
                    }
                }
            }
        }
    }
    
    struct VideoFavoriteAddView: View {
        @Binding var videoDetails: [String: String]
        @Binding var isFavoured: Bool
        @Environment(\.dismiss) var dismiss
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var favoriteFolderList = [[String: String]]()
        @State var isFavoriteTargetIn = [Bool]()
        @State var isItemLoading = [Bool]()
        var body: some View {
            NavigationStack {
                List {
                    if isItemLoading.count != 0 {
                        ForEach(0..<favoriteFolderList.count, id: \.self) { i in
                            Button(action: {
                                isItemLoading[i] = true
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata);",
                                    "referer": "https://www.bilibili.com/video/\(videoDetails["BV"]!)/",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                let avid = bv2av(bvid: videoDetails["BV"]!)
                                AF.request("https://api.bilibili.com/x/v3/fav/resource/deal", method: .post, parameters: ["rid": avid, "type": 2, "\(isFavoriteTargetIn[i] ? "del" : "add")_media_ids": Int(favoriteFolderList[i]["ID"]!)!, "csrf": biliJct], headers: headers).response { response in
                                    debugPrint(response)
                                    if let rpd = response.data {
                                        if !CheckBApiError(from: try! JSON(data: rpd)) {
                                            isItemLoading[i] = false
                                            return
                                        }
                                        isFavoriteTargetIn[i].toggle()
                                        isFavoured = false
                                        for i in isFavoriteTargetIn {
                                            if i {
                                                isFavoured = true
                                                break
                                            }
                                        }
                                    }
                                    isItemLoading[i] = false
                                 }
                            }, label: {
                                HStack {
                                    if !isItemLoading[i] {
                                        if isFavoriteTargetIn[i] {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.blue)
                                        }
                                        Text(favoriteFolderList[i]["Title"]!)
                                    } else {
                                        Spacer()
                                        ProgressView()
                                        Spacer()
                                    }
                                }
                            })
                        }
                    } else {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .navigationTitle(String(localized: "Video.add-to-favorites"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata);",
                    "User-Agent": "Mozilla/5.0"
                ]
                let avid = bv2av(bvid: videoDetails["BV"]!)
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v3/fav/folder/created/list-all?type=2&rid=\(avid)&up_mid=\(dedeUserID)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        if !CheckBApiError(from: respJson) { return }
                        for folder in respJson["data"]["list"] {
                            favoriteFolderList.append(["ID": String(folder.1["id"].int ?? 0), "Title": folder.1["title"].string ?? "", "Count": String(folder.1["media_count"].int ?? 0)])
                            isFavoriteTargetIn.append((folder.1["fav_state"].int ?? 0) == 0 ? false : true)
                            isItemLoading.append(false)
                        }
                    }
                }
            }
        }
    }
    struct DetailViewVideoPartPageBase: View {
        @Binding var videoDetails: [String: String]
        @Binding var videoPages: [[String: String]]
        @Binding var isLoading: Bool
        @Binding var videoPartShouldShowDownloadTip: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @AppStorage("VideoGetterSource") var videoGetterSource = "official"
        @State var isVideoPlayerPresented = false
        @State var downloadTipOffset: CGFloat = 0.0
        @State var downloadTipOpacity: CGFloat = 1.0
        @State var isDownloadPresented = false
        var body: some View {
            List {
                if videoPages.count != 0 {
                    ForEach(0..<videoPages.count, id: \.self) { i in
                        Button(action: {
                            isLoading = true
                            
                            if videoGetterSource == "official" {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                let cid = videoPages[i]["CID"]!
                                VideoDetailView.willPlayVideoCID = Int64(cid)!
                                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                    if isSuccess {
                                        if !CheckBApiError(from: respJson) { return }
                                        VideoDetailView.willPlayVideoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                        isVideoPlayerPresented = true
                                        isLoading = false
                                    }
                                }
                            } else if videoGetterSource == "injahow" {
                                DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=\(i + 1)&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                    if isSuccess {
                                        VideoDetailView.willPlayVideoLink = respStr
                                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                        isVideoPlayerPresented = true
                                        isLoading = false
                                    }
                                }
                            }
                        }, label: {
                            ZStack {
                                HStack {
                                    Text(String(i + 1))
                                    Text(videoPages[i]["Title"]!)
                                    Spacer()
                                }
                                if videoPartShouldShowDownloadTip && i == 0 {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "hand.point.up.left")
                                            .font(.system(size: 30))
                                            .offset(x: downloadTipOffset, y: 10)
                                            .opacity(downloadTipOpacity)
                                            .animation(.easeOut(duration: 2.0), value: downloadTipOffset)
                                            .animation(.easeIn(duration: 1.0), value: downloadTipOpacity)
                                            .onAppear {
                                                DispatchQueue(label: "com.darock.DarockBili.PartVideoDownloadTip", qos: .userInteractive).async {
                                                    downloadTipOffset = -40
                                                    sleep(3)
                                                    downloadTipOpacity = 0
                                                    sleep(1)
                                                    videoPartShouldShowDownloadTip = false
                                                }
                                            }
                                    }
                                }
                            }
                        })
                        .swipeActions {
                            Button(action: {
                                if videoGetterSource == "official" {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata)",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    let cid = videoPages[i]["CID"]!
                                    VideoDetailView.willPlayVideoCID = Int64(cid)!
                                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            if !CheckBApiError(from: respJson) { return }
                                            VideoDownloadView.downloadLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                            isDownloadPresented = true
                                        }
                                    }
                                } else if videoGetterSource == "injahow" {
                                    DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=\(i + 1)&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                        if isSuccess {
                                            VideoDownloadView.downloadLink = respStr
                                            isDownloadPresented = true
                                        }
                                    }
                                }
                            }, label: {
                                Image(systemName: "arrow.down.doc")
                            })
                        }
                    }
                }
            }
            .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
        }
    }
}

struct VideoThrowCoinView: View {
    var bvid: String
    @Environment(\.dismiss) var dismiss
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var choseCoin = 2
    var body: some View {
        VStack {
            Picker("Video.coin.throw", selection: $choseCoin) {
                Label("Video.coin.throw.1", systemImage: "circlebadge")
                    .tag(1)
                Label("Video.coin.throw.2", systemImage: "circlebadge.2")
                    .tag(2)
            }
            .pickerStyle(.wheel)
            /* HStack {
                Button(action: {
                    choseCoin = 1
                }, label: {
                    Image("Coin1Icon")
                        .resizable()
                })
                .frame(width: 86, height: 126.5)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .border(choseCoin == 1 ? .blue : .black, width: 5)
                Button(action: {
                    choseCoin = 2
                }, label: {
                    Image("Coin2Icon")
                        .resizable()
                })
                .frame(width: 86, height: 126.5)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .border(choseCoin == 2 ? .blue : .black, width: 5)
            } */
            Button(action: {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: bvid, multiply: choseCoin, csrf: biliJct), headers: headers).response { response in
                    debugPrint(response)
                    dismiss()
                }
            }, label: {
                Text("Video.coin.throw")
            })
        }
    }
}

struct BiliVideoLike: Codable {
    let bvid: String
    let like: Int
    let csrf: String
}
struct BiliVideoCoin: Codable {
    let bvid: String
    let multiply: Int
    var select_like: Int = 0
    let csrf: String
}
struct BiliVideoFavourite: Codable {
    let rid: UInt64
    var type: Int = 2
    var add_media_ids: Int? = nil
    var del_media_ids: Int? = nil
    let csrf: String
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(videoDetails: ["Pic": "http://i1.hdslb.com/bfs/archive/453a7f8deacb98c3b083ead733291f080383723a.jpg", "Title": "解压视频：20000个小球Marble run动画", "BV": "BV1PP41137Px", "UP": "小球模拟", "View": "114514", "Danmaku": "1919810"])
    }
}
