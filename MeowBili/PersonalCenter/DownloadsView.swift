//
//
//  DownloadsView.swift
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
import Marquee
import Alamofire
import AVFoundation
#if !os(visionOS)
import SDWebImageSwiftUI
#endif

struct DownloadsView: View {
    public static var willPlayVideoPath = ""
    @State var metadatas = [[String: String]]()
    @State var isPlayerPresented = false
    @State var vRootPath = ""
    var body: some View {
        List {
            #if os(watchOS)
            if #unavailable(watchOS 10) {
                NavigationLink(destination: { DownloadingListView() }, label: {
                    Label("Download.list", systemImage: "list.bullet.below.rectangle")
                })
            }
            #endif
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
                                #if !os(visionOS)
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
                                #else
                                AsyncImage(url: URL(string: metadatas[i]["Pic"]! + "@100w")!) { phase in
                                    switch phase {
                                    case .empty:
                                        RoundedRectangle(cornerRadius: 7)
                                            .frame(width: 50, height: 30)
                                            .foregroundColor(Color(hex: 0x3D3D3D))
                                            .redacted(reason: .placeholder)
                                    case .success(let image):
                                        image.resizable()
                                    case .failure(let error):
                                        RoundedRectangle(cornerRadius: 7)
                                            .frame(width: 50, height: 30)
                                            .foregroundColor(Color(hex: 0x3D3D3D))
                                            .redacted(reason: .placeholder)
                                    }
                                }
                                .scaledToFit()
                                .frame(width: 50)
                                .cornerRadius(7)
                                #endif
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
        .navigationTitle("离线缓存")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPlayerPresented, content: { OfflineVideoPlayer() })
        .toolbar {
            #if !os(watchOS)
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: { DownloadingListView() }, label: {
                    Image(systemName: "list.bullet.below.rectangle")
                })
            }
            #else
            if #available(watchOS 10, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: { DownloadingListView() }, label: {
                        Image(systemName: "list.bullet.below.rectangle")
                    })
                }
            }
            #endif
        }
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

struct DownloadingListView: View {
    @State var downloadProgresses = [Double]()
    @State var downloadedSizes = [Int64]()
    @State var totalSizes = [Int64]()
    @State var videoDetails = [[String: String]]()
    var body: some View {
        List {
            if downloadingProgressDatas.count != 0 && totalSizes.count != 0 {
                ForEach(0..<downloadingProgressDatas.count, id: \.self) { i in
                    if !failedDownloadTasks.contains(i) {
                        if !(downloadingProgressDatas[from: i]?.isFinished ?? false) && downloadProgresses[from: i] != 1.0 {
                            if let downloadProgress = downloadProgresses[from: i], let downloadSize = downloadedSizes[from: i], let totalSize = totalSizes[from: i] {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Download.num.\(i + 1)")
                                            .bold()
                                        Spacer()
                                    }
                                    Marquee {
                                        Text(videoDetails[i]["Title"] ?? "")
                                    }
                                    .marqueeDuration(10)
                                    .marqueeWhenNotFit(true)
                                    .marqueeIdleAlignment(.center)
                                    .frame(height: 18)
                                    ProgressView(value: downloadProgress * 100, total: 100.0)
                                    HStack {
                                        Spacer()
                                        Text("\(String(format: "%.2f", downloadProgress * 100) + " %")")
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        Text("\(String(format: "%.2f", Double(downloadSize) / 1024 / 1024))MB / \(String(format: "%.2f", Double(totalSize) / 1024 / 1024))MB")
                                            .font(.system(size: 16, weight: .bold))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                        Spacer()
                                    }
                                }
                                .swipeActions {
                                    Button(role: .destructive, action: {
                                        videoDownloadRequests[i].cancel()
                                    }, label: {
                                        Image(systemName: "xmark.circle.fill")
                                    })
                                }
                                .onReceive(downloadingProgressDatas[i].pts) { data in
                                    downloadProgresses[i] = data.data.progress
                                    downloadedSizes[i] = data.data.currentSize
                                    totalSizes[i] = data.data.totalSize
                                    videoDetails[i] = data.videoDetails
                                }
                            }
                        } else {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text("Download.finished.\(i + 1)")
                                    Spacer()
                                }
                                // TODO: VideoCard refer to DownloadsView item
                            }
                        }
                    } else {
                        Button(action: {
                            DispatchQueue(label: "com.darock.DarockBili.VideoDownload", qos: .background).async {
                                AF.download(resumingWith: UserDefaults.standard.data(forKey: "VideoDownloadResumeData\(i)") ?? Data())
                                    .downloadProgress { p in
                                        downloadingProgressDatas[i].pts.send(.init(data: .init(progress: p.fractionCompleted, currentSize: p.completedUnitCount, totalSize: p.totalUnitCount), videoDetails: downloadResumeDatas[i]!))
                                    }
                                    .response { r in
                                        if r.error == nil, let filePath = r.fileURL?.path {
                                            debugPrint(filePath)
                                            debugPrint(downloadResumeDatas[i]!["BV"] ?? "")
                                            var detTmp = downloadResumeDatas[i] ?? [:]
                                            detTmp.updateValue(filePath, forKey: "Path")
                                            detTmp.updateValue(String(Date.now.timeIntervalSince1970), forKey: "Time")
                                            UserDefaults.standard.set(detTmp, forKey: downloadResumeDatas[i]!["BV"]!)
                                            downloadingProgressDatas[i].isFinished = true
                                        } else {
                                            UserDefaults.standard.set(r.resumeData, forKey: "VideoDownloadResumeData\(i)")
                                            failedDownloadTasks.append(i)
                                            debugPrint(r.error as Any)
                                        }
                                    }
                            }
                        }, label: {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("Download.paused.\(i + 1)")
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("Download.tap-2-retry")
                                        .font(.footnote)
                                        .opacity(0.65)
                                    Spacer()
                                }
                            }
                        })
                    }
                }
            } else {
                Text("Download.nothing")
            }
        }
        .navigationTitle("Download.list")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            downloadProgresses = Array(repeating: 0.0, count: downloadingProgressDatas.count)
            downloadedSizes = Array(repeating: 0, count: downloadingProgressDatas.count)
            totalSizes = Array(repeating: 0, count: downloadingProgressDatas.count)
            videoDetails = Array(repeating: [:], count: downloadingProgressDatas.count)
        }
    }
}

struct OfflineVideoPlayer: View {
    var path: String?
    @State var tabviewChoseTab = 1
    @State var isFullScreen = false
    @State var player: AVPlayer!
    var body: some View {
        #if os(watchOS)
        TabView(selection: $tabviewChoseTab) {
            VideoPlayer(player: player)
                .rotationEffect(.degrees(isFullScreen ? 90 : 0))
                .frame(width: isFullScreen ? WKInterfaceDevice.current().screenBounds.height : nil, height: isFullScreen ? WKInterfaceDevice.current().screenBounds.width : nil)
                .offset(y: isFullScreen ? 20 : 0)
                .ignoresSafeArea()
                .tag(1)
            List {
                Section {
                    Button(action: {
                        isFullScreen.toggle()
                        tabviewChoseTab = 1
                    }, label: {
                        if isFullScreen {
                            Label("恢复", systemImage: "arrow.down.forward.and.arrow.up.backward")
                        } else {
                            Label("全屏", systemImage: "arrow.down.backward.and.arrow.up.forward")
                        }
                    })
                } header: {
                    Text("画面")
                }
            }
            .tag(2)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
        .onAppear {
            let asset = AVAsset(url: URL(fileURLWithPath: path == nil ? DownloadsView.willPlayVideoPath : path!))
            let item = AVPlayerItem(asset: asset)
            player = AVPlayer(playerItem: item)
        }
        #else
        VideoPlayer(player: player)
            .onAppear {
                let asset = AVAsset(url: URL(fileURLWithPath: path == nil ? DownloadsView.willPlayVideoPath : path!))
                let item = AVPlayerItem(asset: asset)
                player = AVPlayer(playerItem: item)
            }
        #endif
    }
}

struct DownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadsView()
    }
}
