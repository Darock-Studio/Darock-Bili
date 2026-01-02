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

var downloadingProgressDataList = [(pts: PassthroughSubject<DownloadTaskDetailData, Never>, isFinished: Bool)]()
var failedDownloadTasks = [Int]()
var downloadResumeDatas = [Int: [String: String]]()
var videoDownloadRequests = [DownloadRequest]()

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
                                    DownloadsView.willPlayVideoPath = vRootPath + "/" + metadatas[i]["Path"]!
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
                                        let filePath = vRootPath + metadatas[i]["Path"]!
                                        let bvidKey = metadatas[i]["BV"] ?? ""
                                        
                                        DispatchQueue.global(qos: .userInitiated).async {
                                            do {
                                                // 检查文件是否存在
                                                if FileManager.default.fileExists(atPath: filePath) {
                                                    try FileManager.default.removeItem(atPath: filePath)
                                                }
                                                
                                                // 删除 UserDefaults 中的元数据
                                                if !bvidKey.isEmpty {
                                                    UserDefaults.standard.removeObject(forKey: bvidKey)
                                                }
                                                
                                                DispatchQueue.main.async {
                                                    metadatas.remove(at: i)
                                                }
                                            } catch {
                                                debugPrint("删除文件失败: \(error.localizedDescription)")
                                                DispatchQueue.main.async {
                                                    tipWithText("删除失败", symbol: "xmark.circle.fill")
                                                }
                                            }
                                        }
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
    @State var videoDetails = [[String: String]]()
    @State var localFailedDownloadTasks = [Int]()
    @State var localVariableUpdateTimer: Timer?
    var body: some View {
        List {
            if downloadingProgressDataList.count != 0 && totalSizes.count != 0 {
                ForEach(0..<downloadingProgressDataList.count, id: \.self) { i in
                    if !localFailedDownloadTasks.contains(i) {
                        if !(downloadingProgressDataList[from: i]?.isFinished ?? false) && downloadProgresses[from: i] != 1.0 {
                            if let downloadProgress = downloadProgresses[from: i], let downloadSize = downloadedSizes[from: i], let totalSize = totalSizes[from: i] {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Download.num.\(i + 1)")
                                            .bold()
                                        Spacer()
                                    }
                                    MarqueeText(text: videoDetails[i]["Title"] ?? "", font: .systemFont(ofSize: 17), leftFade: 5, rightFade: 5, startDelay: 1.5)
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
                                .onReceive(downloadingProgressDataList[i].pts) { data in
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
                                if let resumeData = try? Data(contentsOf: URL(filePath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(i).drkdatav")) {
                                    failedDownloadTasks.remove(at: i)
                                    AF.download(resumingWith: resumeData)
                                        .downloadProgress { p in
                                            downloadingProgressDataList[i].pts.send(.init(data: .init(progress: p.fractionCompleted, currentSize: p.completedUnitCount, totalSize: p.totalUnitCount), videoDetails: downloadResumeDatas[i]!))
                                        }
                                        .response { r in
                                            if r.error == nil, let filePath = r.fileURL?.path {
                                                debugPrint(filePath)
                                                debugPrint(downloadResumeDatas[i]!["BV"] ?? "")
                                                var detTmp = downloadResumeDatas[i] ?? [:]
                                                detTmp.updateValue(filePath, forKey: "Path")
                                                detTmp.updateValue(String(Date.now.timeIntervalSince1970), forKey: "Time")
                                                let setKey = detTmp["SetKey"] ?? downloadResumeDatas[i]!["BV"]!
                                                detTmp.removeValue(forKey: "SetKey")
                                                UserDefaults.standard.set(detTmp, forKey: setKey)
                                                downloadingProgressDataList[i].isFinished = true
                                            } else {
                                                if FileManager.default.fileExists(atPath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(i).drkdatav") {
                                                    try? FileManager.default.removeItem(atPath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(i).drkdatav")
                                                }
                                                try? r.resumeData?.write(to: URL(filePath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(i).drkdatav"))
                                                failedDownloadTasks.append(i)
                                                debugPrint(r.error as Any)
                                            }
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
            downloadProgresses = Array(repeating: 0.0, count: downloadingProgressDataList.count)
            downloadedSizes = Array(repeating: 0, count: downloadingProgressDataList.count)
            totalSizes = Array(repeating: 0, count: downloadingProgressDataList.count)
            videoDetails = Array(repeating: [:], count: downloadingProgressDataList.count)
#if os(watchOS)
            Dynamic.PUICApplication.sharedPUICApplication().setExtendedIdleTime(3600.0, disablesSleepGesture: true, wantsAutorotation: false)
#endif
            localVariableUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                localFailedDownloadTasks = failedDownloadTasks
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
