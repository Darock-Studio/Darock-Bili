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
    @Environment(\.presentationMode) var presentationMode
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
    @AppStorage("ExternalSound") var externalSound = false
    @State var tabviewChoseTab = 1
    @State var isFullScreen = false
    @State var playbackSpeed = 1.0
    @State var jumpToInput = ""
    @State var playerScale: CGFloat = 1.0
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
                                                                .frame(maxWidth: .infinity)
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
                                .offset(x: UIScreen.main.bounds.width / 2)
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
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .withTouchZoomGesture(onPositionChange: { translation in
                        if playerScale > 1.1 {
                            playerScaledOffset = .init(width: playerScaledOffset.width + translation.x, height: playerScaledOffset.height + translation.y)
                        }
                    }, onScaleChange: { scale in
                        if scale >= 1.0 {
                            playerScale = scale
                        } else {
                            playerScale = 1.0
                        }
                        if scale <= 1.1 {
                            playerScaledOffset = .zero
                        }
                    })
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
                                                                .frame(maxWidth: .infinity)
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
                                .offset(x: WKInterfaceDevice.current().screenBounds.width / 2)
                                .offset(x: -danmakuOffset)
                                .animation(.smooth, value: danmakuOffset)
                            }
                        }
                    }
                    .rotationEffect(.degrees(isFullScreen ? 90 : 0))
                    .frame(
                        width: isFullScreen ? WKInterfaceDevice.current().screenBounds.height : nil,
                        height: isFullScreen ? WKInterfaceDevice.current().screenBounds.width : nil
                    )
                    .offset(y: isFullScreen ? 19 : 0)
                    .scaleEffect(playerScale)
                    .ignoresSafeArea()
                    .offset(playerScaledOffset)
                    .animation(.smooth, value: cachedPlayerTimeControlStatus)
                    .animation(.smooth, value: playerScale)
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
            .tabViewStyle(.page(indexDisplayMode: cachedPlayerTimeControlStatus != .playing ? .always : .never))
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
                                presentationMode.wrappedValue.dismiss()
                            }
                        case "Exit":
                            player.pause()
                            presentationMode.wrappedValue.dismiss()
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
                
                #if os(watchOS)
                if externalSound {
                    // 根据 externalSound 设置配置 AVAudioSession
                    let audioSession = AVAudioSession.sharedInstance()
                    do {
                        try audioSession.setCategory(.playback, mode: .default, options: [])
                        try audioSession.setActive(true)
                    } catch {
                        print("Failed to configure AVAudioSession: \(error)")
                    }
                }
                #endif
                
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
                    guard showDanmakus.count > 1 else { return }
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

#if os(watchOS)
extension View {
    @ViewBuilder
    func touchZoomable() -> some View {
        ZoomableRepresent(sourceView: self)
    }
    
    @ViewBuilder
    func withTouchZoomGesture(onPositionChange: @escaping (CGPoint) -> Void, onScaleChange: @escaping (CGFloat) -> Void) -> some View {
        ZoomableRepresent(sourceView: self, onPositionChange: onPositionChange, onScaleChange: onScaleChange)
    }
}

private struct ZoomableRepresent<T>: _UIViewControllerRepresentable where T: View {
    let sourceView: T
    var onPositionChange: ((CGPoint) -> Void)?
    var onScaleChange: ((CGFloat) -> Void)?
    
    func makeUIViewController(context: Context) -> some NSObject {
        let hostingSource = Dynamic(_makeUIHostingController(AnyView(sourceView)))
        hostingSource.view.userInteractionEnabled = true
        
        let panGesture = Dynamic.UIPanGestureRecognizer.initWithTarget(context.coordinator, action: #selector(Coordinator.handlePanGesture(_:)))
        panGesture.delegate = context.coordinator
        panGesture.cancelsTouchesInView = false
        hostingSource.view.addGestureRecognizer(panGesture)
        
        let pinchGesture = Dynamic.UIPinchGestureRecognizer.initWithTarget(context.coordinator, action: #selector(Coordinator.handlePinchGesture(_:)))
        pinchGesture.delegate = context.coordinator
        pinchGesture.cancelsTouchesInView = false
        hostingSource.view.addGestureRecognizer(pinchGesture)
        
        return hostingSource.asObject!
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(Dynamic(_makeUIHostingController(AnyView(sourceView))).view.asObject!, onPositionChange: onPositionChange, onScaleChange: onScaleChange)
    }
    
    @objcMembers
    final class Coordinator: NSObject {
        let hostingSource: NSObject
        var onPositionChange: ((CGPoint) -> Void)?
        var onScaleChange: ((CGFloat) -> Void)?
        
        init(_ hostingSource: NSObject, onPositionChange: ((CGPoint) -> Void)? = nil, onScaleChange: ((CGFloat) -> Void)? = nil) {
            self.hostingSource = hostingSource
            self.onPositionChange = onPositionChange
            self.onScaleChange = onScaleChange
        }
        
        func handlePanGesture(_ panGesture: NSObject) {
            let panGesture = Dynamic(panGesture)
            let translation = panGesture.translationInView(panGesture.view.superview.asObject!).asCGPoint!
            if let onPositionChange {
                onPositionChange(translation)
                panGesture.setTranslation(CGPoint.zero, inView: hostingSource)
            } else {
                if panGesture.state == 1 || panGesture.state == 2 {
                    let centerPoint = panGesture.view.center.asCGPoint!
                    panGesture.view.center = CGPoint(x: centerPoint.x + translation.x, y: centerPoint.y + translation.y)
                    panGesture.setTranslation(CGPoint.zero, inView: hostingSource)
                }
            }
        }
        func handlePinchGesture(_ pinchGesture: NSObject) {
            let pinchGesture = Dynamic(pinchGesture)
            if pinchGesture.state == 1 || pinchGesture.state == 2 {
                #if !targetEnvironment(simulator)
                let scale = CGFloat(pinchGesture.scale.asFloat!)
                #else
                let scale = CGFloat(pinchGesture.scale.asDouble!)
                #endif
                if let onScaleChange {
                    onScaleChange(scale)
                } else {
                    pinchGesture.view.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
        
        func gestureRecognizer(
            _ gestureRecognizer: Any,
            shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: Any
        ) -> Bool {
            true
        }
    }
}
#endif

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
