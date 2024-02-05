//
//  MainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
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
import SwiftyJSON
import Dynamic
import Alamofire
import SDWebImageSwiftUI
import CachedAsyncImage

struct MainView: View {
    @Namespace public var imageAnimation
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
    @State var userFaceUrl = ""
    @State var username = ""
    @State var userSign = ""
    @State var isSearchPresented = false
    @State var isNetworkFixPresented = false
    @State var isLoginPresented = false
    var body: some View {
        if #available(watchOS 10, *) {
            MainViewMain()
                .navigationBarTitleDisplayMode(.large)
                .sheet(isPresented: $isSearchPresented, content: {SearchMainView()})
                .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
                .sheet(isPresented: $isLoginPresented, content: {LoginView()})
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            isSearchPresented = true
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.accentColor)
                        })
                        .accessibilityIdentifier("SearchButton")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if dedeUserID != "" {
                            NavigationLink(destination: {PersonAccountView(isSettingsButtonTrailing: true)}, label: {
                                CachedAsyncImage(url: URL(string: userFaceUrl + "@30w")) { phase in
                                    switch phase {
                                      case .empty:
                                          Image(systemName: "person")
                                              .foregroundColor(.accentColor)
                                      case .success(let image):
                                          image
                                      case .failure:
                                          Image(systemName: "person")
                                              .foregroundColor(.accentColor)
                                      @unknown default:
                                          Image(systemName: "person")
                                              .foregroundColor(.accentColor)
                                    }
                                }
                                .frame(width: 30)
                                .clipShape(Circle())
                                .matchedGeometryEffect(id: "image", in: imageAnimation)
                            })
                            .buttonStyle(.borderless)
                        } else {
                            Button(action: {
                                isLoginPresented = true
                            }, label: {
                                Image(systemName: "person")
                                    .foregroundColor(.accentColor)
                            })
                        }
                    }
                }
                .onAppear {
                    if username == "" {
                        getBuvid(url: "https://api.bilibili.com/x/space/wbi/acc/info".urlEncoded()) { buvid3, buvid4, _uuid, resp in
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata); innersign=0; buvid3=\(buvid3); b_nut=1704873471; i-wanna-go-back=-1; b_ut=7; b_lsid=9910433CB_18CF260AB89; _uuid=\(_uuid); enable_web_push=DISABLE; header_theme_version=undefined; home_feed_column=4; browser_resolution=3440-1440; buvid4=\(buvid4);",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                            biliWbiSign(paramEncoded: "mid=\(dedeUserID)".base64Encoded()) { signed in
                                if let signed {
                                    debugPrint(signed)
                                    autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            debugPrint(respJson)
                                            if !CheckBApiError(from: respJson) { return }
                                            username = respJson["data"]["name"].string ?? ""
                                            userSign = respJson["data"]["sign"].string ?? ""
                                            userFaceUrl = respJson["data"]["face"].string ?? "E"
                                        } else if isShowNetworkFixing {
                                            isNetworkFixPresented = true
                                        }
                                    }
                                }
                            }
                        }
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
        @AppStorage("UpdateTipIgnoreVersion") var updateTipIgnoreVersion = ""
        @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
        @State var videos = [[String: String]]()
        @State var isSearchPresented = false
        @State var notice = ""
        @State var isNetworkFixPresented = false
        @State var isFirstLoaded = false
        @State var newMajorVer = ""
        @State var newBuildVer = ""
        @State var isShowDisableNewVerTip = false
        @State var isLoadingNew = false
        @State var isFailedToLoad = false
        var body: some View {
            Group {
                List {
                    Section {
                        if debug {
                            Button(action: {
                                tipWithText("Test")
//                                Dynamic.PUICApplication.sharedPUICApplication._setStatusBarTimeHidden(true, animated: false, completion: nil)
                                //Dynamic.WatchKit.sharedPUICApplication._setStatusBarTimeHidden(true, animated: false)
                            }, label: {
                                Text("Home.debug")
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
                            if (nowMajorVer < newMajorVer || nowBuildVer < newBuildVer) && updateTipIgnoreVersion != "\(newMajorVer)\(newBuildVer)" {
                                VStack {
                                    Text("Home.update.\(newMajorVer).\(newBuildVer)")
                                    if isShowDisableNewVerTip {
                                        Text("Home.update.skip")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .onTapGesture {
                                    if isShowDisableNewVerTip {
                                        updateTipIgnoreVersion = "\(newMajorVer)\(newBuildVer)"
                                    } else {
                                        isShowDisableNewVerTip = true
                                    }
                                }
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
                                    Text("Home.search")
                                }
                                .foregroundColor(.gray)
                            })
                            .sheet(isPresented: $isSearchPresented, content: {SearchMainView()})
                        }
                    }
                    if videos.count != 0 {
                        Section {
                            autoreleasepool {
                                ForEach(0...videos.count - 1, id: \.self) { i in
                                    VideoCard(videos[i])
                                        .accessibility(identifier: "SuggestVideo")
                                }
                            }
                        }
                        Section {
                            Button(action: {
                                LoadNewVideos()
                            }, label: {
                                if !isFailedToLoad {
                                    if !isLoadingNew {
                                        Text("Home.more")
                                            .bold()
                                    } else {
                                        ProgressView()
                                    }
                                } else {
                                    Label("Home.more.error", systemImage: "arrow.clockwise")
                                }
                            })
                        }
                    } else if isFailedToLoad {
                        Button {
                            LoadNewVideos()
                        } label: {
                            Label("Home.more.error", systemImage: "wifi.exclamationmark")
                        }
                        Text("Home.no-internet")
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("Home")
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
            isLoadingNew = true
            isFailedToLoad = false
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            biliWbiSign(paramEncoded: "ps=\(isInLowBatteryMode ? 10 :  30)".base64Encoded()) { signed in
                if let signed {
                    debugPrint(signed)
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/wbi/index/top/feed/rcmd?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            if !CheckBApiError(from: respJson) { return }
                            let datas = respJson["data"]["item"]
                            if clearWhenFinish {
                                videos = [[String: String]]()
                            }
                            for videoInfo in datas {
                                videos.append(["Pic": videoInfo.1["pic"].string ?? "E", "Title": videoInfo.1["title"].string ?? "[加载失败]", "BV": videoInfo.1["bvid"].string ?? "E", "UP": videoInfo.1["owner"]["name"].string ?? "[加载失败]", "View": String(videoInfo.1["stat"]["view"].int ?? -1), "Danmaku": String(videoInfo.1["stat"]["danmaku"].int ?? -1)])
                            }
                            isLoadingNew = false
                        } else {
                            isFailedToLoad = true
                            if isShowNetworkFixing {
                                isNetworkFixPresented = true
                            }
                        }
                    }
                } else {
                    isFailedToLoad = true
                    if isShowNetworkFixing {
                        isNetworkFixPresented = true
                    }
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
