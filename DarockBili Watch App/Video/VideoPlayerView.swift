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
    @AppStorage("SESSDATA") var sessdata = ""
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var showDanmakus = [[String: String]]()
    @State var danmakuWallOffsetX: CGFloat = 0
    var body: some View {
        let asset = AVURLAsset(url: URL(string: VideoDetailView.willPlayVideoLink)!/*, options: ["AVURLAssetHTTPHeaderFieldsKey": [
            "Referer": "https://www.bilibili.com/video/\(VideoDetailView.willPlayVideoBV)",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
            "platform": "html5"
                                                                                    ]]*/, options: [AVURLAssetHTTPUserAgentKey: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"])
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
            debugPrint(URL(string: VideoDetailView.willPlayVideoLink)!)
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

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
