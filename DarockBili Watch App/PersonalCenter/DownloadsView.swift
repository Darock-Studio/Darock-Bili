//
//  DownloadsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
//

import AVKit
import SwiftUI
import AVFoundation
import SDWebImageSwiftUI

struct DownloadsView: View {
    public static var willPlayVideoPath = ""
    @State var metadatas = [[String: String]]()
    @State var isPlayerPresented = false
    @State var vRootPath = ""
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
                            DownloadsView.willPlayVideoPath = vRootPath + metadatas[i]["Path"]!
                            isPlayerPresented = true
                        }, label: {
                            HStack {
                                WebImage(url: URL(string: metadatas[i]["Pic"]! + "@100w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                                    .placeholder {
                                        RoundedRectangle(cornerRadius: 7)
                                            .frame(width: 50, height: 30)
                                            .foregroundColor(Color(hex: 0x3D3D3D))
                                            .redacted(reason: .placeholder)
                                    }
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .cornerRadius(7)
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
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive, action: {
                                try! FileManager.default.removeItem(atPath: vRootPath + metadatas[i]["Path"]!)
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                            })
                        }
                    } else {
                        
                    }
                }
            }
        }
        .sheet(isPresented: $isPlayerPresented, content: {OfflineVideoPlayer()})
        .onAppear {
            vRootPath = String(AppFileManager(path: "dlds").GetPath("").path)
            metadatas.removeAll()
            let files = AppFileManager(path: "dlds").GetRoot() ?? [[String: String]]()
            for file in files {
                debugPrint(file)
                if !Bool(file["isDirectory"]!)! {
                    let name = file["name"]!
                    let nameWithOutSuffix = String(name.split(separator: ".")[0])
                    if UserDefaults.standard.dictionary(forKey: nameWithOutSuffix) != nil {
                        var dicV = UserDefaults.standard.dictionary(forKey: nameWithOutSuffix)! as! [String: String]
                        if let p = dicV["Path"] {
                            if p.contains("/") {
                                dicV.updateValue(String(p.split(separator: "/").last!), forKey: "Path")
                            }
                        }
                        metadatas.append(dicV)
                    } else {
                        metadatas.append(["notGet": "true"])
                    }
                }
            }
            metadatas.sort { Int($0["Date"] ?? "0")! < Int($1["Date"] ?? "0")! }
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
