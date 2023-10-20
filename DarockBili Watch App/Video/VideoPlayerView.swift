//
//  VideoPlayerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

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
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var showDanmakus = [[String: String]]()
    @State var danmakuWallOffsetX: CGFloat = 0
    @State var tabviewChoseTab = 1
    @State var playerRotate = 0.0
    var body: some View {
//        let asset = AVURLAsset(url: URL(string: VideoDetailView.willPlayVideoLink)!/*, options: ["AVURLAssetHTTPHeaderFieldsKey": [
//            "Referer": "https://www.bilibili.com/video/\(VideoDetailView.willPlayVideoBV)",
//            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
//            "platform": "html5"
//                                                                                    ]]*/, options: [AVURLAssetHTTPUserAgentKey: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"])
//        let item = AVPlayerItem(asset: asset)
//        let player = AVPlayer(playerItem: item)
        let pExtension = AVExtension(VideoDetailView.willPlayVideoLink)!
        let player = pExtension.getPlayer()
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
                    .onAppear {
                        hideDigitalTime(true)
                        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                            playerTimer = timer
//                                                debugPrint(player.currentTime())
//                                                debugPrint(player.currentItem!.status)
//                                                danmakuWallOffsetX = player.currentTime().seconds * 20
                            
                            debugPrint(pExtension.getCurrentPlayTimeSeconds())
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)"
                            ]
                            AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": VideoDetailView.willPlayVideoBV, "mid": dedeUserID, "played_time": Int(pExtension.getCurrentPlayTimeSeconds()), "type": 3, "dt": 2, "play_type": 0, "csrf": biliJct], headers: headers).response { response in
                                debugPrint(response)
                            }
                        }
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
//                Group {
//                    ForEach(0...showDanmakus.count - 1, id: \.self) { i in
//                        if i != 0 {
//                            let danmakuLast = showDanmakus[i - 1]
//                            let danmakuThis = showDanmakus[i]
//                            if (Double(danmakuThis["Appear"]!)! - Double(danmakuLast["Appear"]!)!) <= 3 {
//                                HStack {
//                                    Text(danmakuThis["Text"]!)
//                                        .offset(x: Double(danmakuThis["Appear"]!)! * 300)
//                                }
//                            } else {
//                                VStack {
//                                    Text(danmakuThis["Text"]!)
//                                        .offset(x: Double(danmakuThis["Appear"]!)! * 300)
//                                }
//                            }
//                        }
//                    }
//                }
//                .offset(x: danmakuWallOffsetX)
//            }
        }
        .ignoresSafeArea()
        .onAppear {
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
