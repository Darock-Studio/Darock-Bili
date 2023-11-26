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

struct VideoDownloadView: View {
    var bvid: String
    var videoDetails: [String: String]
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLoading = true
    @State var downloadProgress = 0.0
    @State var downloadedSize: Int64 = 0
    @State var totalSize: Int64 = 0
    var body: some View {
        List {
            if isLoading {
                Text("正在预加载...")
                    .bold()
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Text("正在下载...")
                            .bold()
                        Spacer()
                    }
                    ProgressView(value: downloadProgress * 100, total: 100.0)
                    HStack {
                        Spacer()
                        Text("\(String(format: "%.2f", downloadProgress * 100) + " %")")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(String(format: "%.2f", Double(downloadedSize) / 1024 / 1024))MB / \(String(format: "%.2f", Double(totalSize) / 1024 / 1024))MB")
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)"
            ]
            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(bvid)").response { response in
                let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                VideoDetailView.willPlayVideoCID = String(cid)
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
                    AF.download((String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&"), headers: headers, to: destination)
                        .downloadProgress { p in
                            downloadProgress = p.fractionCompleted
                            downloadedSize = p.completedUnitCount
                            totalSize = p.totalUnitCount
                        }
                        .response { r in
                            if r.error == nil, let filePath = r.fileURL?.path {
                                debugPrint(filePath)
                                debugPrint(bvid)
                                var detTmp = videoDetails
                                detTmp.updateValue(filePath, forKey: "Path")
                                detTmp.updateValue(String(Date.now.timeIntervalSince1970), forKey: "Time")
                                UserDefaults.standard.set(detTmp, forKey: bvid)
                            } else {
                                debugPrint(r.error as Any)
                            }
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
