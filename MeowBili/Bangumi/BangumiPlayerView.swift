//
//
//  BangumiPlayerView.swift
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
import Alamofire
#if !os(watchOS)
import AZVideoPlayer
#endif

struct BangumiPlayerView: View {
    @Binding var bangumiData: BangumiData
    #if !os(watchOS)
    @Binding var isDanmakuEnabled: Bool
    #endif
    @Binding var bangumiLink: String
    #if !os(watchOS)
    @Binding var shouldPause: Bool
    @Binding var currentPlayTime: Double
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
    @State var tabviewChoseTab = 1
    @State var isFullScreen = false
    #endif
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var danmakuTimer: Timer?
    @State var playProgressTimer: Timer?
    @State var player: AVPlayer!
    @State var isFinishedInit = false
    @State var willBeginFullScreenPresentation = false
    @State var showDanmakus = [[String: String]]()
    @State var danmakuOffset: CGFloat = 0
    var body: some View {
        Group {
            #if os(watchOS)
            ZStack {
                TabView(selection: $tabviewChoseTab) {
                    VideoPlayer(player: player)
                        .rotationEffect(.degrees(isFullScreen ? 90 : 0))
                        .frame(width: isFullScreen ? WKInterfaceDevice.current().screenBounds.height : nil, height: isFullScreen ? WKInterfaceDevice.current().screenBounds.width : nil)
                        .offset(y: isFullScreen ? 20 : 0)
                        .ignoresSafeArea()
                        .navigationBarHidden(true)
                        .tag(1)
                        .onAppear {
                            hideDigitalTime(true)
                            Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                                playerTimer = timer
                                debugPrint(player.currentTime())
                            }
                        }
                        .onDisappear {
                            hideDigitalTime(false)
                            playerTimer?.invalidate()
                        }
                    List {
                        Section {
                            Button(action: {
                                isFullScreen.toggle()
                                tabviewChoseTab = 1
                            }, label: {
                                if isFullScreen {
                                    Label("恢复", systemImage: "arrow.down.forward.and.arrow.up.backward")
                                } else {
                                    Label("全屏", systemImage: "arrow.down.backward.and.arrow.up.forward")
                                }
                            })
                        } header: {
                            Text("画面")
                        }
                        Section {
                            Toggle(isOn: $isDanmakuEnabled) { Text("启用") }
                        } header: {
                            Text("弹幕")
                        }
                    }
                    .tag(2)
                }
                .tabViewStyle(.page)
            }
            .ignoresSafeArea()
            #else
            AZVideoPlayer(player: player, willBeginFullScreenPresentationWithAnimationCoordinator: willBeginFullScreen, willEndFullScreenPresentationWithAnimationCoordinator: willEndFullScreen)
            #endif
        }
        .onAppear {
            let asset = AVURLAsset(url: URL(string: bangumiLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
            let item = AVPlayerItem(asset: asset)
            player = AVPlayer(playerItem: item)
            player.play()
            
            
        }
        .onDisappear {
            playerTimer?.invalidate()
        }
        .onChange(of: bangumiLink) { value in
            let asset = AVURLAsset(url: URL(string: value)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
            let item = AVPlayerItem(asset: asset)
            player?.pause()
            player = nil
            player = AVPlayer(playerItem: item)
            player.play()
        }
    }
    
    #if !os(watchOS)
    func willBeginFullScreen(_ playerViewController: AVPlayerViewController, _ coordinator: UIViewControllerTransitionCoordinator) {
        willBeginFullScreenPresentation = true
    }
    func willEndFullScreen(_ playerViewController: AVPlayerViewController, _ coordinator: UIViewControllerTransitionCoordinator) {
        // This is a static helper method provided by AZVideoPlayer to keep
        // the video playing if it was playing when full screen presentation ended
        AZVideoPlayer.continuePlayingIfPlaying(player, coordinator)
    }
    #endif
}

