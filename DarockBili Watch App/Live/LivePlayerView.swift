//
//  LivePlayerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/28.
//

import AVKit
import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation

struct LivePlayerView: View {
    var id: String
    @State var playUrl = ""
    @State var livePlayer: AVPlayer? = nil
    var body: some View {
        TabView {
//            VideoPlayer(player: livePlayer)
//                .ignoresSafeArea()
        }
        //.navigationBarBackButtonHidden()
        .onAppear {
            DarockKit.Network.shared.requestJSON("https://api.live.bilibili.com/room/v1/Room/playUrl?cid=\(id)&qn=150") { respJson, isSuccess in
                if isSuccess {
                    debugPrint(respJson)
                    playUrl = respJson["data"]["durl"][0]["url"].string ?? ""
                    debugPrint(playUrl)
                    livePlayer = AVPlayer(url: URL(string: playUrl)!)
                }
            }
        }
    }
}

struct LivePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        LivePlayerView(id: "114514")
    }
}
