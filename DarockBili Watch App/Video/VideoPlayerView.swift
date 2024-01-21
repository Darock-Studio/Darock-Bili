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
    @AppStorage("IsPlayerAutoRotating") var isPlayerAutoRotating = true
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
            TabView(selection: $tabviewChoseTab) {
                ScrollView {
                    VStack {
                        if showDanmakus.count != 0 {
                            ForEach(0...showDanmakus.count - 1, id: \.self) { i in
                                HStack {
                                    Text("时间：\(String(format: "%.1f", Double(showDanmakus[i]["Appear"]!)!))")
                                    Spacer()
                                }
                                HStack {
                                    Text(showDanmakus[i]["Text"]!)
                                        .foregroundColor(Color(hex: Int(showDanmakus[i]["Color"]!)!))
                                        .bold()
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                    }
                }
                .tag(0)
                
                VideoPlayer(player: player)
                    .rotationEffect(.degrees(playerRotate))
                    .ignoresSafeArea()
                    //.modifier(zoomable())
                    .onAppear {
                        hideDigitalTime(true)
                        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                            playerTimer = timer
//                                                debugPrint(player.currentTime())
//                                                debugPrint(player.currentItem!.status)
//                                                danmakuWallOffsetX = player.currentTime().seconds * 20
                            
                            debugPrint(player.currentTime())
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)"
                            ]
                            AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": VideoDetailView.willPlayVideoBV, "mid": dedeUserID, "played_time": Int(player.currentTime().seconds), "type": 3, "dt": 2, "play_type": 0, "csrf": biliJct], headers: headers).response { response in
                                debugPrint(response)
                            }
                        }
//                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//                            danmakuOffset = -(player.currentTime().seconds * 2.0)
//                            for i in 0..<showDanmakus.count {
//                                let appTime = Double(showDanmakus[i]["Appear"]!)!
//                                var nextLineIndex: Int
//                                if player.currentTime().seconds - appTime < 1.0 {
//                                    if lastDanmakuLine + 1 > 4 {
//                                        nextLineIndex = 1
//                                        lastDanmakuLine = 0
//                                    } else {
//                                        lastDanmakuLine++
//                                        nextLineIndex = lastDanmakuLine
//                                    }
//                                } else {
//                                    nextLineIndex = 1
//                                }
//                                nextLineIndex--
//                                if showedDanmakus[nextLineIndex] == nil {
//                                    showedDanmakus[nextLineIndex] = [(i, Double(showDanmakus[i]["Appear"]!)! * 10.0)]
//                                } else {
//                                    showedDanmakus[nextLineIndex]?.append((i, Double(showDanmakus[i]["Appear"]!)! * 10.0))
//                                }
//                            }
//                        }
                    }
                    .onDisappear {
                        hideDigitalTime(false)
                        playerTimer?.invalidate()
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
//            if showDanmakus.count != 0 {
//                VStack {
//                    ZStack {
//                        LazyVStack {
//                            if showedDanmakus[0] != nil {
//                                ZStack {
//                                    ForEach(0..<showedDanmakus[0]!.count, id: \.self) { i in
//                                        Text(showDanmakus[showedDanmakus[0]![i].danmaku]["Text"]!)
//                                            .offset(x: showedDanmakus[0]![i].offset)
//                                    }
//                                }
//                            }
//                            if showedDanmakus[1] != nil {
//                                ZStack {
//                                    
//                                }
//                            }
//                            if showedDanmakus[2] != nil {
//                                ZStack {
//                                    
//                                }
//                            }
//                            if showedDanmakus[3] != nil {
//                                ZStack {
//                                    
//                                }
//                            }
//                        }
//                    }
//                    Spacer()
//                }
//                .ignoresSafeArea()
//                .allowsHitTesting(false)
//                .offset(x: danmakuOffset)
//            }
        }
        .ignoresSafeArea()
        .accessibilityQuickAction(style: .prompt) {
            if isVideoPlayerGestureEnabled {
                Button(action: {
                    player?.pause()
                }, label: {
                    Text("Pause")
                })
            }
        }
        .onAppear {
            let pExtension = AVExtension(VideoDetailView.willPlayVideoLink)!
            player = pExtension.getPlayer()
            
            if isPlayerAutoRotating {
                WKApplication.shared().isAutorotating = true
            }
            debugPrint(URL(string: VideoDetailView.willPlayVideoLink)!)
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)"
            ]
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
                            if showDanmakus.count >= 5000 {
                                break
                            }
                        }
                    }
                    showDanmakus.sort { dict1, dict2 in
                        if let time1 = dict1["Appear"], let time2 = dict2["Appear"] {
                            return Double(time1)! < Double(time2)!
                        }
                        return false
                    }
                    debugPrint(showDanmakus)
                }
            }
            if recordHistoryTime == "play" {
                AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": VideoDetailView.willPlayVideoBV, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
                    debugPrint(response)
                }
            }
        }
        .onDisappear {
            if isPlayerAutoRotating {
                WKApplication.shared().isAutorotating = false
            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
