//
//  VideoDetailView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import AVKit
import SwiftUI
import SFSymbol
import WatchKit
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation
import CachedAsyncImage
import SDWebImageSwiftUI

struct VideoDetailView: View {
    public static var willPlayVideoLink = ""
    public static var willPlayVideoBV = ""
    public static var willPlayVideoCID = ""
    @State var videoDetails: [String: String]
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @State var isLoading = false
    @State var isLiked = false
    @State var isCoined = false
    @State var isFavoured = false
    @State var isCoinViewPresented = false
    @State var goodVideos = [[String: String]]()
    @State var owner = [String: String]()
    @State var stat = [String: String]()
    @State var tags = [String]()
    @State var ownerFansCount = 0
    @State var nowPlayingCount = "0"
    @State var videoDesc = ""
    @State var isVideoPlayerPresented = false
    @State var isMoreMenuPresented = false
    @State var isDownloadPresented = false
    @State var isNowPlayingPresented = false
    @State var backgroundPicOpacity = 0.0
    var body: some View {
        TabView {
            if #available(watchOS 10, *) {
                ZStack {
                    Group {
                        TabView {
                            VStack {
                                NavigationLink("", isActive: $isNowPlayingPresented, destination: {AudioPlayerView(videoDetails: videoDetails)})
                                    .frame(width: 0, height: 0)
                                
                                DetailViewFirstPageBase(videoDetails: $videoDetails, isLoading: $isLoading)
                                    .offset(y: 16)
                                    .toolbar {
                                        ToolbarItem(placement: .topBarTrailing) {
                                            Button(action: {
                                                isMoreMenuPresented = true
                                            }, label: {
                                                Image(systemName: "ellipsis")
                                            })
                                            .sheet(isPresented: $isMoreMenuPresented, content: {
                                                List {
                                                    Button(action: {
                                                        isDownloadPresented = true
                                                    }, label: {
                                                        Label("下载视频", systemImage: "arrow.down.doc")
                                                    })
                                                    .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                                                    Button(action: {
                                                        let headers: HTTPHeaders = [
                                                            "cookie": "SESSDATA=\(sessdata)"
                                                        ]
                                                        AF.request("https://api.bilibili.com/x/v2/history/toview/add", method: .post, parameters: ["bvid": videoDetails["BV"]!, "csrf": biliJct], headers: headers).response { response in
                                                            do {
                                                                let json = try JSON(data: response.data ?? Data())
                                                                if let code = json["code"].int {
                                                                    if code == 0 {
                                                                        tipWithText("添加成功", symbol: SFSymbol.Checkmark.circleFill.rawValue)
                                                                    } else {
                                                                        tipWithText(json["message"].string ?? "未知错误", symbol: SFSymbol.Xmark.circleFill.rawValue)
                                                                    }
                                                                } else {
                                                                    tipWithText("未知错误", symbol: SFSymbol.Xmark.circleFill.rawValue)
                                                                }
                                                            } catch {
                                                                tipWithText("未知错误", symbol: SFSymbol.Xmark.circleFill.rawValue)
                                                            }
                                                        }
                                                    }, label: {
                                                        Label("添加到稍后再看", systemImage: "memories.badge.plus")
                                                    })
                                                }
                                            })
                                        }
                                        ToolbarItemGroup(placement: .bottomBar) {
                                            Button(action: {
                                                isLoading = true
                                                
                                                let headers: HTTPHeaders = [
                                                    "cookie": "SESSDATA=\(sessdata)"
                                                ]
                                                AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                                                    let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                                    VideoDetailView.willPlayVideoCID = String(cid)
                                                    AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                                        VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                        isNowPlayingPresented = true
                                                        isLoading = false
                                                    }
                                                }
                                            }, label: {
                                                Image(systemName: "waveform")
                                            })
                                            Button(action: {
                                                isLoading = true
                                                
                                                let headers: HTTPHeaders = [
                                                    "cookie": "SESSDATA=\(sessdata)"
                                                ]
                                                AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                                                    let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                                    VideoDetailView.willPlayVideoCID = String(cid)
                                                    AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                                        VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                                        //debugPrint(response)
                                                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                        isVideoPlayerPresented = true
                                                        isLoading = false
                                                    }
                                                }
                                            }, label: {
                                                Image(systemName: "play.fill")
                                            })
                                            .sheet(isPresented: $isVideoPlayerPresented, content: {VideoPlayerView()})
                                        }
                                    }
                                    .tag(1)
                            }
                            DetailViewSecondPageBase(videoDetails: $videoDetails, owner: $owner, stat: $stat, tags: $tags, videoDesc: $videoDesc, isLiked: $isLiked, isCoined: $isCoined, isFavoured: $isFavoured, isCoinViewPresented: $isCoinViewPresented, ownerFansCount: $ownerFansCount, nowPlayingCount: $nowPlayingCount)
                                .tag(2)
                        }
                        .tabViewStyle(.verticalPage)
                    }
                    .blur(radius: isLoading ? 14 : 0)
                    if isLoading {
                        Text("正在解析...")
                            .font(.title2)
                            .bold()
                    }
                }
                .containerBackground(for: .navigation) {
                    ZStack {
                        CachedAsyncImage(url: URL(string: videoDetails["Pic"]!)) { phase in
                            switch phase {
                            case .empty:
                                Color.black
                            case .success(let image):
                                image
                                    .onAppear {
                                        backgroundPicOpacity = 1.0
                                    }
                            case .failure:
                                Color.black
                            @unknown default:
                                Color.black
                            }
                        }
                        .blur(radius: 20)
                        .opacity(backgroundPicOpacity)
                        .animation(.easeOut(duration: 1.2), value: backgroundPicOpacity)
                        Color.black
                            .opacity(0.4)
                    }
                }
                .tag(1)
            } else {
                ZStack {
                    Group {
                        ScrollView {
                            DetailViewFirstPageBase(videoDetails: $videoDetails, isLoading: $isLoading)
                                .offset(y: 16)
                            DetailViewSecondPageBase(videoDetails: $videoDetails, owner: $owner, stat: $stat, tags: $tags, videoDesc: $videoDesc, isLiked: $isLiked, isCoined: $isCoined, isFavoured: $isFavoured, isCoinViewPresented: $isCoinViewPresented, ownerFansCount: $ownerFansCount, nowPlayingCount: $nowPlayingCount)
                        }
                    }
                    .blur(radius: isLoading ? 14 : 0)
                    if isLoading {
                        Text("正在解析...")
                            .font(.title2)
                            .bold()
                    }
                }
                .tag(1)
            }
            
            if #available(watchOS 10, *) {
                VideoCommentsView(oid: String(videoDetails["BV"]!.dropFirst().dropFirst()))
                    .containerBackground(for: .navigation) {
                        ZStack {
                            CachedAsyncImage(url: URL(string: videoDetails["Pic"]!))
                                .blur(radius: 20)
                            Color.black
                                .opacity(0.4)
                        }
                    }
                    .tag(2)
            } else {
                VideoCommentsView(oid: String(videoDetails["BV"]!.dropFirst().dropFirst()))
            }
            
            if goodVideos.count != 0 {
                List {
                    ForEach(0...goodVideos.count - 1, id: \.self) { i in
                        VideoCard(goodVideos[i])
                    }
                }
                .tag(3)
            }
        }
        .accentColor(.white)
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)"
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
                    owner = ["Name": respJson["data"]["owner"]["name"].string ?? "[加载失败]", "Face": respJson["data"]["owner"]["face"].string ?? "E", "ID": String(respJson["data"]["owner"]["mid"].int ?? -1)]
                    stat = ["Like": String(respJson["data"]["stat"]["like"].int ?? -1), "Coin": String(respJson["data"]["stat"]["coin"].int ?? -1), "Favorite": String(respJson["data"]["stat"]["favorite"].int ?? -1)]
                    videoDesc = respJson["data"]["desc"].string ?? "[加载失败]".replacingOccurrences(of: "\\n", with: "\n")
                    if let mid = respJson["data"]["owner"]["mid"].int {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/stat?vmid=\(mid)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                ownerFansCount = respJson["data"]["follower"].int ?? -1
                            }
                        }
                    }
                    if let cid = respJson["data"]["pages"][0]["cid"].int {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/online/total?bvid=\(videoDetails["BV"]!)&cid=\(cid)") { respJson, isSuccess in
                            if isSuccess {
                                nowPlayingCount = respJson["data"]["total"].string ?? "[加载失败]"
                            }
                        }
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/v2?bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                            debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/player/v2)----------")
                            debugPrint(respJson)
                            
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
        }
        .onDisappear {
            goodVideos = [[String: String]]()
            owner = [String: String]()
            stat = [String: String]()
            videoDesc = ""
            SDImageCache.shared.clearMemory()
        }
    }
    
    struct DetailViewFirstPageBase: View {
        @Binding var videoDetails: [String: String]
        @Binding var isLoading: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var isVideoPlayerPresented = false
        @State var isMoreMenuPresented = false
        @State var isDownloadPresented = false
        @State var isNowPlayingPresented = false
        var body: some View {
            VStack {
                Spacer()
                CachedAsyncImage(url: URL(string: videoDetails["Pic"]! + "@120w_90h")) { phase in
                    switch phase {
                    case .empty:
                        Image("Placeholder")
                            .fixedSize()
                            .frame(width: 120, height: 90)
                            .redacted(reason: .placeholder)
                    case .success(let image):
                        image
                    case .failure(let error):
                        Image("Placeholder")
                            .fixedSize()
                            .frame(width: 120, height: 90)
                            .redacted(reason: .placeholder)
                            .onAppear {
                                debugPrint(error)
                            }
                    @unknown default:
                        Image("Placeholder")
                            .fixedSize()
                            .frame(width: 120, height: 90)
                            .redacted(reason: .placeholder)
                    }
                }
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 1, y: 2)
                .offset(y: 8)
                    
                Spacer()
                    .frame(height: 20)
                Text(videoDetails["Title"]!)
                    .lineLimit(2)
                    .font(.system(size: 12, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                Text(videoDetails["UP"]!)
                    .lineLimit(1)
                    .font(.system(size: 12))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 0)
                    .opacity(0.65)
                Spacer()
                    .frame(height: 20)
                if #unavailable(watchOS 10) {
                    Button(action: {
                        isLoading = true
                        
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata)"
                        ]
                        AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                            let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                            VideoDetailView.willPlayVideoCID = String(cid)
                            AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                //debugPrint(response)
                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                isVideoPlayerPresented = true
                                isLoading = false
                            }
                        }
                    }, label: {
                        Image(systemName: "play.fill")
                    })
                    .sheet(isPresented: $isVideoPlayerPresented, content: {VideoPlayerView()})
                    NavigationLink("", isActive: $isNowPlayingPresented, destination: {AudioPlayerView(videoDetails: videoDetails)})
                        .frame(width: 0, height: 0)
                    Button(action: {
                        isLoading = true
                        
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata)"
                        ]
                        AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                            let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                            VideoDetailView.willPlayVideoCID = String(cid)
                            AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                isNowPlayingPresented = true
                                isLoading = false
                            }
                        }
                    }, label: {
                        Image(systemName: "waveform")
                    })
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
                    .sheet(isPresented: $isMoreMenuPresented, content: {
                        List {
                            Button(action: {
                                isDownloadPresented = true
                            }, label: {
                                Label("下载视频", image: "arrow.down.doc")
                            })
                            .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                        }
                    })
                }
            }
        }
    }
    struct DetailViewSecondPageBase: View {
        @Binding var videoDetails: [String: String]
        @Binding var owner: [String: String]
        @Binding var stat: [String: String]
        @Binding var tags: [String]
        @Binding var videoDesc: String
        @Binding var isLiked: Bool
        @Binding var isCoined: Bool
        @Binding var isFavoured: Bool
        @Binding var isCoinViewPresented: Bool
        @Binding var ownerFansCount: Int
        @Binding var nowPlayingCount: String
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var tagText = ""
        @State var descOffset: CGFloat = 20
        @State var tagOffset: CGFloat = 20
        var body: some View {
            ScrollView {
                VStack {
                    if owner["ID"] != nil {
                        NavigationLink(destination: {UserDetailView(uid: owner["ID"]!)}, label: {
                            HStack {
                                AsyncImage(url: URL(string: owner["Face"]! + "@40w"))
                                    .cornerRadius(100)
                                VStack {
                                    HStack {
                                        Text(owner["Name"]!)
                                            .font(.system(size: 16, weight: .bold))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(String(ownerFansCount).shorter() + " 粉丝")
                                            .font(.system(size: 11))
                                            .lineLimit(1)
                                            .opacity(0.6)
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        })
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                    }
                    LazyVStack {
                        HStack {
                            Button(action: {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)"
                                ]
                                AF.request("https://api.bilibili.com/x/web-interface/archive/like", method: .post, parameters: BiliVideoLike(bvid: videoDetails["BV"]!, like: isLiked ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                                    debugPrint(response)
                                    isLiked ? tipWithText("取消成功", symbol: "checkmark.circle.fill") : tipWithText("点赞成功", symbol: "checkmark.circle.fill")
                                    isLiked.toggle()
                                }
                            }, label: {
                                VStack {
                                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                                        .foregroundColor(isLiked ? Color(hex: 0xfa678e)  : .white)
                                    Text(stat["Like"]?.shorter() ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(isLiked ? Color(hex: 0xfa678e)  : .white)
                                        .opacity(isLiked ? 1 : 0.6)
                                        .minimumScaleFactor(0.1)
                                        .scaledToFit()
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 18))
                            Button(action: {
                                if !isCoined {
                                    isCoinViewPresented = true
                                }
                            }, label: {
                                VStack {
                                    Image(systemName: isCoined ? "b.circle.fill" : "b.circle")
                                        .foregroundColor(isCoined ? Color(hex: 0xfa678e)  : .white)
                                        .bold()
                                    Text(stat["Coin"]?.shorter() ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(isCoined ? Color(hex: 0xfa678e)  : .white)
                                        .opacity(isCoined ? 1 : 0.6)
                                        .minimumScaleFactor(0.1)
                                        .scaledToFit()
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 18))
                            .sheet(isPresented: $isCoinViewPresented, content: {VideoThrowCoinView(bvid: videoDetails["BV"]!)})
                            Button(action: {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "referer": "bilibili.com/video/\(videoDetails["BV"]!)"
                                ]
                                DarockKit.Network.shared.requestString("https://api.darock.top/bili/toav/\(videoDetails["BV"]!)") { respStr, isSuccess in
                                    if isSuccess {
                                        AF.request("https://api.bilibili.com/medialist/gateway/coll/resource/deal", method: .post, parameters: BiliVideoFavourite(rid: Int(respStr)!, csrf: biliJct), headers: headers).response { response in
                                            debugPrint(response)
                                            isLiked ? tipWithText("取消成功", symbol: "checkmark.circle.fill") : tipWithText("收藏成功", symbol: "checkmark.circle.fill")
                                            isFavoured.toggle()
                                        }
                                    }
                                }
                            }, label: {
                                VStack {
                                    Image(systemName: isFavoured ? "star.fill" : "star")
                                        .foregroundColor(isFavoured ? Color(hex: 0xf9678f) : .white)
                                    Text(stat["Favorite"]?.shorter() ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(isFavoured ? Color(hex: 0xfa678e)  : .white)
                                        .opacity(isFavoured ? 1 : 0.6)
                                        .minimumScaleFactor(0.1)
                                        .scaledToFit()
                                }
                            })
                        }
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        Spacer()
                            .frame(height: 10)
                        VStack {
                            HStack {
                                Image(systemName: "text.word.spacing")
                                Text(videoDetails["Danmaku"]!.shorter() + " 弹幕")
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "person.2")
                                Text("\(nowPlayingCount) 人在看")
                                    .offset(x: -1)
                                Spacer()
                            }
                            .offset(x: -2)
                            HStack {
                                Image(systemName: "play.circle")
                                Text(videoDetails["View"]!.shorter() + " 播放")
                                    .offset(x: 1)
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "movieclapper")
                                Text(videoDetails["BV"]!)
                                Spacer()
                            }
                            .offset(x: -1)
                        }
                        .font(.system(size: 11))
                        .opacity(0.6)
                        .padding(.horizontal, 10)
                        Spacer()
                            .frame(height: 10)
                        Text(videoDesc)
                            .font(.system(size: 12))
                            .opacity(0.65)
                            .padding(.horizontal, 8)
                            .offset(y: descOffset)
                            .animation(.easeOut(duration: 0.4), value: descOffset)
                            .onAppear {
                                descOffset = 0
                            }
                        Spacer()
                            .frame(height: 15)
                        Label(tagText, systemImage: "tag")
                            .font(.system(size: 13))
                            .padding(.horizontal, 8)
                            .opacity(0.6)
                            .offset(y: tagOffset)
                            .animation(.easeOut(duration: 0.3), value: tagOffset)
                            .onAppear {
                                tagOffset = 0
                                tagText = ""
                                for text in tags {
                                    tagText += text + "  "
                                }
                            }
                    }
                }
            }
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
            HStack {
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
            }
            Button(action: {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)"
                ]
                AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: bvid, multiply: choseCoin, csrf: biliJct), headers: headers).response { response in
                    debugPrint(response)
                    dismiss()
                }
            }, label: {
                Text("投币")
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
    let rid: Int
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
