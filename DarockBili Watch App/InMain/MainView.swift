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
    @State var isSearchPresented = false
    @State var notice = ""
    @State var isNetworkFixPresented = false
    var body: some View {
        Group {
            List {
//                Button(role: .destructive, action: {
//                    
//                }, label: {
//                    HStack {
//                        Image(systemName: "exclamationmark.circle")
//                        Text("当前网络状态不佳")
//                    }
//                })
//                .buttonBorderShape(.roundedRectangle(radius: 13))
                Section {
                    if notice != "" {
                        NavigationLink(destination: {NoticeView()}, label: {
                            Text(notice)
                                .bold()
                        })
                    }
                }
                Section {
                    if videos.count != 0 {
                        ForEach(0...videos.count - 1, id: \.self) { i in
                            VideoCard(videos[i])
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
        .navigationTitle("推荐")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    isSearchPresented = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.accentColor)
                })
                .sheet(isPresented: $isSearchPresented, content: {SearchMainView()})
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
        .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
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
            } else {
                isNetworkFixPresented = true
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
