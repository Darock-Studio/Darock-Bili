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
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import AVKit
import SwiftUI
import DarockKit
import Alamofire
import AVFoundation
import AZVideoPlayer

struct VideoPlayerView: View {
    @Binding var isDanmakuEnabled: Bool
    @Binding var videoLink: String
    @Binding var videoBvid: String
    @Binding var videoCID: Int64
    @Binding var shouldPause: Bool
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("IsRecordHistory") var isRecordHistory = true
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
        AZVideoPlayer(player: player, willBeginFullScreenPresentationWithAnimationCoordinator: willBeginFullScreen, willEndFullScreenPresentationWithAnimationCoordinator: willEndFullScreen)
            .onAppear {
                if !isFinishedInit {
                    isFinishedInit = true
                    
                    let asset = AVURLAsset(url: URL(string: videoLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
                    let item = AVPlayerItem(asset: asset)
                    player = AVPlayer(playerItem: item)
                    player.play()
                    
                    player.seek(to: CMTime(seconds: UserDefaults.standard.double(forKey: "\(videoBvid)\(videoCID)PlayTime"), preferredTimescale: 1))
                    
                    let headers: HTTPHeaders = [
                        "cookie": "SESSDATA=\(sessdata)"
                    ]
                  
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
                    
                    AF.request("https://api.bilibili.com/x/v1/dm/list.so?oid=\(videoCID)").response { response in
                        let danmakus = String(data: response.data!, encoding: .utf8)!
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
                        }
                    }
                    
                    danmakuTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                        danmakuOffset = player.currentTime().seconds * 50
                    }
                    
                    playProgressTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                        UserDefaults.standard.set(player.currentTime().seconds, forKey: "\(videoBvid)\(videoCID)PlayTime")
                    }
                }
            }
            .onDisappear {
                guard !willBeginFullScreenPresentation else {
                    willBeginFullScreenPresentation = false
                    return
                }
                playerTimer?.invalidate()
                danmakuTimer?.invalidate()
                playProgressTimer?.invalidate()
                player?.pause()
                UserDefaults.standard.set(player.currentTime().seconds, forKey: "\(videoBvid)\(videoCID)PlayTime")
            }
            .onChange(of: videoLink) { value in
                let asset = AVURLAsset(url: URL(string: value)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
                let item = AVPlayerItem(asset: asset)
                player?.pause()
                player = nil
                player = AVPlayer(playerItem: item)
                player.play()
                player.seek(to: CMTime(seconds: UserDefaults.standard.double(forKey: "\(videoBvid)\(videoCID)PlayTime"), preferredTimescale: 1))
                
                showDanmakus.removeAll()
                danmakuOffset = 0
                AF.request("https://api.bilibili.com/x/v1/dm/list.so?oid=\(value)").response { response in
                    let danmakus = String(data: response.data!, encoding: .utf8)!
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
                    }
                }
            }
            .onChange(of: shouldPause) { value in
                if value == true {
                    player?.pause()
                    shouldPause = false
                }
            }
            .overlay {
                ZStack {
                    if isDanmakuEnabled {
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
                }
            }
    }
    
    func willBeginFullScreen(_ playerViewController: AVPlayerViewController, _ coordinator: UIViewControllerTransitionCoordinator) {
        willBeginFullScreenPresentation = true
    }
    func willEndFullScreen(_ playerViewController: AVPlayerViewController,_ coordinator: UIViewControllerTransitionCoordinator) {
        // This is a static helper method provided by AZVideoPlayer to keep
        // the video playing if it was playing when full screen presentation ended
        AZVideoPlayer.continuePlayingIfPlaying(player, coordinator)
    }
    
    struct StrokeText: View {
        let text: String
        let width: CGFloat
        let color: Color

        var body: some View {
            ZStack {
                ZStack {
                    Text(text).offset(x:  width, y:  width)
                    Text(text).offset(x: -width, y: -width)
                    Text(text).offset(x: -width, y:  width)
                    Text(text).offset(x:  width, y: -width)
                }
                .foregroundColor(color)
                Text(text)
            }
        }
    }
}
