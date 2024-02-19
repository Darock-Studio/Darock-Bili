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
import Mixpanel
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation
import CachedAsyncImage
import SDWebImageSwiftUI
import MobileCoreServices

struct VideoDetailView: View {
    @State var videoDetails: [String: String]
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("VideoGetterSource") var videoGetterSource = "official"
    @AppStorage("IsDanmakuEnabled") var isDanmakuEnabled = true
    @AppStorage("IsAllowMixpanel") var isAllowMixpanel = true
    @AppStorage("IsUseExtHaptic") var isUseExtHaptic = true
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
    @State var isMoreMenuPresented = false
    @State var isDownloadPresented = false
    @State var isAudioPlayerPresented = false
    @State var backgroundPicOpacity = 0.0
    @State var mainVerticalTabViewSelection = 1
    @State var videoPartShouldShowDownloadTip = false
    @State var isCoverImageViewPresented = false
    @State var tagText = ""
    @State var isFavoriteChoosePresented = false
    @State var tagDisplayedNum = 0
    @State var currentDetailSelection = 1
    @State var playingPageIndex = 0
    @State var videoLink = ""
    @State var videoBvid = ""
    @State var videoCID: Int64 = 0
    @State var shouldPausePlayer = false
    @State var isDescSelectPresented = false
    @State var danmakuSendCache = ""
    @State var danmakuSendColor = Color(hex: 0xFFFFFF)
    @State var currentPlayTime = 0.0
    @State var danmakuSendFontSize = 25
    @State var danmakuSendMode = 1
    @State var willEnterGoodVideo = false
    @FocusState var isEditingDanmaku: Bool
    var body: some View {
        VStack {
            if isDecoded {
                VideoPlayerView(videoDetails: $videoDetails, isDanmakuEnabled: $isDanmakuEnabled, videoLink: $videoLink, videoBvid: $videoBvid, videoCID: $videoCID, shouldPause: $shouldPausePlayer, currentPlayTime: $currentPlayTime, willEnterGoodVideo: $willEnterGoodVideo)
                    .frame(height: 240)
            } else {
                Rectangle()
                    .frame(height: 240)
                    .redacted(reason: .placeholder)
            }
            HStack {
                Spacer()
                TextField("发送弹幕", text: $danmakuSendCache)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.send)
                    .onSubmit {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata)",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        AF.request("https://api.bilibili.com/x/v2/dm/post", method: .post, parameters: ["type": 1, "oid": videoCID, "msg": danmakuSendCache, "bvid": videoDetails["BV"]!, "progress": Int(currentPlayTime * 1000), "color": { () -> Int in
                            var red: CGFloat = 0
                            var green: CGFloat = 0
                            var blue: CGFloat = 0
                            var alpha: CGFloat = 0
                            UIColor(danmakuSendColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                            return (Int(red * 255) << 16) + (Int(green * 255) << 8) + Int(blue * 255)
                        }(), "fontsize": danmakuSendFontSize, "pool": 0, "mode": danmakuSendMode, "rnd": Date.now.timeStamp * 1000000, "csrf": biliJct], headers: headers).response { response in
                            debugPrint(response)
                            danmakuSendCache = ""
                        }
                    }
                    .focused($isEditingDanmaku)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            ColorPicker("颜色", selection: $danmakuSendColor)
                            Picker("字号", selection: $danmakuSendFontSize) {
                                Text("极小").tag(12)
                                Text("超小").tag(16)
                                Text("小").tag(18)
                                Text("标准").tag(25)
                                Text("大").tag(36)
                                Text("超大").tag(45)
                                Text("极大").tag(64)
                            }
                            Picker("模式", selection: $danmakuSendMode) {
                                Text("普通").tag(1)
                                Text("顶部").tag(5)
                                Text("底部").tag(4)
                            }
                        }
                    }
                    .frame(width: isEditingDanmaku ? nil : 90)
                    .animation(.easeOut(duration: 0.2), value: isEditingDanmaku)
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
                .onChange(of: currentDetailSelection) { _ in
                    if isUseExtHaptic {
                        PlayHaptic(sharpness: 0.05, intensity: 0.5)
                    }
                }
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
                            if owner["ID"] != nil {
                                NavigationLink(destination: {UserDetailView(uid: owner["ID"]!)}, label: {
                                    HStack {
                                        AsyncImage(url: URL(string: owner["Face"]!)) { phase in
                                            switch phase {
                                            case .empty:
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .redacted(reason: .placeholder)
                                            case .success(let image):
                                                image.resizable()
                                            case .failure(let error):
                                                Circle()
                                                    .frame(width: 40, height: 40)
                                                    .redacted(reason: .placeholder)
                                            }
                                        }
                                        .clipShape(Circle())
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
                                                Text("\(String(ownerFansCount).shorter()) 粉丝")
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
                                .onDrag {
                                    PlayHaptic(sharpness: 0.05, intensity: 0.5)
                                    let itemData = try? NSKeyedArchiver.archivedData(withRootObject: owner, requiringSecureCoding: false)
                                    let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: kUTTypeData as String)
                                    return provider
                                }
                            }
                            VStack {
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
                                    .onDrag {
                                        PlayHaptic(sharpness: 0.05, intensity: 0.5)
                                        let itemData = try? NSKeyedArchiver.archivedData(withRootObject: ["VideoAction": "Like"], requiringSecureCoding: false)
                                        let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: kUTTypeData as String)
                                        return provider
                                    }
                                    Button(action: {
                                        if !isCoined {
                                            isCoinViewPresented = true
                                        } else {
                                            AlertKitAPI.present(title: "不能取消投币", icon: .done, style: .iOS17AppleMusic, haptic: .success)
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
                                        VideoThrowCoinView(bvid: videoDetails["BV"]!, isCoined: $isCoined)
                                            .presentationDetents([.medium])
                                    })
                                    .onDrag {
                                        PlayHaptic(sharpness: 0.05, intensity: 0.5)
                                        let itemData = try? NSKeyedArchiver.archivedData(withRootObject: ["VideoAction": "Coin"], requiringSecureCoding: false)
                                        let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: kUTTypeData as String)
                                        return provider
                                    }
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
                                    .onDrag {
                                        PlayHaptic(sharpness: 0.05, intensity: 0.5)
                                        let itemData = try? NSKeyedArchiver.archivedData(withRootObject: ["VideoAction": "Favorite"], requiringSecureCoding: false)
                                        let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: kUTTypeData as String)
                                        return provider
                                    }
                                }
                                .buttonBorderShape(.roundedRectangle(radius: 18))
                                .sheet(isPresented: $isFavoriteChoosePresented, content: {VideoFavoriteAddView(videoDetails: $videoDetails, isFavoured: $isFavoured)})
                                if videoPages.count > 1 {
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(0..<videoPages.count, id: \.self) { i in
                                                Button(action: {
                                                    if videoGetterSource == "official" {
                                                        let headers: HTTPHeaders = [
                                                            "cookie": "SESSDATA=\(sessdata)",
                                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                        ]
                                                        let cid = videoPages[i]["CID"]!
                                                        videoCID = Int64(cid)!
                                                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?bvid=\(videoDetails["BV"]!)&cid=\(cid)&qn=\(sessdata == "" ? 64 : 80)", headers: headers) { respJson, isSuccess in
                                                            if isSuccess {
                                                                if !CheckBApiError(from: respJson) { return }
                                                                videoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                                                videoBvid = videoDetails["BV"]!
                                                                playingPageIndex = i
                                                            }
                                                        }
                                                    } else if videoGetterSource == "injahow" {
                                                        DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=\(i + 1)&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                                            if isSuccess {
                                                                videoLink = respStr
                                                                videoBvid = videoDetails["BV"]!
                                                                playingPageIndex = i
                                                            }
                                                        }
                                                    }
                                                }, label: {
                                                    HStack {
                                                        VStack {
                                                            Text(String(i + 1))
                                                                .foregroundColor(playingPageIndex == i ? .accentColor : (colorScheme == .dark ? .white : .black))
                                                            Spacer()
                                                        }
                                                        Text(videoPages[i]["Title"]!)
                                                            .lineLimit(2)
                                                            .foregroundColor(playingPageIndex == i ? .accentColor : (colorScheme == .dark ? .white : .black))
                                                    }
                                                    .font(.system(size: 14))
                                                })
                                                .buttonStyle(.bordered)
                                                .frame(height: 60)
                                                .frame(maxWidth: 160)
                                            }
                                        }
                                    }
                                    .scrollIndicators(.never)
                                }
                                Group {
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
                                    Spacer()
                                        .frame(height: 5)
                                    CopyableView(videoDesc) {
                                        HStack {
                                            Image(systemName: "info.circle")
                                            Text(videoDesc)
                                            Spacer()
                                        }
                                        .font(.system(size: 12))
                                        .opacity(0.65)
                                    }
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
                                .padding(.vertical, 3)
                                .padding(.horizontal, 10)
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
                                VideoCard(goodVideos[i]) {
                                    willEnterGoodVideo = true
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Video")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.immediately)
        .onAppear {
            if isDecoded { return } // After user enter a new video then exit, this onAppear method will be re-call
            
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
                        videoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                        videoCID = cid
                        videoBvid = videoDetails["BV"]!
                        isDecoded = true
                    }
                }
            } else if videoGetterSource == "injahow" {
                DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=80&format=mp4&otype=url") { respStr, isSuccess in
                    if isSuccess {
                        videoLink = respStr
                        videoBvid = videoDetails["BV"]!
                        isDecoded = true
                    }
                }
            }
            
            if isAllowMixpanel {
                Mixpanel.mainInstance().time(event: "Watch Video")
            }
        }
        .onDisappear {
            if isAllowMixpanel {
                Mixpanel.mainInstance().track(event: "Watch Video", properties: videoDetails)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isMoreMenuPresented = true
                }, label: {
                    Image(systemName: "ellipsis.circle")
                })
            }
        }
        .sheet(isPresented: $isMoreMenuPresented) {
            List {
                Section {
                    Button(action: {
                        shouldPausePlayer = true
                        isAudioPlayerPresented = true
                        isMoreMenuPresented = false
                    }, label: {
                        Label("Video.play-in-audio", systemImage: "waveform")
                    })
                }
                Section {
                    Button(action: {
                        isDownloadPresented = true
                    }, label: {
                        Label("Video.download", systemImage: "arrow.down.doc")
                    })
                    .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                }
                Section {
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
                            isMoreMenuPresented = false
                        }
                    }, label: {
                        Label("Video.watch-later", systemImage: "memories.badge.plus")
                    })
                }
            }
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isAudioPlayerPresented, content: {AudioPlayerView(videoDetails: videoDetails, videoLink: $videoLink, videoBvid: $videoBvid, videoCID: $videoCID)})
        .userActivity("com.darock.DarockBili.video-play", element: videoDetails) { url, activity in
            activity.addUserInfoEntries(from: videoDetails)
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
            .presentationDetents([.medium, .large])
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
}

struct VideoThrowCoinView: View {
    var bvid: String
    @Binding var isCoined: Bool
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
            Button(action: {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3)",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: bvid, multiply: choseCoin, csrf: biliJct), headers: headers).response { response in
                    debugPrint(response)
                    isCoined = true
                    AlertKitAPI.present(title: "已投币", icon: .done, style: .iOS17AppleMusic, haptic: .success)
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
