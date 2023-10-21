//
//  DownloadsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
//

import AVKit
import SwiftUI
import AVFoundation

struct DownloadsView: View {
    public static var willPlayVideoPath = ""
    @State var metadatas = [[String: String]]()
    @State var isPlayerPresented = false
    var body: some View {
        List {
            if metadatas.count != 0 {
                ForEach(0...metadatas.count - 1, id: \.self) { i in
                    if metadatas[i]["notGet"] == nil {
//                        NavigationLink(destination: {VideoDetailView(videoDetails: metadatas[i])}, label: {
//                            HStack {
//                                AsyncImage(url: URL(string: metadatas[i]["Pic"]! + "@40w_30h"))
//                                    .cornerRadius(5)
//                                VStack {
//                                    Text(metadatas[i]["Title"]!)
//                                        .font(.system(size: 15, weight: .bold))
//                                        .lineLimit(3)
//                                    HStack {
//                                        Label(metadatas[i]["View"]!, systemImage: "play.circle")
//                                        Label(metadatas[i]["UP"]!, systemImage: "person")
//                                    }
//                                    .font(.system(size: 11))
//                                    .foregroundColor(.gray)
//                                    .lineLimit(1)
//                                }
//                            }
//                        })
                        Button(action: {
                            DownloadsView.willPlayVideoPath = metadatas[i]["Path"]!
                            isPlayerPresented = true
                        }, label: {
                            HStack {
                                AsyncImage(url: URL(string: metadatas[i]["Pic"]! + "@40w"))
                                    .cornerRadius(5)
                                VStack {
                                    Text(metadatas[i]["Title"]!)
                                        .font(.system(size: 14, weight: .bold))
                                        .lineLimit(3)
                                    Label(metadatas[i]["UP"]!, systemImage: "person")
                                        .font(.system(size: 11))
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                            }
                        })
                        .sheet(isPresented: $isPlayerPresented, content: {OfflineVideoPlayer()})
                    } else {
                        
                    }
                }
            }
        }
        .onAppear {
            let files = AppFileManager(path: "dlds").GetRoot() ?? [[String: String]]()
            for file in files {
                debugPrint(file)
                if !Bool(file["isDirectory"]!)! {
                    let name = file["name"]!
                    let nameWithOutSuffix = String(name.split(separator: ".")[0])
                    if UserDefaults.standard.dictionary(forKey: nameWithOutSuffix) != nil {
                        metadatas.append(UserDefaults.standard.dictionary(forKey: nameWithOutSuffix)! as! [String: String])
                    } else {
                        metadatas.append(["notGet": "true"])
                    }
                }
            }
        }
    }
}

struct OfflineVideoPlayer: View {
    var path: String? = nil
    @State var timeUpdateTimer: Timer?
    var body: some View {
        let asset = AVAsset(url: URL(fileURLWithPath: path == nil ? DownloadsView.willPlayVideoPath : path!))
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        VStack {
            VideoPlayer(player: player)
                .ignoresSafeArea()
        }
        .onAppear {
            hideDigitalTime(true)
            debugPrint(DownloadsView.willPlayVideoPath)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                timeUpdateTimer = timer
                debugPrint(player.currentTime().seconds)
            }
        }
        .onDisappear {
            hideDigitalTime(false)
            timeUpdateTimer?.invalidate()
        }
    }
}

struct DownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadsView()
    }
}
