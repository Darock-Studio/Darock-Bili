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
import SDWebImageSwiftUI

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
    @State var isDownloadPresented = false
    @State var isLoading = false
    @State var isLiked = false
    @State var isCoined = false
    @State var isFavoured = false
    @State var isCoinViewPresented = false
    @State var goodVideos = [[String: String]]()
    @State var owner = [String: String]()
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
                            
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)"
                            ]
                            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                                let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                VideoDetailView.willPlayVideoCID = String(cid)
                                AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                    VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                    //debugPrint(response)
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
                            
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)"
                            ]
                            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)").response { response in
                                let cid = Int((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                VideoDetailView.willPlayVideoCID = String(cid)
                                AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                    VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                    //debugPrint(response)
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
                        ScrollView(.horizontal) {
                            HStack {
                                Button(action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata)"
                                    ]
                                    AF.request("https://api.bilibili.com/x/web-interface/archive/like", method: .post, parameters: BiliVideoLike(bvid: videoDetails["BV"]!, like: isLiked ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                                        debugPrint(response)
                                        isLiked.toggle()
                                    }
                                }, label: {
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundColor(isLiked ? Color(hex: 0xfa678e)  : .white)
                                })
                                Button(action: {
                                    if !isCoined {
                                        isCoinViewPresented = true
                                    }
                                }, label: {
                                    Image(systemName: "b.circle")
                                        .foregroundColor(isCoined ? Color(hex: 0xfa678e)  : .white)
                                        .bold()
                                })
                                .sheet(isPresented: $isCoinViewPresented, content: {VideoThrowCoinView(bvid: videoDetails["BV"]!)})
                                Button(action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata)",
                                        "referer": "bilibili.com/video/\(videoDetails["BV"]!)"
                                    ]
                                    DarockKit.Network.shared.requestString("https://api.darock.top/bili/toav/\(videoDetails["BV"]!)") { respStr, isSuccess in
                                        if isSuccess {
                                            AF.request("https://api.bilibili.com/medialist/gateway/coll/resource/deal", method: .post, parameters: BiliVideoFavourite(rid: Int(respStr)!, csrf: biliJct), headers: headers).response { response in
                                                debugPrint(response)
                                                isFavoured.toggle()
                                            }
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(isFavoured ? Color(hex: 0xfa678e) : .white)
                                })
                                Button(action: {
                                    isDownloadPresented = true
                                }, label: {
                                    Image(systemName: "arrow.down.doc")
                                })
                                .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                            }
                        }
                        if owner["ID"] != nil {
                            NavigationLink(destination: {UserDetailView(uid: owner["ID"]!)}, label: {
                                HStack {
                                    AsyncImage(url: URL(string: owner["Face"]! + "@40w"))
                                        .cornerRadius(100)
                                    VStack {
                                        Text(owner["Name"]!)
                                            .font(.system(size: 18, weight: .bold))
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                }
                            })
                        }
                        Spacer()
                            .frame(height: 25)
                        if goodVideos.count != 0 {
                            ForEach(0...goodVideos.count - 1, id: \.self) { i in
                                NavigationLink(destination: {VideoDetailView(videoDetails: goodVideos[i])}, label: {
                                    HStack {
                                        WebImage(url: URL(string: goodVideos[i]["Pic"]! + "@40w"), options: [.progressiveLoad])
                                            .cornerRadius(7)
                                        VStack {
                                            HStack {
                                                Text(goodVideos[i]["Title"]!)
                                                    .font(.system(size: 15, weight: .bold))
                                                    .lineLimit(2)
                                                Spacer()
                                            }
                                            HStack {
                                                Text(goodVideos[i]["UP"]!)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.gray)
                                                    .lineLimit(1)
                                                Spacer()
                                            }
                                            HStack {
                                                Label(goodVideos[i]["View"]!, systemImage: "play.rectangle")
                                                Label(goodVideos[i]["Danmaku"]!, systemImage: "text.word.spacing")
                                                Spacer()
                                            }
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                        }
                                    }
                                })
                                .buttonBorderShape(.roundedRectangle(radius: 14))
                            }
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
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/coins?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"]["multiply"].int! != 0 {
                        isCoined = true
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/fav/video/favoured?aid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"]["favoured"].bool! == true {
                        isFavoured = true
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/related?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    let datas = respJson["data"]
                    for data in datas {
                        goodVideos.append(["Pic": data.1["pic"].string!, "Title": data.1["title"].string!, "BV": data.1["bvid"].string!, "UP": data.1["owner"]["name"].string!, "View": String(data.1["stat"]["view"].int!), "Danmaku": String(data.1["stat"]["danmaku"].int!)])
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)") { respJson, isSuccess in
                if isSuccess {
                    owner = ["Name": respJson["data"]["owner"]["name"].string!, "Face": respJson["data"]["owner"]["face"].string!, "ID": String(respJson["data"]["owner"]["mid"].int!)]
                }
            }
            
            if videoDetails["Title"]!.contains("<em class=\"keyword\">") {
                videoDetails["Title"] = "\(String(videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? "" : (videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[0])))\(String(videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? 0 : 1].split(separator: "</em>")[0]))\(String(videoDetails["Title"]!.hasSuffix("</em>") ? "" : videoDetails["Title"]!.split(separator: "</em>")[1]))"
            }
        }
    }
}

struct VideoThrowCoinView: View {
    var bvid: String
    @Environment(\.dismiss) var dismiss
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var choseCoin = 2
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    choseCoin = 1
                }, label: {
                    Image("Coin1Icon")
                        .resizable()
                })
                .frame(width: 86, height: 126.5)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .border(choseCoin == 1 ? .blue : .black, width: 5)
                Button(action: {
                    choseCoin = 2
                }, label: {
                    Image("Coin2Icon")
                        .resizable()
                })
                .frame(width: 86, height: 126.5)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .border(choseCoin == 2 ? .blue : .black, width: 5)
            }
            Button(action: {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)"
                ]
                AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: bvid, multiply: choseCoin, csrf: biliJct), headers: headers).response { response in
                    debugPrint(response)
                    dismiss()
                }
            }, label: {
                Text("投币")
            })
        }
    }
}

struct BiliVideoLike: Codable {
    let bvid: String
    let like: Int
    let csrf: String
}
struct BiliVideoCoin: Codable {
    let bvid: String
    let multiply: Int
    var select_like: Int = 0
    let csrf: String
}
struct BiliVideoFavourite: Codable {
    let rid: Int
    var type: Int = 2
    var add_media_ids: Int? = nil
    var del_media_ids: Int? = nil
    let csrf: String
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(videoDetails: ["Pic": "http://i1.hdslb.com/bfs/archive/453a7f8deacb98c3b083ead733291f080383723a.jpg", "Title": "解压视频：20000个小球Marble run动画", "BV": "BV1PP41137Px", "UP": "小球模拟", "View": "114514", "Danmaku": "1919810"])
    }
}
