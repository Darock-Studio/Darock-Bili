//
//
//  LivePlayerView.swift
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
import SwiftyJSON
import AVFoundation

struct LivePlayerView: View {
    @State var livePlayer: AVPlayer? = nil
    @State var tabviewChoseTab = 2
    var body: some View {
        VideoPlayer(player: livePlayer)
            .onAppear {
                let asset = AVURLAsset(url: URL(string: LiveDetailView.willPlayStreamUrl)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
                let item = AVPlayerItem(asset: asset)
                livePlayer = AVPlayer(playerItem: item)
                livePlayer?.play()
            }
    }
}
