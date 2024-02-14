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
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
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
import CachedAsyncImage

struct AudioPlayerView: View {
    var videoDetails: [String: String]
    @Binding var videoLink: String
    @Binding var videoBvid: String
    @Binding var videoCID: Int64
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
            VStack {
                AsyncImage(url: URL(string: videoDetails["Pic"]!)) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 10)
                            .redacted(reason: .placeholder)
                    case .success(let image):
                        image.resizable()
                    case .failure(let error):
                        RoundedRectangle(cornerRadius: 10)
                            .redacted(reason: .placeholder)
                    }
                }
                .cornerRadius(10)
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 40)
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
                .buttonStyle(.borderedProminent)
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
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            // Background Session
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .mixWithOthers, .allowBluetooth])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error)
            }
            
            let asset = AVURLAsset(url: URL(string: videoLink)!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
            playerItem = AVPlayerItem(asset: asset)
            audioPlayer = AVPlayer(playerItem: playerItem)
            
            let cover = UIImage(data: try! Data(contentsOf: URL(string: videoDetails["Pic"]!)!))!
            NowPlayingExtension.setPlayingInfoTitle(videoDetails["Title"]!, artist: videoDetails["UP"]!, artwork: cover)
            
            MPRemoteCommandCenter.shared().playCommand.addTarget { event in
                if !isPlaying {
                    isPlaying.toggle()
                    audioPlayer.play()
                }
                return .success
            }
            MPRemoteCommandCenter.shared().pauseCommand.addTarget { event in
                if isPlaying {
                    isPlaying.toggle()
                    audioPlayer.pause()
                }
                return .success
            }
            MPRemoteCommandCenter.shared().seekForwardCommand.addTarget { event in
                audioPlayer.seek(to: CMTime(seconds: audioPlayer.currentTime().seconds + 15, preferredTimescale: 1))
                return .success
            }
            MPRemoteCommandCenter.shared().seekBackwardCommand.addTarget { event in
                audioPlayer.seek(to: CMTime(seconds: audioPlayer.currentTime().seconds - 15, preferredTimescale: 1))
                return .success
            }
            
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
            
            MPRemoteCommandCenter.shared().playCommand.removeTarget(self)
            MPRemoteCommandCenter.shared().pauseCommand.removeTarget(self)
            MPRemoteCommandCenter.shared().seekForwardCommand.removeTarget(self)
            MPRemoteCommandCenter.shared().seekBackwardCommand.removeTarget(self)
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
