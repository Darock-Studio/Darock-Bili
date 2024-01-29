//
//  BangumiPlayerView.swift
//  DarockBili Watch App
//
//  Created by 雷美淳 on 2024/1/13.
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
import Alamofire

struct BangumiPlayerView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("IsUseModifiedPlayer") var isUseModifiedPlayer = true
    @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var tabviewChoseTab = 1
    @State var playerRotate = 0.0
    @State var player: AVPlayer!
    var body: some View {
        ZStack {
            TabView(selection: $tabviewChoseTab) {
                VideoPlayer(player: player)
                    .rotationEffect(.degrees(playerRotate))
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
            let asset = AVURLAsset(url: URL(string: BangumiDetailView.willPlayBangumiLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
            let item = AVPlayerItem(asset: asset)
            player = AVPlayer(playerItem: item)
            
            debugPrint(URL(string: BangumiDetailView.willPlayBangumiLink)!)
//            let headers: HTTPHeaders = [
//                "cookie": "SESSDATA=\(sessdata)"
//            ]
//            if recordHistoryTime == "play" {
//                AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": VideoDetailView.willPlayVideoBV, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
//                    debugPrint(response)
//                }
//            }
        }
        .onDisappear {
            playerTimer?.invalidate()
        }
    }
}

#Preview {
    BangumiPlayerView()
}
