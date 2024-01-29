//
//  VideoDownloadView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
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

import SwiftUI
import DarockKit
import Alamofire

var failedDownloadTasks = [Int]()
var downloadResumeDatas = [Int: [String: String]]()

struct VideoDownloadView: View {
    var bvid: String
    var videoDetails: [String: String]
    public static var downloadLink: String? = nil
    @Environment(\.dismiss) var dismiss
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLoading = true
    var body: some View {
        List {
            if isLoading {
                Text("Download.preloading...")
                    .bold()
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Label("Download.task-created", systemImage: "checkmark.circle.fill")
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Download.closing-in-3sec")
                            .font(.footnote)
                            .opacity(0.65)
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                                    dismiss()
                                }
                            }
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue(label: "com.darock.DarockBili.VideoDownload", qos: .background).async {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(bvid)").response { response in
                    let cid = Int64((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                    VideoDetailView.willPlayVideoCID = cid
                    AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(bvid)&cid=\(cid)", headers: headers).response { response in
                        let headers: HTTPHeaders = [
                            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                            "accept-encoding": "gzip, deflate, br",
                            "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
                            "cookie": "",
                            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.30 Safari/537.36 Edg/84.0.522.11",
                            "sec-fetch-dest": "document",
                            "sec-fetch-mode": "navigate",
                            "sec-fetch-site": "none",
                            "sec-fetch-user": "?1",
                            "upgrade-insecure-requests": "1",
                            "referer": "https://www.bilibili.com/"
                        ]
                        let destination: DownloadRequest.Destination = { _, _ in
                            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            let fileURL = documentsURL.appendingPathComponent("dlds/\(bvid).mp4")
                            
                            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                        }
                        isLoading = false
                        downloadingProgressDatas.append((.init(), false))
                        let currentDownloadingIndex = downloadingProgressDatas.count - 1
                        AF.download((VideoDownloadView.downloadLink ?? (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")), headers: headers, to: destination)
                            .downloadProgress { p in
                                downloadingProgressDatas[currentDownloadingIndex].pts.send(.init(data: .init(progress: p.fractionCompleted, currentSize: p.completedUnitCount, totalSize: p.totalUnitCount), videoDetails: videoDetails))
                            }
                            .response { r in
                                if r.error == nil, let filePath = r.fileURL?.path {
                                    debugPrint(filePath)
                                    debugPrint(bvid)
                                    var detTmp = videoDetails
                                    detTmp.updateValue(filePath, forKey: "Path")
                                    detTmp.updateValue(String(Date.now.timeIntervalSince1970), forKey: "Time")
                                    UserDefaults.standard.set(detTmp, forKey: bvid)
                                    downloadingProgressDatas[currentDownloadingIndex].isFinished = true
                                } else {
                                    UserDefaults.standard.set(r.resumeData, forKey: "VideoDownloadResumeData\(currentDownloadingIndex)")
                                    downloadResumeDatas.updateValue(videoDetails, forKey: currentDownloadingIndex)
                                    failedDownloadTasks.append(currentDownloadingIndex)
                                    debugPrint(r.error as Any)
                                }
                            }
                        VideoDownloadView.downloadLink = nil
                    }
                }
            }
        }
    }
}

struct VideoDownloadView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDownloadView(bvid: "BV1PP41137Px", videoDetails: ["Pic": "http://i1.hdslb.com/bfs/archive/453a7f8deacb98c3b083ead733291f080383723a.jpg", "Title": "解压视频：20000个小球Marble run动画", "BV": "BV1PP41137Px", "UP": "小球模拟", "View": "114514", "Danmaku": "1919810"])
    }
}
