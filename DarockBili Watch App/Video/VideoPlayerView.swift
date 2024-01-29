//
//  VideoPlayerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
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

import AVKit
import SwiftUI
import BPlayer
import WatchKit
import DarockKit
import Alamofire
import AVFoundation

struct VideoPlayerView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("IsUseModifiedPlayer") var isUseModifiedPlayer = true
    @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var showDanmakus = [[String: String]]()
    @State var showedDanmakus: [[(danmaku: Int, offset: Double)]?] = [nil, nil, nil, nil]
    @State var tabviewChoseTab = 1
    @State var playerRotate = 0.0
    @State var player: AVPlayer!
    @State var danmakuOffset = 0.0
    @State var lastDanmakuOffset = 0.0
    @State var lastDanmakuLine = 0
    @State var lastDanmakuIndex = 0
    var body: some View {
//        let asset = AVURLAsset(url: URL(string: VideoDetailView.willPlayVideoLink)!/*, options: ["AVURLAssetHTTPHeaderFieldsKey": [
//            "Referer": "https://www.bilibili.com/video/\(VideoDetailView.willPlayVideoBV)",
//            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
//            "platform": "html5"
//                                                                                    ]]*/, options: [AVURLAssetHTTPUserAgentKey: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"])
//        let item = AVPlayerItem(asset: asset)
//        let player = AVPlayer(playerItem: item)
        
        ZStack {
            if #available(watchOS 10, *), isUseModifiedPlayer {
                if player != nil {
                    LSContentView(videoUrl: VideoDetailView.willPlayVideoLink, videoBvid: VideoDetailView.willPlayVideoBV, videoData: .init(enableFlyComment: true, currentCid: Int64(VideoDetailView.willPlayVideoCID) ?? 0), player: player)
                }
                
            } else {
                TabView(selection: $tabviewChoseTab) {
                    ZStack {
                        VideoPlayer(player: player)
                            .rotationEffect(.degrees(playerRotate))
                            .ignoresSafeArea()
                            .onAppear {
                                hideDigitalTime(true)
                                Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                                    playerTimer = timer
                                    debugPrint(player.currentTime())
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata)"
                                    ]
                                    AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": VideoDetailView.willPlayVideoBV, "mid": dedeUserID, "played_time": Int(player.currentTime().seconds), "type": 3, "dt": 2, "play_type": 0, "csrf": biliJct], headers: headers).response { response in
                                        debugPrint(response)
                                    }
                                }
                            }
                            .onDisappear {
                                hideDigitalTime(false)
                                playerTimer?.invalidate()
                            }
                    }
                    .tag(1)
                    ScrollView {
                        VStack {
                            HStack {
                                Button(action: {
                                    if playerRotate - 90 > 0 {
                                        playerRotate -= 90
                                    } else {
                                        playerRotate = 270
                                    }
                                }, label: {
                                    Image(systemName: "rotate.left")
                                })
                                Button(action: {
                                    if playerRotate + 90 < 360 {
                                        playerRotate += 90
                                    } else {
                                        playerRotate = 0
                                    }
                                }, label: {
                                    Image(systemName: "rotate.right")
                                })
                            }
                        }
                    }
                    .tag(2)
                }
                .tabViewStyle(.page)
            }
        }
        .ignoresSafeArea()
        .accessibilityQuickAction(style: .prompt) {
            if isVideoPlayerGestureEnabled {
                Button(action: {
                    player?.pause()
                }, label: {
                    Text("Player.pause")
                })
            }
        }
        .onAppear {
            let pExtension = AVExtension(VideoDetailView.willPlayVideoLink)!
            player = pExtension.getPlayer()
            
            debugPrint(URL(string: VideoDetailView.willPlayVideoLink)!)
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)"
            ]
            if recordHistoryTime == "play" {
                AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": VideoDetailView.willPlayVideoBV, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
                    debugPrint(response)
                }
            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
