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
import Dynamic
import Alamofire
import MarqueeText
import AVFoundation
import SDWebImageSwiftUI

struct DownloadsView: View {
    public static var willPlayVideoPath = ""
    @State var metadatas = [[String: String]]()
    @State var isPlayerPresented = false
    @State var vRootPath = ""
    @State var searchInput = ""
    var body: some View {
        List {
            Section {
                if !metadatas.isEmpty {
                    ForEach(0..<metadatas.count, id: \.self) { i in
                        if metadatas[i]["notGet"] == nil {
                            if searchInput.isEmpty || metadatas[i]["Title"]!.contains(searchInput) {
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
                                            HStack {
                                                Image(systemName: "person")
                                                Text(metadatas[i]["UP"]!)
                                                    .offset(x: -3)
                                                Spacer()
                                            }
                                            .lineLimit(1)
                                            .font(.system(size: 11))
                                            .opacity(0.6)
                                        }
                                    }
                                })
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive, action: {
                                        try! FileManager.default.removeItem(atPath: vRootPath + metadatas[i]["Path"]!)
                                        metadatas.remove(at: i)
                                    }, label: {
                                        Image(systemName: "xmark.bin.fill")
                                    })
                                    #if os(watchOS)
                                    Button(action: {
                                        playAudio(url: URL(filePath: vRootPath + metadatas[i]["Path"]!).absoluteString)
                                    }, label: {
                                        Image(systemName: "music.note")
                                    })
                                    #endif
                                }
                            }
                        } else {
                            
                        }
                    }
                }
            }
        }
        .navigationTitle("离线缓存")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPlayerPresented, content: { OfflineVideoPlayer() })
        .searchable(text: $searchInput)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: { DownloadingListView() }, label: {
                    Image(systemName: "list.bullet.below.rectangle")
                })
            }
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
                        if nameWithOutSuffix.count > 12 {
                            dicV.updateValue("true", forKey: "IsParted")
                        } else {
                            dicV.updateValue("false", forKey: "IsParted")
                        }
                        metadatas.append(dicV)
                    } else {
                        metadatas.append(["notGet": "true"])
                    }
                }
            }
            metadatas.sort { Double($0["Time"] ?? "0.0")! > Double($1["Time"] ?? "0.0")! }
        }
    }
}

struct DownloadingListView: View {
    @State var downloadProgresses = [Double]()
    @State var downloadedSizes = [Int64]()
    @State var totalSizes = [Int64]()
    @State var localFailedDownloadTasks = Set<Int>()
    @State var localVariableUpdateTimer: Timer?
    @State var isRefreshing = false
    var body: some View {
        List {
            if !videoDownloadRequests.isEmpty && !isRefreshing {
                ForEach(0..<videoDownloadRequests.count, id: \.self) { i in
                    if !localFailedDownloadTasks.contains(videoDownloadRequests[i].taskIdentifier) {
                        if downloadProgresses[from: i] != 1.0 {
                            if let downloadProgress = downloadProgresses[from: i], let downloadSize = downloadedSizes[from: i], let totalSize = totalSizes[from: i] {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Download.num.\(i + 1)")
                                            .bold()
                                        Spacer()
                                    }
                                    MarqueeText(text: videoDownloadDetails[videoDownloadRequests[i].taskIdentifier]?["Title"] ?? "", font: .systemFont(ofSize: 17), leftFade: 5, rightFade: 5, startDelay: 1.5)
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
                                .onReceive(videoDownloadRequests[i].progress.publisher(for: \.completedUnitCount)) { _ in
                                    downloadProgresses[i] = videoDownloadRequests[i].progress.fractionCompleted
                                    downloadedSizes[i] = videoDownloadRequests[i].progress.completedUnitCount
                                    totalSizes[i] = videoDownloadRequests[i].progress.totalUnitCount
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
                            if let resumeData = try? Data(contentsOf: URL(filePath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(videoDownloadRequests[i].taskIdentifier).drkdatav")) {
                                let task = videoDownloadSession.downloadTask(withResumeData: resumeData)
                                if let sourceDetails = videoDownloadDetails[videoDownloadRequests[i].taskIdentifier] {
                                    videoDownloadDetails.removeValue(forKey: videoDownloadRequests[i].taskIdentifier)
                                    videoDownloadDetails.updateValue(sourceDetails, forKey: task.taskIdentifier)
                                }
                                task.resume()
                                videoDownloadNeedsResumeIdentifiers.remove(videoDownloadRequests[i].taskIdentifier)
                                videoDownloadRequests[i] = task
                                isRefreshing = true
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
                    .onAppear {
                        isRefreshing = false
                    }
            }
        }
        .navigationTitle("Download.list")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            downloadProgresses = Array(repeating: 0.0, count: videoDownloadRequests.count)
            downloadedSizes = Array(repeating: 0, count: videoDownloadRequests.count)
            totalSizes = Array(repeating: 0, count: videoDownloadRequests.count)
#if os(watchOS)
            Dynamic.PUICApplication.sharedPUICApplication().setExtendedIdleTime(3600.0, disablesSleepGesture: true, wantsAutorotation: false)
#endif
            localVariableUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                localFailedDownloadTasks = videoDownloadNeedsResumeIdentifiers
            }
        }
        .onDisappear {
#if os(watchOS)
            Dynamic.PUICApplication.sharedPUICApplication().extendedIdleTime = 0.0
            Dynamic.PUICApplication.sharedPUICApplication().disablesSleepGesture = false
#endif
            localVariableUpdateTimer?.invalidate()
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
                ._statusBarHidden(true)
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
        .toolbar(.hidden, for: .navigationBar)
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
