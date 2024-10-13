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

var videoDownloadNeedsResumeIdentifiers = Set<Int>()
var videoDownloadRequests = [URLSessionTask]()
var videoDownloadDetails = [Int: [String: String]]()
let videoDownloadSession = {
    let configuration = URLSessionConfiguration.background(withIdentifier: "com.darock.DarockBili.Video-Download.background")
    configuration.isDiscretionary = false
    configuration.sessionSendsLaunchEvents = true
    let session = URLSession(configuration: configuration, delegate: VideoDownloadSessionDelegate.shared, delegateQueue: nil)
    return session
}()

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
                    let headers = [
                        "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                        "accept-encoding": "gzip, deflate, br",
                        "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
                        "cookie": "SESSDATA=\(sessdata)",
                        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.30 Safari/537.36 Edg/84.0.522.11",
                        "sec-fetch-dest": "document",
                        "sec-fetch-mode": "navigate",
                        "sec-fetch-site": "none",
                        "sec-fetch-user": "?1",
                        "upgrade-insecure-requests": "1",
                        "referer": "https://www.bilibili.com/"
                    ]
                    let downloadCID = String(VideoDownloadView.downloadCID ?? 0)
                    isLoading = false
                    var request = URLRequest(url: URL(string: VideoDownloadView.downloadLink ?? (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&"))!)
                    request.allHTTPHeaderFields = headers
                    let task = videoDownloadSession.downloadTask(with: request)
                    task.resume()
                    var videoDetails = videoDetails
                    if isPaged {
                        videoDetails.updateValue(downloadCID, forKey: "DownloadCID")
                    }
                    videoDownloadDetails.updateValue(videoDetails, forKey: task.taskIdentifier)
                    videoDownloadRequests.append(task)
                    VideoDownloadView.downloadLink = nil
                }
            }
        }
    }
}

private class VideoDownloadSessionDelegate: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    static let shared = VideoDownloadSessionDelegate()
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        debugPrint("Finish Background Events")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint(location)
        downloadTask.progress.completedUnitCount = downloadTask.progress.totalUnitCount
        if var details = videoDownloadDetails[downloadTask.taskIdentifier] {
            let destination = URL(filePath: NSHomeDirectory() + "/Documents/dlds/\(details["BV"]!)\(details["DownloadCID"] ?? "").mp4")
            do {
                try FileManager.default.moveItem(at: location, to: destination)
                details.updateValue(destination.path, forKey: "Path")
                details.updateValue(String(Date.now.timeIntervalSince1970), forKey: "Time")
                UserDefaults.standard.set(details, forKey: "\(details["BV"]!)\(details["DownloadCID"] ?? "")")
            } catch {
                print(error)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            downloadTask.progress.completedUnitCount = totalBytesWritten
            downloadTask.progress.totalUnitCount = totalBytesExpectedToWrite
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        guard let error else { return }
        let userInfo = (error as NSError).userInfo
        if let resumeData = userInfo[NSURLSessionDownloadTaskResumeData] as? Data {
            do {
                let resumeFilePath = NSHomeDirectory() + "/tmp/VideoDownloadResumeData\(task.taskIdentifier).drkdatav"
                if FileManager.default.fileExists(atPath: resumeFilePath) {
                    try FileManager.default.removeItem(atPath: resumeFilePath)
                }
                try resumeData.write(to: URL(filePath: resumeFilePath))
                videoDownloadNeedsResumeIdentifiers.insert(task.taskIdentifier)
            } catch {
                print(error)
            }
        }
    }
}
