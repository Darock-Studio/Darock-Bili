//
//  AudioPlayerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/23.
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
import Combine
import SwiftUI
import WatchKit
import DarockKit
import Alamofire
import AVFoundation
import CachedAsyncImage

struct AudioPlayerView: View {
    var videoDetails: [String: String]
    var subTitles: [[String: String]]
    @AppStorage("AudioPlayBehavior") var audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
    @State var audioPlayer = AVPlayer()
    @State var playerItem: AVPlayerItem! = nil
    @State var isPlaying = true
    @State var finishObserver: AnyCancellable?
    @State var startObserver: AnyCancellable?
    @State var backgroundPicOpacity = 0.0
    @State var nowPlayTimeTimer: Timer?
    var body: some View {
        VStack {
            if #available(watchOS 10, *) {
                VStack {
                    AsyncImage(url: URL(string: videoDetails["Pic"]! + "@110w_85h"))
                        .cornerRadius(10)
                    Text(videoDetails["Title"]!)
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(1)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 20)
                }
                .containerBackground(for: .navigation) {
                    ZStack {
                        CachedAsyncImage(url: URL(string: videoDetails["Pic"]!)) { phase in
                            switch phase {
                            case .empty:
                                Color.black
                            case .success(let image):
                                image
                                    .onAppear {
                                        backgroundPicOpacity = 1.0
                                    }
                            case .failure:
                                Color.black
                            @unknown default:
                                Color.black
                            }
                        }
                        .blur(radius: 20)
                        .opacity(backgroundPicOpacity)
                        .animation(.easeOut(duration: 1.2), value: backgroundPicOpacity)
                        Color.black
                            .opacity(0.4)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                            let behaviorCase = AudioPlayerBehavior(rawValue: audioPlayBehavior)!
                            switch behaviorCase {
                            case .singleLoop:
                                audioPlayBehavior = AudioPlayerBehavior.pauseWhenFinish.rawValue
                            case .pauseWhenFinish:
                                audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
                            case .listLoop:
                                audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
                            case .exitWhenFinish:
                                audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
                            }
                            RefreshPlayerBehavior(player: audioPlayer, playerItem: playerItem)
                        }, label: {
                            Image(systemName: { () -> String in
                                let behaviorCase = AudioPlayerBehavior(rawValue: audioPlayBehavior)!
                                switch behaviorCase {
                                case .singleLoop:
                                    return "repeat.1"
                                case .pauseWhenFinish:
                                    return "pause"
                                case .listLoop:
                                    return "repeat"
                                case .exitWhenFinish:
                                    return "rectangle.portrait.and.arrow.forward"
                                }
                            }())
                        })
                        Button(action: {
                            isPlaying.toggle()
                            if isPlaying {
                                audioPlayer.play()
                            } else {
                                audioPlayer.pause()
                            }
                        }, label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        })
                        .controlSize(.large)
                        VolumeControlView()
                            .controlSize(.regular)
                    }
                }
            } else {
                VStack {
                    AsyncImage(url: URL(string: videoDetails["Pic"]! + "@110w_85h"))
                        .cornerRadius(10)
                    Text(videoDetails["Title"]!)
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(1)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 20)
                    Text(videoDetails["Title"]!)
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(1)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 20)
                    Button(action: {
                        let behaviorCase = AudioPlayerBehavior(rawValue: audioPlayBehavior)!
                        switch behaviorCase {
                        case .singleLoop:
                            audioPlayBehavior = AudioPlayerBehavior.pauseWhenFinish.rawValue
                        case .pauseWhenFinish:
                            audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
                        case .listLoop:
                            audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
                        case .exitWhenFinish:
                            audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
                        }
                        RefreshPlayerBehavior(player: audioPlayer, playerItem: playerItem)
                    }, label: {
                        Image(systemName: { () -> String in
                            let behaviorCase = AudioPlayerBehavior(rawValue: audioPlayBehavior)!
                            switch behaviorCase {
                            case .singleLoop:
                                return "repeat.1"
                            case .pauseWhenFinish:
                                return "pause"
                            case .listLoop:
                                return "repeat"
                            case .exitWhenFinish:
                                return "rectangle.portrait.and.arrow.forward"
                            }
                        }())
                    })
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying {
                            audioPlayer.play()
                        } else {
                            audioPlayer.pause()
                        }
                    }, label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    })
                    VolumeControlView()
                }
            }
        }
        .onAppear {
            // Background Session
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error)
            }
            
            let asset = AVURLAsset(url: URL(string: VideoDetailView.willPlayVideoLink)!, options: [AVURLAssetHTTPUserAgentKey: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"])
            playerItem = AVPlayerItem(asset: asset)
            audioPlayer = AVPlayer(playerItem: playerItem)
            
            startObserver = playerItem.publisher(for: \.status)
                .sink { status in
                    if status == .readyToPlay {
                        audioPlayer.play()
                    }
                }
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                nowPlayTimeTimer = timer
                debugPrint(audioPlayer.currentTime().seconds)
            }
            
            RefreshPlayerBehavior(player: audioPlayer, playerItem: playerItem)
        }
        .onDisappear {
            startObserver?.cancel()
            finishObserver?.cancel()
            nowPlayTimeTimer?.invalidate()
        }
    }
    
    func RefreshPlayerBehavior(player: AVPlayer, playerItem: AVPlayerItem) {
        let behaviorCase = AudioPlayerBehavior(rawValue: audioPlayBehavior)!
        switch behaviorCase {
        case .singleLoop:
            finishObserver = NotificationCenter.default
                .publisher(for: .AVPlayerItemDidPlayToEndTime, object: playerItem)
                .sink { _ in
                    player.seek(to: CMTime.zero)
                    player.play()
                }
        case .pauseWhenFinish:
            finishObserver?.cancel()
        default:
            break
        }
    }
    
}

public enum AudioPlayerBehavior: String {
    case singleLoop = "singleLoop"
    case pauseWhenFinish = "pause"
    case listLoop = "listLoop"
    case exitWhenFinish = "exit"
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(videoDetails: ["Pic": "http://i1.hdslb.com/bfs/archive/453a7f8deacb98c3b083ead733291f080383723a.jpg", "Title": "解压视频：20000个小球Marble run动画", "BV": "BV1PP41137Px", "UP": "小球模拟", "View": "114514", "Danmaku": "1919810"], subTitles: [[:]])
    }
}
