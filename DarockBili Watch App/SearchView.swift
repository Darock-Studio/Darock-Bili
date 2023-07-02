//
//  SearchView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/1.
//

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct SearchView: View {
    var keyword: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var videos = [[String: String]]()
    var body: some View {
        NavigationStack {
            List {
                if videos.count != 0 {
                    ForEach(0...videos.count - 1, id: \.self) { i in
                        NavigationLink(destination: {VideoDetailView(videoDetails: videos[i])}, label: {
                            VStack {
                                HStack {
                                    Spacer()
                                    ZStack {
                                        WebImage(url: URL(string: videos[i]["Pic"]! + "@150w")!, options: [.progressiveLoad])
                                            .cornerRadius(7)
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Label(videos[i]["View"]!, systemImage: "play.rectangle")
                                                    .font(.system(size: 12))
                                                Label(videos[i]["Danmaku"]!, systemImage: "text.word.spacing")
                                                    .font(.system(size: 12))
                                                Spacer()
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                if videos[i]["Title"]!.contains("<em class=\"keyword\">") {
                                    Text("\(String(videos[i]["Title"]!.hasPrefix("<em class=\"keyword\">") ? "" : (videos[i]["Title"]!.split(separator: "<em class=\"keyword\">")[0])))\(Text(String(videos[i]["Title"]!.split(separator: "<em class=\"keyword\">")[videos[i]["Title"]!.hasPrefix("<em class=\"keyword\">") ? 0 : 1].split(separator: "</em>")[0])).foregroundColor(.red).bold())\(String(videos[i]["Title"]!.hasSuffix("</em>") ? "" : videos[i]["Title"]!.split(separator: "</em>")[1]))")
                                        .font(.system(size: 18))
                                        .lineLimit(3)
                                } else {
                                    Text(videos[i]["Title"]!)
                                        .font(.system(size: 18))
                                        .lineLimit(3)
                                }
                                HStack {
                                    Spacer()
                                        .frame(width: 5)
                                    Text(videos[i]["UP"]!)
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                        })
                    }
                }
            }
        }
        .onAppear {
            AF.request("bilibili.com").response { response in
                let headers: HTTPHeaders = [
                    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
                    "accept-encoding": "gzip, deflate, br",
                    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
                    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.30 Safari/537.36 Edg/84.0.522.11",
                    "sec-fetch-dest": "document",
                    "sec-fetch-mode": "navigate",
                    "sec-fetch-site": "none",
                    "sec-fetch-user": "?1",
                    "upgrade-insecure-requests": "1",
                    "referer": "https://www.bilibili.com/",
                    "cookie": "SESSDATA=\(sessdata); bili_jct=\(biliJct); DedeUserID=\(dedeUserID); DedeUserID__ckMd5=\(dedeUserID__ckMd5)"
                ]
                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/search/all/v2?keyword=\(keyword)", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        let videoDatas = respJson["data"]["result"][11]["data"]
                        debugPrint(videoDatas)
                        for video in videoDatas {
                            videos.append(["Pic": "https:" + video.1["pic"].string!, "Title": video.1["title"].string!, "View": String(video.1["play"].int!), "Danmaku": String(video.1["danmaku"].int!), "UP": video.1["author"].string!, "BV": video.1["bvid"].string!])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView(keyword: "Darock")
}
