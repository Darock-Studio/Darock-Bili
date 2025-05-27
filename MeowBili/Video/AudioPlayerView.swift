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

import Combine
import SwiftUI
import Dynamic
import DarockUI
import Alamofire
import MediaPlayer
import AVFoundation
import DarockFoundation
import SDWebImageSwiftUI

let globalAudioPlayer = AVPlayer()
var globalAudioLooper: Any?
var nowPlayingVideoId = ""

#if os(watchOS)
struct AudioControllerView: View {
  @AppStorage("DedeUserID") var dedeUserID = ""
  @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
  @AppStorage("SESSDATA") var sessdata = ""
  @AppStorage("bili_jct") var biliJct = ""
  @Namespace var coverScaleNamespace
  @State var currentPlaybackTime = globalAudioPlayer.currentTime().seconds
  @State var currentItemTotalTime = 0.0
  @State var currentScrolledId = 0.0
  @State var isPlaying = false
  @State var isProgressDraging = false
  @State var progressDragingNewTime = 0.0
  @State var playbackBehavior = PlaybackBehavior.pause
  @State var backgroundImageUrl: URL?
  @State var videoName = ""
  @State var backwardTaps = 0
  @State var backwardTapsSnapshot = 0
  @State var forwardTaps = 0 //双击屏幕右侧的点击计数器
  @State var forwardTapsSnapshop = 0
  @State var forwardTimer: Timer?
  @State var backwardTimer: Timer?
  var body: some View {
    NavigationStack {
      ZStack {
        HStack {
          Rectangle()
            .frame(width: 45)
            .opacity(minimumOpacity)
            .onTapGesture(perform: {
              if currentPlaybackTime - 10 > 0 {
                forwardTaps = 0
                backwardTaps += 1
                backwardTapsSnapshot = backwardTaps
                if backwardTaps > 1 {
                  globalAudioPlayer.seek(to: CMTime(seconds: currentPlaybackTime - 10, preferredTimescale: 60000),
                                         toleranceBefore: .zero,
                                         toleranceAfter: .zero)
                }
              }
            })
          Spacer()
          Rectangle()
            .frame(width: 45)
            .opacity(minimumOpacity)
            .onTapGesture(perform: {
              if currentPlaybackTime + 10 < currentItemTotalTime {
                backwardTaps = 0
                forwardTaps += 1
                forwardTapsSnapshop = forwardTaps
                if forwardTaps > 1 {
                  globalAudioPlayer.seek(to: CMTime(seconds: currentPlaybackTime + 10, preferredTimescale: 60000),
                                         toleranceBefore: .zero,
                                         toleranceAfter: .zero)
                }
              }
            })
        }
        .ignoresSafeArea(.container)
        .frame(height: 120)
        .offset(y: -20)
        .onChange(of: forwardTaps, perform: { value in
          if forwardTaps != 0 {
            forwardTimer?.invalidate()
            forwardTimer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { value in
              if forwardTapsSnapshop == forwardTaps {
                print("[\(currentGlobalSystemTime())][HKR][L] S\(forwardTapsSnapshop), T\(forwardTaps)")
                forwardTaps = 0
              }
              forwardTapsSnapshop = forwardTaps
            }
          }
        })
        .onChange(of: backwardTaps, perform: { value in
          if backwardTaps != 0 {
            backwardTimer?.invalidate()
            backwardTimer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { _ in
                //            if forwardTapsSnapshop == forwardTaps {
                //              forwardTaps = 0
                //            }
              if backwardTapsSnapshot == backwardTaps {
                print("[\(currentGlobalSystemTime())][HKR][R] S\(backwardTapsSnapshot), T\(backwardTaps)")
                backwardTaps = 0
              }
                //            forwardTapsSnapshop = forwardTaps
              
            }
          }
        })
        /*
         {
          Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { _ in
            if forwardTapsSnapshop == forwardTaps {
              forwardTaps = 0
            }
            if backwardTapsSnapshot == backwardTaps {
              backwardTaps = 0
            }
            forwardTapsSnapshop = forwardTaps
            backwardTapsSnapshot = backwardTaps
          }
        }
         */
        Group {
          if let backgroundImageUrl {
            WebImage(url: backgroundImageUrl, options: [.progressiveLoad, .scaleDownLargeImages])
              .placeholder {
                RoundedRectangle(cornerRadius: 14)
                  .frame(width: 120, height: 80)
                  .foregroundColor(Color(hex: 0x3D3D3D))
                  .redacted(reason: .placeholder)
              }
              .resizable()
              .cornerRadius(10)
              .scaledToFit()
              .frame(width: 120, height: 80)
              .shadow(color: .black.opacity(0.5), radius: 5, x: 1, y: 2)
              .offset(y: -24)
          } else {
            RoundedRectangle(cornerRadius: 14)
              .frame(width: 120, height: 80)
              .foregroundColor(Color(hex: 0x3D3D3D))
              .redacted(reason: .placeholder)
              .offset(y: -24)
          }
        }
        
          // Audio Controls
        VStack {
          Spacer()
          VStack {
            VStack {
              ProgressView(value: isProgressDraging ? progressDragingNewTime : currentPlaybackTime, total: currentItemTotalTime)
                .progressViewStyle(.linear)
                .shadow(radius: isProgressDraging ? 2 : 0)
                .gesture(
                  DragGesture()
                    .onChanged { value in
                      isProgressDraging = true
                      let newTime = currentPlaybackTime + value.translation.width
                      if newTime >= 0 && newTime <= currentItemTotalTime {
                        progressDragingNewTime = newTime
                      }
                    }
                    .onEnded { _ in
                      globalAudioPlayer.seek(to: CMTime(seconds: progressDragingNewTime, preferredTimescale: 60000),
                                             toleranceBefore: .zero,
                                             toleranceAfter: .zero)
                      isProgressDraging = false
                    }
                )
                .frame(height: 20)
              HStack {
                Text(formattedTime(from: currentPlaybackTime))
                  .font(.system(size: 11))
                  .opacity(0.6)
                Spacer()
                Text(formattedTime(from: currentItemTotalTime))
                  .font(.system(size: 11))
                  .opacity(0.6)
              }
              .padding(.vertical, -8)
            }
            .scaleEffect(isProgressDraging ? 1.05 : 1)
            .padding(.horizontal, 5)
            .animation(.easeOut(duration: 0.2), value: isProgressDraging)
            HStack {
              Button(action: {
                switch playbackBehavior {
                  case .pause:
                    playbackBehavior = .singleLoop
                  case .singleLoop:
                    playbackBehavior = .pause
                }
                UserDefaults.standard.set(playbackBehavior.rawValue, forKey: "MPPlaybackBehavior")
              }, label: {
                Group {
                  switch playbackBehavior {
                    case .pause:
                      Image(systemName: "pause.circle")
                    case .singleLoop:
                      Image(systemName: "repeat.1")
                  }
                }
                .font(.system(size: 20))
              })
              .buttonStyle(ControlButtonStyle())
              .frame(width: 35, height: 35)
              Spacer()
              Button(action: {
                if isPlaying {
                  globalAudioPlayer.pause()
                } else {
                  if currentItemTotalTime == currentPlaybackTime {
                    globalAudioPlayer.seek(to: CMTime(seconds: 0, preferredTimescale: 60000),
                                           toleranceBefore: .zero,
                                           toleranceAfter: .zero)
                  }
                  globalAudioPlayer.play()
                }
              }, label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                  .font(.system(size: 26))
              })
              .buttonStyle(ControlButtonStyle())
              .frame(width: 40, height: 40)
              Spacer()
              VolumeControlView()
                .scaleEffect(0.7)
                .frame(width: 35, height: 35)
            }
            .padding(.horizontal, 5)
          }
          .background {
            if #available(watchOS 10, *) {
              Color.clear.background(Material.ultraThin)
                .opacity(0.8)
                .brightness(0.1)
                .saturation(2.5)
                .frame(width: WKInterfaceDevice.current().screenBounds.width + 100, height: 100)
                .blur(radius: 10)
                .offset(y: 20)
            }
          }
        }
        .ignoresSafeArea()
      }
      .navigationTitle(backwardTaps > 1 ? (Text("快退 \(10*(backwardTaps-1))s")) : (forwardTaps > 1 ? Text("快进 \(10*(forwardTaps-1))s") : Text(videoName)))
      .modifier(BlurBackground(imageUrl: backgroundImageUrl))
    }
    .onAppear {
      isPlaying = globalAudioPlayer.timeControlStatus == .playing
      currentItemTotalTime = globalAudioPlayer.currentItem?.duration.seconds ?? 0.0
      updateMetadata()
      playbackBehavior = .init(rawValue: UserDefaults.standard.string(forKey: "MPPlaybackBehavior") ?? "pause") ?? .pause
      resetGlobalAudioLooper()
      pIsAudioControllerAvailable = true
      Dynamic.PUICApplication.sharedPUICApplication().setExtendedIdleTime(1600.0, disablesSleepGesture: true, wantsAutorotation: false)
    }
    .onDisappear {
      Dynamic.PUICApplication.sharedPUICApplication().extendedIdleTime = 0.0
      Dynamic.PUICApplication.sharedPUICApplication().disablesSleepGesture = false
    }
    .onReceive(globalAudioPlayer.publisher(for: \.timeControlStatus)) { status in
      isPlaying = status == .playing
      if status != .waitingToPlayAtSpecifiedRate {
        currentItemTotalTime = globalAudioPlayer.currentItem?.duration.seconds ?? 0.0
        debugPrint(currentItemTotalTime)
      }
    }
    .onReceive(globalAudioPlayer.publisher(for: \.currentItem)) { item in
      if let item {
        currentItemTotalTime = item.duration.seconds
        updateMetadata()
      }
    }
    .onReceive(globalAudioPlayer.periodicTimePublisher()) { time in
        // Code in this closure runs at nearly each frame, optimizing for speed is important.
      if time.seconds - currentPlaybackTime >= 0.3 || time.seconds < currentPlaybackTime {
        currentPlaybackTime = time.seconds
      }
    }
  }
  
  func updateMetadata() {
    if !nowPlayingVideoId.isEmpty {
      let headers: HTTPHeaders = [
        "cookie": "SESSDATA=\(sessdata)",
        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
      ]
      requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(nowPlayingVideoId)", headers: headers) { respJson, isSuccess in
        if isSuccess {
          debugPrint(respJson)
          backgroundImageUrl = URL(string: respJson["data"]["pic"].string ?? "")
          videoName = respJson["data"]["title"].string ?? "[加载失败]"
        }
      }
    }
  }
  
  struct ControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      ZStack {
        Circle()
          .fill(Color.gray)
          .scaleEffect(configuration.isPressed ? 0.9 : 1)
          .opacity(configuration.isPressed ? 0.4 : minimumOpacity)
        configuration.label
          .scaleEffect(configuration.isPressed ? 0.9 : 1)
      }
    }
  }
}

struct AudioVisualizerView: View {
  @State private var drawingHeight = true
  @State var isAudioPlaying = globalAudioPlayer.timeControlStatus == .playing
  var animation: Animation {
    return .linear(duration: 0.5).repeatForever()
  }
  var body: some View {
    Group {
      if isAudioPlaying {
        HStack {
          bar(low: 0.4)
            .animation(animation.speed(1.8), value: drawingHeight)
          bar(low: 0.3)
            .animation(animation.speed(2.4), value: drawingHeight)
          bar(low: 0.5)
            .animation(animation.speed(2.0), value: drawingHeight)
          bar(low: 0.3)
            .animation(animation.speed(3.0), value: drawingHeight)
          bar(low: 0.5)
            .animation(animation.speed(2.0), value: drawingHeight)
        }
        .frame(width: 22)
        .onAppear {
          drawingHeight.toggle()
        }
      } else {
        HStack {
          bar(low: 0.2, high: 0.2)
          bar(low: 0.2, high: 0.2)
          bar(low: 0.2, high: 0.2)
          bar(low: 0.2, high: 0.2)
          bar(low: 0.2, high: 0.2)
        }
        .frame(width: 22)
      }
    }
    .onReceive(globalAudioPlayer.publisher(for: \.timeControlStatus)) { status in
      isAudioPlaying = status == .playing
    }
  }
  
  func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
    RoundedRectangle(cornerRadius: 3)
      .fill(Color.white)
      .frame(height: (drawingHeight ? high : low) * 18)
      .frame(height: 18)
      .padding(.horizontal, -1.5)
  }
}

func formattedTime(from seconds: Double) -> String {
  if seconds.isNaN {
    return "00:00"
  }
  let minutes = Int(seconds) / 60
  let remainingSeconds = Int(seconds) % 60
  return String(format: "%02d:%02d", minutes, remainingSeconds)
}
func setForAudioPlaying() {
  do {
    try AVAudioSession.sharedInstance().setCategory(
      AVAudioSession.Category.playback,
      mode: .default,
      policy: UserDefaults.standard.bool(forKey: "MPBackgroundPlay") ? .longFormAudio : .default
    )
    AVAudioSession.sharedInstance().activate { _, _ in }
  } catch {
    print(error)
  }
  let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
  var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
  let title = String(localized: "喵哩喵哩 - 音频播放")
  nowPlayingInfo[MPMediaItemPropertyTitle] = title
  nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
}
func playAudio(url: String, id: String = "", presentController: Bool = true) {
  nowPlayingVideoId = id
  globalAudioPlayer.replaceCurrentItem(
    with: AVPlayerItem(
      asset: AVURLAsset(url: URL(
        string: url
          .replacingOccurrences(of: "%DownloadedContent@=",
                                with: "file://\(NSHomeDirectory())/Documents/DownloadedAudios/")
      )!, options: ["AVURLAssetHTTPHeaderFieldsKey": ["User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15", "Referer": "https://www.bilibili.com"]])
    )
  )
  resetGlobalAudioLooper()
  if presentController {
    pShouldPresentAudioController = true
  }
  globalAudioPlayer.play()
}
func resetGlobalAudioLooper() {
  if let currentLooper = globalAudioLooper {
    NotificationCenter.default.removeObserver(currentLooper)
    globalAudioLooper = nil
  }
  globalAudioLooper = NotificationCenter.default.addObserver(
    forName: AVPlayerItem.didPlayToEndTimeNotification,
    object: globalAudioPlayer.currentItem,
    queue: .main) { _ in
      let playbackBehavior = PlaybackBehavior.init(rawValue: UserDefaults.standard.string(forKey: "MPPlaybackBehavior") ?? "pause") ?? .pause
      if playbackBehavior == .singleLoop {
        globalAudioPlayer.seek(to: .zero)
        globalAudioPlayer.play()
      }
    }
}

enum PlaybackBehavior: String {
  case pause
  case singleLoop
}
#endif
