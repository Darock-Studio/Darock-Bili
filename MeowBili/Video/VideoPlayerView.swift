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
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @State var currentTime: Double = 0.0
    @State var playerTimer: Timer?
    @State var player: AVPlayer!
    @State var isFinishedInit = false
    var body: some View {
        AZVideoPlayer(player: player)
            .onAppear {
                if !isFinishedInit {
                    isFinishedInit = true
                    
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
            }
            .onDisappear {
                playerTimer?.invalidate()
            }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
