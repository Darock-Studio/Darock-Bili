//
//  MainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

// 注释来自 ChatGPT 生成

import SwiftUI
import DarockKit
import SwiftyJSON
import Alamofire
import SDWebImageSwiftUI

struct MainView: View {
    @State var isSearchPresented = false
    var body: some View {
        if #available(watchOS 10, *) {
            MainViewMain()
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
                        .accessibilityIdentifier("SearchButton")
                    }
                }
        } else {
            MainViewMain(isShowSearchButton: true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    struct MainViewMain: View {
        var isShowSearchButton: Bool = false
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var videos = [[String: String]]()
        @State var isSearchPresented = false
        @State var notice = ""
        @State var isNetworkFixPresented = false
        @State var isFirstLoaded = false
        @State var newMajorVer = ""
        @State var newBuildVer = ""
        var body: some View {
            Group {
                List {
                    Section {
                        if debug {
                            Text("Debug Version. DO NOT Release!!")
                                .bold()
                            Button(action: {
                                tipWithText("Test")
                            }, label: {
                                Text("Debug")
                            })
                        }
                        if notice != "" {
                            NavigationLink(destination: {NoticeView()}, label: {
                                Text(notice)
                                    .bold()
                            })
                        }
                        if newMajorVer != "" && newBuildVer != "" {
                            let nowMajorVer = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                            let nowBuildVer = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
                            if nowMajorVer < newMajorVer || nowBuildVer < newBuildVer {
                                Text("喵哩喵哩新版本(v\(newMajorVer) Build \(newBuildVer))已发布！可前往 TestFlight 更新")
                            }
                        }
                    }
                    if isShowSearchButton {
                        Section {
                            Button(action: {
                                isSearchPresented = true
                            }, label: {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    Text("搜索...")
                                }
                                .foregroundColor(.gray)
                            })
                            .sheet(isPresented: $isSearchPresented, content: {SearchMainView()})
                        }
                    }
                    Section {
                        if videos.count != 0 {
                            autoreleasepool {
                                ForEach(0...videos.count - 1, id: \.self) { i in
                                    VideoCard(videos[i])
                                        .accessibilityIdentifier(i == 0 ? "TestVideoCard" : "")
                                }
                            }
                            Section {
                                Button(action: {
                                    LoadNewVideos()
                                }, label: {
                                    Text("加载更多")
                                        .bold()
                                })
                            }
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("推荐")
            .onAppear {
                if !isFirstLoaded {
                    LoadNewVideos()
                    isFirstLoaded = true
                }
                DarockKit.Network.shared.requestString("https://api.darock.top/bili/notice") { respStr, isSuccess in
                    if isSuccess {
                        notice = respStr.apiFixed()
                    }
                }
                DarockKit.Network.shared.requestString("https://api.darock.top/bili/newver") { respStr, isSuccess in
                    if isSuccess && respStr.apiFixed().contains("|") {
                        newMajorVer = String(respStr.apiFixed().split(separator: "|")[0])
                        newBuildVer = String(respStr.apiFixed().split(separator: "|")[1])
                    }
                }
            }
            .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
        }
        
        func LoadNewVideos(clearWhenFinish: Bool = false) {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)"
            ]
//            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/dynamic/region?ps=50&rid=1", headers: headers) { respJson, isSuccess in
//                if isSuccess {
//                    let datas = respJson["data"]["archives"]
//                    debugPrint(datas)
//                    autoreleasepool {
//                        for videoInfo in datas {
//                            videos.append(["Pic": videoInfo.1["pic"].string!, "Title": videoInfo.1["title"].string!, "BV": videoInfo.1["bvid"].string!, "UP": videoInfo.1["owner"]["name"].string!, "View": String(videoInfo.1["stat"]["view"].int!), "Danmaku": String(videoInfo.1["stat"]["danmaku"].int!)])
//                        }
//                    }
//                } else {
//                    isNetworkFixPresented = true
//                }
//            }
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("ps=10".base64Encoded())") { respStr, isSuccess in
                if isSuccess {
                    debugPrint(respStr.apiFixed())
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/wbi/index/top/feed/rcmd?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            let datas = respJson["data"]["item"]
                            if clearWhenFinish {
                                videos = [[String: String]]()
                            }
                            for videoInfo in datas {
                                videos.append(["Pic": videoInfo.1["pic"].string!, "Title": videoInfo.1["title"].string!, "BV": videoInfo.1["bvid"].string!, "UP": videoInfo.1["owner"]["name"].string!, "View": String(videoInfo.1["stat"]["view"].int!), "Danmaku": String(videoInfo.1["stat"]["danmaku"].int!)])
                            }
                        } else {
                            isNetworkFixPresented = true
                        }
                    }
                } else {
                    isNetworkFixPresented = true
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
