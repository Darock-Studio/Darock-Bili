//
//
//  AudioPlayerView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import AVKit
import Combine
import SwiftUI
import DarockKit
import Alamofire
import MediaPlayer
import AVFoundation
import SDWebImageSwiftUI

var pIsAudioPlayerPresented = false
var audioPlayerPlayItems = [AudioPlayItem]()
var audioPlayerNowPlayingItemIndex = 0
var audioPlayerMainPlayer = AVPlayer()
var audioPlayerMainCurrentItem: AVPlayerItem?

struct AudioPlayerView: View {
    @Binding var shouldPlayWhenEnter: Bool
    @AppStorage("AudioPlayBehavior") var audioPlayBehavior = AudioPlayerBehavior.singleLoop.rawValue
    @State var isPlaying = true
    @State var finishObserver: AnyCancellable?
    @State var startObserver: AnyCancellable?
    @State var backgroundPicOpacity = 0.0
    @State var nowPlayMediaTimer: Timer?
    @State var nowPlayingItemIndex = 0
    @State var isNoMedia = true
    var body: some View {
        VStack {
            #if os(watchOS)
            if #available(watchOS 10, *) {
                if !isNoMedia {
                    VStack {
                        WebImage(url: URL(string: audioPlayerPlayItems[nowPlayingItemIndex].videoDetails["Pic"]! + "@220w_170h"))
                            .resizable()
                            .cornerRadius(10)
                            .scaledToFit()
                            .frame(width: 110, height: 85)
                        Text(audioPlayerPlayItems[nowPlayingItemIndex].videoDetails["Title"]!)
                            .font(.system(size: 14, weight: .bold))
                            .lineLimit(1)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 20)
                    }
                    .containerBackground(for: .navigation) {
                        ZStack {
                            WebImage(url: URL(string: audioPlayerPlayItems[nowPlayingItemIndex].videoDetails["Pic"]!))
                                .resizable()
                                .onSuccess { _, _, _ in
                                    backgroundPicOpacity = 1.0
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
                                RefreshPlayerBehavior(player: audioPlayerMainPlayer, playerItem: audioPlayerMainCurrentItem)
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
                                    audioPlayerMainPlayer.play()
                                } else {
                                    audioPlayerMainPlayer.pause()
                                }
                            }, label: {
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            })
                            .controlSize(.large)
                            VolumeControlView()
                                .controlSize(.regular)
                        }
                    }
                }
            } else {
                
            }
            #endif
        }
        .onAppear {
            // Background Session
            do {
                #if !os(watchOS)
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .mixWithOthers, .allowBluetooth])
                #else
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                #endif
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error)
            }
            
            nowPlayMediaTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if audioPlayerNowPlayingItemIndex < audioPlayerPlayItems.count && audioPlayerNowPlayingItemIndex >= 0 {
                    isNoMedia = false
                } else {
                    isNoMedia = true
                }
            }
            
            if shouldPlayWhenEnter && audioPlayerNowPlayingItemIndex < audioPlayerPlayItems.count && audioPlayerNowPlayingItemIndex >= 0 {
                let asset = AVURLAsset(url: URL(string: audioPlayerPlayItems[audioPlayerNowPlayingItemIndex].videoLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
                audioPlayerMainCurrentItem = AVPlayerItem(asset: asset)
                audioPlayerMainPlayer = AVPlayer(playerItem: audioPlayerMainCurrentItem)
                
                if let cd = try? Data(contentsOf: URL(string: audioPlayerPlayItems[audioPlayerNowPlayingItemIndex].videoDetails["Pic"]!)!) {
                    let cover = UIImage(data: cd)!
                    NowPlayingExtension.setPlayingInfoTitle(audioPlayerPlayItems[audioPlayerNowPlayingItemIndex].videoDetails["Title"]!, artist: audioPlayerPlayItems[audioPlayerNowPlayingItemIndex].videoDetails["UP"]!, artwork: cover)
                } else {
                    NowPlayingExtension.setPlayingInfoTitle(audioPlayerPlayItems[audioPlayerNowPlayingItemIndex].videoDetails["Title"]!, artist: audioPlayerPlayItems[audioPlayerNowPlayingItemIndex].videoDetails["UP"]!, artwork: nil)
                }
                
                startObserver = audioPlayerMainCurrentItem?.publisher(for: \.status)
                    .sink { status in
                        if status == .readyToPlay {
                            audioPlayerMainPlayer.play()
                        }
                    }
            }
            
            RefreshPlayerBehavior(player: audioPlayerMainPlayer, playerItem: audioPlayerMainCurrentItem)
        }
        .onDisappear {
            nowPlayMediaTimer?.invalidate()
        }
    }
    
    func RefreshPlayerBehavior(player: AVPlayer, playerItem: AVPlayerItem?) {
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
