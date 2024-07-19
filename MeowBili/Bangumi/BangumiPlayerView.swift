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
import DarockKit
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
    @State var playbackSpeed = 1.0
    @State var jumpToInput = ""
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
                            SegmentedPicker(selection: $isFullScreen, leftText: "正常", rightText: "全屏")
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
            }
            .ignoresSafeArea()
            #else
            AZVideoPlayer(player: player, willBeginFullScreenPresentationWithAnimationCoordinator: willBeginFullScreen, willEndFullScreenPresentationWithAnimationCoordinator: willEndFullScreen, pausesWhenFullScreenPlaybackEnds: false)
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
            player.pause()
        }
        .onChange(of: bangumiLink) {
            let asset = AVURLAsset(url: URL(string: bangumiLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
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
        
    }
    #endif
}
