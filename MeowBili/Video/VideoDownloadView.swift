//
//
//  VideoDownloadView.swift
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

import SwiftUI
import Dynamic
import DarockKit
import Alamofire

struct VideoDownloadView: View {
    var bvid: String
    var videoDetails: [String: String]
    var isPaged = false
    public static var downloadLink: String?
    public static var downloadCID: Int64?
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLoading = true
    @State var isInitialized = false
    var body: some View {
        NavigationStack {
            List {
                if isLoading {
                    Text("Download.preloading...")
                        .bold()
                } else {
                    Section {
                        HStack {
                            Spacer()
                            Label("Download.task-created", systemImage: "checkmark.circle.fill")
                                .bold()
                            Spacer()
                        }
                    }
                    Section {
                        NavigationLink(destination: { DownloadingListView() }, label: {
                            HStack {
                                Text("Download.title")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .opacity(0.65)
                            }
                        })
                    }
                }
            }
        }
        .onAppear {
            if isInitialized {
                return
            }
            isInitialized = true
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(bvid)").response { response in
                let cid = Int64((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
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
                    let downloadCID = String(VideoDownloadView.downloadCID ?? 0)
                    let destination: DownloadRequest.Destination = { _, _ in
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let fileURL = documentsURL.appendingPathComponent("dlds/\(bvid)\(isPaged ? downloadCID : "").mp4")
                        
                        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                    }
                    isLoading = false
                    downloadingProgressDataList.append((.init(), false))
                    let currentDownloadingIndex = downloadingProgressDataList.count - 1
                    videoDownloadRequests.append(
                        AF.download((VideoDownloadView.downloadLink ?? (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")), headers: headers, to: destination)
                            .downloadProgress { p in
                                downloadingProgressDataList[currentDownloadingIndex].pts.send(.init(data: .init(progress: p.fractionCompleted, currentSize: p.completedUnitCount, totalSize: p.totalUnitCount), videoDetails: videoDetails))
                            }
                            .response { r in
                                if r.error == nil, let filePath = r.fileURL?.path {
                                    debugPrint(filePath)
                                    debugPrint(bvid)
                                    var detTmp = videoDetails
                                    detTmp.updateValue(filePath, forKey: "Path")
                                    detTmp.updateValue(String(Date.now.timeIntervalSince1970), forKey: "Time")
                                    UserDefaults.standard.set(detTmp, forKey: "\(bvid)\(isPaged ? downloadCID : "")")
                                    downloadingProgressDataList[currentDownloadingIndex].isFinished = true
                                } else {
                                    if FileManager.default.fileExists(atPath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(currentDownloadingIndex).drkdatav") {
                                        try? FileManager.default.removeItem(atPath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(currentDownloadingIndex).drkdatav")
                                    }
                                    try? r.resumeData?.write(to: URL(filePath: NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(currentDownloadingIndex).drkdatav"))
                                    var detTmp = videoDetails
                                    detTmp.updateValue("\(bvid)\(isPaged ? String(VideoDownloadView.downloadCID!) : "")", forKey: "SetKey")
                                    downloadResumeDatas.updateValue(detTmp, forKey: currentDownloadingIndex)
                                    failedDownloadTasks.append(currentDownloadingIndex)
                                    debugPrint(r.error as Any)
                                }
                            }
                    )
                    VideoDownloadView.downloadLink = nil
                }
            }
        }
    }
}
