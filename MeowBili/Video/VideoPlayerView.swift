//
//
//  VideoPlayerView.swift
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

import AVKit
import SwiftUI
import Dynamic
import Combine
import DarockKit
import Alamofire
import AVFoundation
#if !os(watchOS)
import AZVideoPlayer
#endif

struct VideoPlayerView: View {
    @Binding var videoDetails: [String: String]
    #if !os(watchOS)
    @Binding var isDanmakuEnabled: Bool
    #endif
    @Binding var videoLink: String
    @Binding var videoBvid: String
    @Binding var videoCID: Int64
    #if !os(watchOS)
    @Binding var shouldPause: Bool
    @Binding var currentPlayTime: Double
    @Binding var willEnterGoodVideo: Bool
    #endif
    #if os(watchOS)
    @Environment(\.dismiss) var dismiss
    #endif
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("IsShowNormalDanmaku") var isShowNormalDanmaku = true
    @AppStorage("IsShowTopDanmaku") var isShowTopDanmaku = true
    @AppStorage("IsShowBottomDanmaku") var isShowBottomDanmaku = true
    #if !os(watchOS)
    @AppStorage("IsRecordHistory") var isRecordHistory = true
    #else
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("IsDanmakuEnabled") var isDanmakuEnabled = true
    @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
    @AppStorage("VideoPlayerGestureBehavior") var videoPlayerGestureBehavior = "Play/Pause"
    @State var tabviewChoseTab = 1
    @State var isFullScreen = false
    @State var playbackSpeed = 1.0
    @State var jumpToInput = ""
    @State var playerScale: CGFloat = 1.0
    @State var __playerScale = 1.0
    @State var playerScaledOffset = CGSizeZero
    @State var playerScaledLastOffset = CGSizeZero
    @State var cachedPlayerTimeControlStatus = AVPlayer.TimeControlStatus.paused
    #endif
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var playProgressTimer: Timer?
    @State var player: AVPlayer! = AVPlayer()
    @State var isFinishedInit = false
    @State var willBeginFullScreenPresentation = false
    @State var showDanmakus = [[String: String]]()
    @State var danmakuOffset: CGFloat = 0
    @State var didEnterGoodVideo = false
    var body: some View {
        Group {
            #if !os(watchOS)
            AZVideoPlayer(player: player, willBeginFullScreenPresentationWithAnimationCoordinator: willBeginFullScreen, willEndFullScreenPresentationWithAnimationCoordinator: willEndFullScreen, pausesWhenFullScreenPlaybackEnds: false)
                .overlay {
                    ZStack {
                        if isDanmakuEnabled {
                            if isShowNormalDanmaku {
                                VStack {
                                    ForEach(0...4, id: \.self) { i in
                                        ZStack {
                                            ForEach(0..<showDanmakus.count, id: \.self) { j in
                                                if j % 5 == i {
                                                    if showDanmakus[j]["Type"]! == "1" || showDanmakus[j]["Type"]! == "2" || showDanmakus[j]["Type"]! == "3" {
                                                        if Double(showDanmakus[j]["Appear"]!)! < player.currentTime().seconds + 10 && Double(showDanmakus[j]["Appear"]!)! + 10 > player.currentTime().seconds {
                                                            Text(showDanmakus[j]["Text"]!)
                                                                .font(.system(size: 14))
                                                                .foregroundColor(Color(hex: Int(showDanmakus[j]["Color"]!)!))
                                                                .offset(x: Double(showDanmakus[j]["Appear"]!)! * 50)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                .allowsHitTesting(false)
                                .offset(x: -danmakuOffset)
                                .animation(.smooth, value: danmakuOffset)
                            }
                            VStack {
                                if isShowTopDanmaku {
                                    ForEach(0..<showDanmakus.count, id: \.self) { i in
                                        if showDanmakus[i]["Type"]! == "5" {
                                            if Double(showDanmakus[i]["Appear"]!)! < player.currentTime().seconds + 5 && Double(showDanmakus[i]["Appear"]!)! + 5 > player.currentTime().seconds {
                                                Text(showDanmakus[i]["Text"]!)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color(hex: Int(showDanmakus[i]["Color"]!)!))
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                if isShowBottomDanmaku {
                                    ForEach(0..<showDanmakus.count, id: \.self) { i in
                                        if showDanmakus[i]["Type"]! == "4" {
                                            if Double(showDanmakus[i]["Appear"]!)! < player.currentTime().seconds + 5 && Double(showDanmakus[i]["Appear"]!)! + 5 > player.currentTime().seconds {
                                                Text(showDanmakus[i]["Text"]!)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color(hex: Int(showDanmakus[i]["Color"]!)!))
                                            }
                                        }
                                    }
                                }
                            }
                            .allowsHitTesting(false)
                            .animation(.smooth)
                        }
                    }
                }
            #else
            TabView(selection: $tabviewChoseTab) {
                ZStack {
                    VideoPlayer(player: player)
                        .rotationEffect(.degrees(isFullScreen ? 90 : 0))
                        .frame(width: isFullScreen ? WKInterfaceDevice.current().screenBounds.height : nil, height: isFullScreen ? WKInterfaceDevice.current().screenBounds.width : nil)
                        .offset(y: isFullScreen ? 20 : 0)
                        .ignoresSafeArea()
                        .overlay {
                            ZStack {
                                if isDanmakuEnabled {
                                    VStack {
                                        ForEach(0...3, id: \.self) { i in
                                            ZStack {
                                                ForEach(0..<showDanmakus.count, id: \.self) { j in
                                                    if j % 4 == i {
                                                        if showDanmakus[j]["Type"]! == "1" || showDanmakus[j]["Type"]! == "2" || showDanmakus[j]["Type"]! == "3" {
                                                            if Double(showDanmakus[j]["Appear"]!)! < player.currentTime().seconds + 10 && Double(showDanmakus[j]["Appear"]!)! + 10 > player.currentTime().seconds {
                                                                Text(showDanmakus[j]["Text"]!)
                                                                    .font(.system(size: 12))
                                                                    .foregroundColor(Color(hex: Int(showDanmakus[j]["Color"]!)!))
                                                                    .offset(x: Double(showDanmakus[j]["Appear"]!)! * 50)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                    .allowsHitTesting(false)
                                    .offset(x: -danmakuOffset)
//                                    .animation(.linear, value: danmakuOffset)
                                }
                            }
                            .rotationEffect(.degrees(isFullScreen ? 90 : 0))
                            .frame(width: isFullScreen ? WKInterfaceDevice.current().screenBounds.height : nil, height: isFullScreen ? WKInterfaceDevice.current().screenBounds.width : nil)
                        }
                    if cachedPlayerTimeControlStatus == .paused {
                        VStack {
                            ZStack {
                                Color.accentColor // For tap gesture
                                    .frame(width: 60, height: 40)
                                    .opacity(0.0100000002421438702673861521)
                                HStack(spacing: 2) {
                                    Image(systemName: "rectangle.portrait.arrowtriangle.2.outward")
                                        .shadow(color: .accentColor, radius: 1)
                                    Text(String(__playerScale))
                                        .shadow(color: .accentColor, radius: 1)
                                }
                                .font(.system(size: 14))
                            }
                            .onTapGesture {
                                if __playerScale < 10.0 {
                                    __playerScale += 1.0
                                    playerScale += 1.0
                                } else {
                                    __playerScale = 1.0
                                    playerScale = 1.0
                                    playerScaledOffset = CGSizeZero
                                    playerScaledLastOffset = CGSizeZero
                                }
                            }
                            Spacer()
                        }
                        .ignoresSafeArea()
                    }
                }
                .animation(.smooth, value: cachedPlayerTimeControlStatus)
                .animation(.smooth, value: playerScale)
                .animation(.smooth, value: __playerScale)
                .scrollIndicators(.never)
                ._statusBarHidden(true)
                .tag(1)
                List {
                    Section {
                        Button(action: {
                            isFullScreen.toggle()
                            tabviewChoseTab = 1
                        }, label: {
                            Label(
                                isFullScreen ? "恢复" : "全屏",
                                systemImage: isFullScreen ? "arrow.down.right.and.arrow.up.left" : "arrow.down.left.and.arrow.up.right"
                            )
                        })
                    } header: {
                        Text("画面")
                    }
                    Section {
                        Toggle(isOn: $isDanmakuEnabled) { Text("启用") }
                    } header: {
                        Text("弹幕")
                    }
                    Section {
                        HStack {
                            VolumeControlView()
                            Text("轻触后滑动数码表冠")
                        }
                        .listRowBackground(Color.clear)
                    } header: {
                        Text("声音")
                    }
                    Section {
                        Picker("播放倍速", selection: $playbackSpeed) {
                            Text("0.5x").tag(0.5)
                            Text("0.75x").tag(0.75)
                            Text("1x").tag(1.0)
                            Text("1.5x").tag(1.5)
                            Text("2x").tag(2.0)
                            Text("3x").tag(3.0)
                            Text("5x").tag(5.0)
                        }
                        .onChange(of: playbackSpeed) {
                            player.rate = Float(playbackSpeed)
                        }
                        TextField("跳转到...(秒)", text: $jumpToInput) {
                            if let jt = Double(jumpToInput) {
                                player.seek(to: CMTime(seconds: jt, preferredTimescale: 1))
                            }
                            jumpToInput = ""
                        }
                        Button(action: {
                            player.seek(to: CMTime(seconds: currentTime + 10, preferredTimescale: 60000))
                        }, label: {
                            Label("快进 10 秒", systemImage: "goforward.10")
                        })
                        Button(action: {
                            player.seek(to: CMTime(seconds: currentTime - 10, preferredTimescale: 60000))
                        }, label: {
                            Label("快退 10 秒", systemImage: "gobackward.10")
                        })
                    } header: {
                        Text("播放")
                    }
                }
                .tag(2)
            }
            .tabViewStyle(.page)
            .toolbar(.hidden, for: .navigationBar)
            .ignoresSafeArea()
            .accessibilityQuickAction(style: .prompt) {
                if isVideoPlayerGestureEnabled {
                    Button(action: {
                        switch videoPlayerGestureBehavior {
                        case "Play/Pause":
                            if player.timeControlStatus == .playing {
                                player.pause()
                            } else if player.timeControlStatus == .paused {
                                player.play()
                            }
                        case "Pause/Exit":
                            if player.timeControlStatus == .playing {
                                player.pause()
                            } else if player.timeControlStatus == .paused {
                                dismiss()
                            }
                        case "Exit":
                            player.pause()
                            dismiss()
                        case "Exit App":
                            exit(0)
                        default:
                            break
                        }
                    }, label: {
                        Text("PlayerGesture")
                    })
                }
            }
            .onReceive(player.publisher(for: \.timeControlStatus)) { status in
                if _slowPath(status != cachedPlayerTimeControlStatus) {
                    if status == .playing {
                        player.rate = Float(playbackSpeed)
                    }
                    cachedPlayerTimeControlStatus = status
                }
            }
            #endif
        }
        .onAppear {
            if !isFinishedInit {
                isFinishedInit = true
                
                let asset = AVURLAsset(url: URL(string: videoLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
                let item = AVPlayerItem(asset: asset)
                player = AVPlayer(playerItem: item)
                player.play()
                
                player.seek(to: CMTime(seconds: UserDefaults.standard.double(forKey: "\(videoBvid)\(videoCID)PlayTime"), preferredTimescale: 1))
                
//                if let coverData = try? Data(contentsOf: URL(string: videoDetails["Pic"] ?? "") ?? URL(string: "http://example.com")!) {
//                    let cover = UIImage(data: coverData) ?? UIImage()
//                    NowPlayingExtension.setPlayingInfoTitle(videoDetails["Title"]!, artist: videoDetails["UP"]!, artwork: cover)
//                }
                
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)"
                ]
                
                #if !os(watchOS)
                if isRecordHistory {
                    AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": videoBvid, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
                        debugPrint(response)
                    }
                    
                    playerTimer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
                        debugPrint(player.currentTime())
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata)"
                        ]
                        AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": videoBvid, "mid": dedeUserID, "played_time": Int(player.currentTime().seconds), "type": 3, "dt": 2, "play_type": 0, "csrf": biliJct], headers: headers).response { response in
                            debugPrint(response)
                        }
                    }
                }
                #else
                if recordHistoryTime == "play" {
                    AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": videoBvid, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
                        debugPrint(response)
                    }
                }
                #endif
                
                UpdateDanmaku()
                
                playProgressTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                    if (player.currentItem?.duration.seconds ?? 0) - player.currentTime().seconds > 10 {
                        UserDefaults.standard.set(player.currentTime().seconds, forKey: "\(videoBvid)\(videoCID)PlayTime")
                    } else {
                        UserDefaults.standard.removeObject(forKey: "\(videoBvid)\(videoCID)PlayTime")
                    }
                }
            }
        }
        .onDisappear {
            #if !os(watchOS)
            guard !willBeginFullScreenPresentation else {
                willBeginFullScreenPresentation = false
                return
            }
            if willEnterGoodVideo {
                didEnterGoodVideo = true
                willEnterGoodVideo = false
                player?.pause()
                return
            }
            #endif
            playerTimer?.invalidate()
            playProgressTimer?.invalidate()
            player?.pause()
            if (player.currentItem?.duration.seconds ?? 0) - player.currentTime().seconds > 10 {
                UserDefaults.standard.set(player.currentTime().seconds, forKey: "\(videoBvid)\(videoCID)PlayTime")
            } else {
                UserDefaults.standard.removeObject(forKey: "\(videoBvid)\(videoCID)PlayTime")
            }
        }
        .onChange(of: videoLink) {
            let asset = AVURLAsset(url: URL(string: videoLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
            let item = AVPlayerItem(asset: asset)
            player?.pause()
            player = nil
            player = AVPlayer(playerItem: item)
            player.play()
            player.seek(to: CMTime(seconds: UserDefaults.standard.double(forKey: "\(videoBvid)\(videoCID)PlayTime"), preferredTimescale: 1))
            
            showDanmakus.removeAll()
            danmakuOffset = 0
            UpdateDanmaku()
        }
        .onReceive(player.periodicTimePublisher()) { time in
            danmakuOffset = time.seconds * 50
            #if !os(watchOS)
            currentPlayTime = time.seconds
            #endif
            currentTime = time.seconds
        }
        #if !os(watchOS)
        .onChange(of: shouldPause) {
            if shouldPause {
                player?.pause()
                shouldPause = false
            }
        }
        #endif
    }
    
    @_optimize(speed)
    @inline(__always)
    func UpdateDanmaku() {
        AF.request("https://api.bilibili.com/x/v1/dm/list.so?oid=\(videoCID)").response { response in
            if let respData = response.data, let danmakus = String(data: respData, encoding: .utf8) {
                if danmakus.contains("<d p=\"") {
                    let danmakuOnly = danmakus.split(separator: "</source>")[1].split(separator: "</i>")[0]
                    let danmakuSpd = danmakuOnly.split(separator: "</d>")
                    for singleDanmaku in danmakuSpd {
                        let p = singleDanmaku.split(separator: "<d p=\"")[0].split(separator: "\"")[0]
                        let spdP = p.split(separator: ",")
                        var stredSpdP = [String]()
                        for p in spdP {
                            stredSpdP.append(String(p))
                        }
                        if singleDanmaku.split(separator: "\">").count < 2 {
                            return
                        }
                        let danmakuText = String(singleDanmaku.split(separator: "\">")[1].split(separator: "</d>")[0])
                        if stredSpdP[5] == "0" {
                            showDanmakus.append(["Appear": stredSpdP[0], "Type": stredSpdP[1], "Size": stredSpdP[2], "Color": stredSpdP[3], "Text": danmakuText])
                        }
                    }
                    showDanmakus.sort { dict1, dict2 in
                        if let time1 = dict1["Appear"], let time2 = dict2["Appear"] {
                            return Double(time1)! < Double(time2)!
                        }
                        return false
                    }
                    var removedCount = 0
                    for i in 1..<showDanmakus.count {
                        if showDanmakus.count - removedCount - i <= 0 {
                            break
                        }
                        if (Double(showDanmakus[i]["Appear"]!)! - Double(showDanmakus[i - 1]["Appear"]!)!) < 1 {
                            showDanmakus.remove(at: i)
                            removedCount++
                        }
                    }
                    removedCount = 0
                    var previousTopDanmakuIndex: Int?
                    var previousBottomDanmakuIndex: Int?
                    for i in 1..<showDanmakus.count {
                        if showDanmakus.count - removedCount - i <= 0 {
                            break
                        }
                        let type = showDanmakus[i]["Type"]!
                        if type == "5" || type == "4" {
                            if let preIndex = type == "5" ? previousTopDanmakuIndex : previousBottomDanmakuIndex {
                                if Double(showDanmakus[i]["Appear"]!)! - Double(showDanmakus[preIndex]["Appear"]!)! < 10 {
                                    showDanmakus.remove(at: i)
                                    removedCount++
                                    continue
                                }
                            }
                            { () -> UnsafeMutablePointer<Int?> in if type == "5" { &&previousTopDanmakuIndex } else { &&previousBottomDanmakuIndex } }().pointee = i
                        }
                    }
#if !os(watchOS)
                    if showDanmakus.count > 500 {
                        for _ in 1...5000 {
                            if showDanmakus.count <= 500 {
                                break
                            }
                            showDanmakus.remove(at: Int.random(in: 0..<showDanmakus.count))
                        }
                    }
#else
                    // Less danmakus for watch
                    if showDanmakus.count > 200 {
                        while showDanmakus.count > 200 {
                            showDanmakus.remove(at: Int.random(in: 0..<showDanmakus.count))
                        }
                    }
#endif
                }
            }
        }
    }
    
    #if !os(watchOS)
    func willBeginFullScreen(_ playerViewController: AVPlayerViewController, _ coordinator: UIViewControllerTransitionCoordinator) {
        willBeginFullScreenPresentation = true
    }
    func willEndFullScreen(_ playerViewController: AVPlayerViewController, _ coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    struct StrokeText: View {
        let text: String
        let width: CGFloat
        let color: Color

        var body: some View {
            ZStack {
                ZStack {
                    Text(text).offset(x: width, y: width)
                    Text(text).offset(x: -width, y: -width)
                    Text(text).offset(x: -width, y: width)
                    Text(text).offset(x: width, y: -width)
                }
                .foregroundColor(color)
                Text(text)
            }
        }
    }
    #endif
}

// Extensions for periodicTimePublisher
extension AVPlayer {
    func periodicTimePublisher(forInterval interval: CMTime = CMTime(seconds: 0.5,
                                                                     preferredTimescale: CMTimeScale(NSEC_PER_SEC))) -> AnyPublisher<CMTime, Never> {
        Publisher(self, forInterval: interval)
            .eraseToAnyPublisher()
    }
}
fileprivate extension AVPlayer {
    private struct Publisher: Combine.Publisher {
        typealias Output = CMTime
        typealias Failure = Never
        
        var player: AVPlayer
        var interval: CMTime
        
        init(_ player: AVPlayer, forInterval interval: CMTime) {
            self.player = player
            self.interval = interval
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            let subscription = CMTime.Subscription(subscriber: subscriber, player: player, forInterval: interval)
            subscriber.receive(subscription: subscription)
        }
    }
}
fileprivate extension CMTime {
    final class Subscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input == CMTime, SubscriberType.Failure == Never {
        var player: AVPlayer?
        var observer: Any?
        
        init(subscriber: SubscriberType, player: AVPlayer, forInterval interval: CMTime) {
            self.player = player
            observer = player.addPeriodicTimeObserver(forInterval: interval, queue: nil) { time in
                _ = subscriber.receive(time)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {
            // We do nothing here as we only want to send events when they occur.
            // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
        }
        
        func cancel() {
            if let observer = observer {
                player?.removeTimeObserver(observer)
            }
            observer = nil
            player = nil
        }
    }
}
