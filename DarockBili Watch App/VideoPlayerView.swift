//
//  VideoPlayerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI
import DarockKit
import Alamofire
import AVKit
import AVFoundation

struct VideoPlayerView: View {
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var showDanmakus = [[String: String]]()
    @State var danmakuWallOffsetX: CGFloat = 0
    var body: some View {
        let asset = AVURLAsset(url: URL(string: VideoDetailView.willPlayVideoLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": [
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
            "accept-encoding": "gzip, deflate, br",
            "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
            "cookie": "",
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.30 Safari/537.36 Edg/84.0.522.11",
            "sec-fetch-dest": "document",
            "sec-fetch-mode": "navigate",
            "sec-fetch-site": "none",
            "sec-fetch-user": "?1",
            "upgrade-insecure-requests": "1",
            "referer": "https://www.bilibili.com/video/\(VideoDetailView.willPlayVideoBV)"
        ]])
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        ZStack {
            VideoPlayer(player: player)
                .ignoresSafeArea()
                .onAppear {
//                    Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { timer in
//                        playerTimer = timer
//                        debugPrint(player.currentTime())
//                        debugPrint(player.currentItem!.status)
//                        danmakuWallOffsetX = player.currentTime().seconds * 20
//                    }
                }
                .onDisappear {
//                    if playerTimer != nil {
//                        playerTimer!.invalidate()
//                    }
                }
            
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
//            AF.request("https://api.bilibili.com/x/v1/dm/list.so?oid=\(VideoDetailView.willPlayVideoCID)").response { response in
//                let danmakus = String(data: response.data!, encoding: .utf8)!
//                debugPrint(danmakus)
//                if danmakus.contains("<d p=\"") {
//                    let danmakuOnly = danmakus.split(separator: "</source>")[1].split(separator: "</i>")[0]
//                    let danmakuSpd = danmakuOnly.split(separator: "</d>")
//                    for singleDanmaku in danmakuSpd {
//                        let p = singleDanmaku.split(separator: "<d p=\"")[0].split(separator: "\"")[0]
//                        let spdP = p.split(separator: ",")
//                        var stredSpdP = [String]()
//                        for p in spdP {
//                            stredSpdP.append(String(p))
//                        }
//                        let danmakuText = String(singleDanmaku.split(separator: "\">")[1].split(separator: "</d>")[0])
//                        if stredSpdP[5] == "0" {
//                            showDanmakus.append(["Appear": stredSpdP[0], "Type": stredSpdP[1], "Size": stredSpdP[2], "Color": stredSpdP[3], "Text": danmakuText])
//                        }
//                    }
//                }
//            }
        }
    }
}

#Preview {
    VideoPlayerView()
}
