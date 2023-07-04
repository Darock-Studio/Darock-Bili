//
//  MainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI
import DarockKit
import SwiftyJSON
import Alamofire
import SDWebImageSwiftUI

struct MainView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var videos = [[String: String]]()
    @State var searchText = ""
    @State var isSearchPresented = false
    @State var notice = ""
    var body: some View {
        Group {
            List {
                Section {
                    if notice != "" {
                        NavigationLink(destination: {NoticeView()}, label: {
                            Text(notice)
                                .bold()
                        })
                    }
                }
                Section {
                    TextField("搜索", text: $searchText)
                        .onSubmit {
                            isSearchPresented = true
                        }
                        .sheet(isPresented: $isSearchPresented, content: {SearchView(keyword: searchText)})
                        .onDisappear {
                            searchText = ""
                        }
                }
                Section {
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
                                    Text(videos[i]["Title"]!)
                                        .font(.system(size: 18))
                                        .lineLimit(3)
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
                        Button(action: {
                            LoadNewVideos()
                        }, label: {
                            Text("加载更多")
                                .bold()
                        })
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .onAppear {
            LoadNewVideos()
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/notice") { respStr, isSuccess in
                if isSuccess {
                    notice = respStr.apiFixed()
                }
            }
        }
    }
    
    func LoadNewVideos() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata)"
        ]
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/dynamic/region?ps=50&rid=1", headers: headers) { respJson, isSuccess in
            if isSuccess {
                let datas = respJson["data"]["archives"]
                debugPrint(datas)
                for videoInfo in datas {
                    videos.append(["Pic": videoInfo.1["pic"].string!, "Title": videoInfo.1["title"].string!, "BV": videoInfo.1["bvid"].string!, "UP": videoInfo.1["owner"]["name"].string!, "View": String(videoInfo.1["stat"]["view"].int!), "Danmaku": String(videoInfo.1["stat"]["danmaku"].int!)])
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
