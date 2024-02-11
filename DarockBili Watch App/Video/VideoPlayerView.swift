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
    @AppStorage("IsDanmakuEnabled") var isDanmakuEnabled = true
    @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var danmakuTimer: Timer?
    @State var showDanmakus = [[String: String]]()
    @State var tabviewChoseTab = 1
    @State var playerRotate = 0.0
    @State var player: AVPlayer!
    @State var danmakuOffset = 0.0
    var body: some View {
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
                    }
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
                        }
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
                    Toggle(isOn: $isDanmakuEnabled) { Text("弹幕") }
                }
            }
            .tag(2)
        }
        .tabViewStyle(.page)
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
            
            AF.request("https://api.bilibili.com/x/v1/dm/list.so?oid=\(VideoDetailView.willPlayVideoCID)").response { response in
                let danmakus = String(data: response.data!, encoding: .utf8)!
                debugPrint(danmakus)
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
                        if (Double(showDanmakus[i]["Appear"]!)! - Double(showDanmakus[i - 1]["Appear"]!)!) < 0.5 {
                            showDanmakus.remove(at: i)
                            removedCount++
                        }
                    }
                    debugPrint(showDanmakus)
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                danmakuTimer = timer
                danmakuOffset = player.currentTime().seconds * 50
            }
        }
        .onDisappear {
            playerTimer?.invalidate()
            danmakuTimer?.invalidate()
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
