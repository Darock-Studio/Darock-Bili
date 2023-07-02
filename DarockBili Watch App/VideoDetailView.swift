//
//  VideoDetailView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI
import DarockKit
import SwiftyJSON
import Alamofire

struct VideoDetailView: View {
    public static var willPlayVideoLink = ""
    public static var willPlayVideoBV = ""
    public static var willPlayVideoCID = ""
    @State var videoDetails: [String: String]
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isVideoPlayerPresented = false
    @State var isLoading = false
    @State var isLiked = false
    var body: some View {
        TabView {
            ZStack {
                ScrollView {
                    VStack {
                        Text(videoDetails["Title"]!)
                            .lineLimit(3)
                            .font(.system(size: 18, weight: .bold))
                        Button(action: {
                            isLoading = true
                            
                            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                                let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                VideoDetailView.willPlayVideoCID = String(cid)
                                AF.request("https://api.bilibili.com/x/player/playurl?bvid=\(videoDetails["BV"]!)&cid=\(cid)&qn=64").response { response in
                                    VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                    VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                    isVideoPlayerPresented = true
                                    isLoading = false
                                }
                            }
                        }, label: {
                            AsyncImage(url: URL(string: videoDetails["Pic"]! + "@150w")!)
                        })
                        .buttonBorderShape(.roundedRectangle(radius: 14))
                        Button(action: {
                            isLoading = true
                            
                            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                                let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                VideoDetailView.willPlayVideoCID = String(cid)
                                AF.request("https://api.bilibili.com/x/player/playurl?bvid=\(videoDetails["BV"]!)&cid=\(cid)&qn=64").response { response in
                                    VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                    VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                    isVideoPlayerPresented = true
                                    isLoading = false
                                }
                            }
                        }, label: {
                            Label("播放", systemImage: "play.fill")
                                .font(.system(size: 21))
                        })
                        .sheet(isPresented: $isVideoPlayerPresented, content: {VideoPlayerView()})
                        HStack {
                            Button(action: {
                                
                                isLiked.toggle()
                            }, label: {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(isLiked ? Color(hex: 0xfa678e) : .white)
                            })
                            Button(action: {
                                
                            }, label: {
                                
                            })
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "star.fill")
                            })
                        }
                    }
                }
                .blur(radius: isLoading ? 14 : 0)
                if isLoading {
                    Text("正在解析...")
                        .font(.title2)
                        .bold()
                }
            }
            .tag(1)
            VideoCommentsView(oid: String(videoDetails["BV"]!.dropFirst().dropFirst()))
                .tag(2)
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/has/like?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"].int! == 1 {
                        isLiked = true
                    }
                }
            }
            
            if videoDetails["Title"]!.contains("<em class=\"keyword\">") {
                videoDetails["Title"] = "\(String(videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? "" : (videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[0])))\(String(videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? 0 : 1].split(separator: "</em>")[0]))\(String(videoDetails["Title"]!.hasSuffix("</em>") ? "" : videoDetails["Title"]!.split(separator: "</em>")[1]))"
            }
        }
    }
}

#Preview {
    VideoDetailView(videoDetails: ["Pic": "http://i1.hdslb.com/bfs/archive/453a7f8deacb98c3b083ead733291f080383723a.jpg", "Title": "解压视频：20000个小球Marble run动画", "BV": "BV1PP41137Px", "UP": "小球模拟", "View": "114514", "Danmaku": "1919810"])
}
