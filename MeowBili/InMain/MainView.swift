//
//
//  MainView.swift
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
import SwiftyJSON
#if !os(visionOS)
import SDWebImageSwiftUI
#endif

struct MainView: View {
    @Binding var mainTabSelection: Int
    @Namespace public var imageAnimation
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
    @State var userFaceUrl = ""
    @State var username = ""
    @State var userSign = ""
    @State var isNetworkFixPresented = false
    @State var isLoginPresented = false
    @State var userList1: [Any] = []
    @State var userList2: [Any] = []
    @State var userList3: [Any] = []
    @State var userList4: [Any] = []
    @State var isNewUserPresenting = false
    @State var festivalType = FestivalType.normal
    var body: some View {
        #if !os(watchOS)
        MainViewMain()
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isNetworkFixPresented, content: { NetworkFixView() })
            .sheet(isPresented: $isLoginPresented, content: { LoginView() })
            .sheet(isPresented: $isNewUserPresenting, content: { LoginView() })
        #else
        if #available(watchOS 10, *) {
            MainViewMain()
                .navigationBarTitleDisplayMode(.large)
                .sheet(isPresented: $isNetworkFixPresented, content: { NetworkFixView() })
                .sheet(isPresented: $isLoginPresented, content: { LoginView() })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(destination: { SearchMainView() }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.accentColor)
                        })
                        .accessibilityIdentifier("SearchButton")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Group {
                            switch festivalType {
                            case .normal:
                                Button(action: {
                                    mainTabSelection = 2
                                }, label: {
                                    if dedeUserID != "" && userFaceUrl != "" {
                                        WebImage(url: URL(string: userFaceUrl + "@60w"))
                                            .resizable()
                                            .frame(width: 30)
                                            .clipShape(Circle())
                                    } else {
                                        Image(systemName: "person")
                                            .foregroundColor(.accentColor)
                                    }
                                })
                            case .darockc:
                                NavigationLink(destination: {
                                    Text("🎉🎉🎉\n今天是 Darock 周年庆\n到我们群 248036605 参加活动吧！")
                                }, label: {
                                    Text("🎉")
                                })
                            case .fools:
                                NavigationLink(destination: {
                                    Text("🤡\n愚人节快乐！")
                                }, label: {
                                    Text("🤡")
                                })
                            case .newyr:
                                NavigationLink(destination: {
                                    Text("Darock 祝您新年快乐！")
                                }, label: {
                                    Text("🧨")
                                })
                            case .birthday:
                                NavigationLink(destination: {
                                    Text("生日快乐，\(username)！")
                                }, label: {
                                    Text("🎂")
                                })
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .sheet(isPresented: $isNewUserPresenting, content: { LoginView() })
                .onAppear {
                    if username == "" {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata); innersign=0; buvid3=\(globalBuvid3); b_nut=1704873471; i-wanna-go-back=-1; b_ut=7; b_lsid=9910433CB_18CF260AB89; enable_web_push=DISABLE; header_theme_version=undefined; home_feed_column=4; browser_resolution=3440-1440; buvid4=\(globalBuvid4);",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        biliWbiSign(paramEncoded: "mid=\(dedeUserID)".base64Encoded()) { signed in
                            if let signed {
                                debugPrint(signed)
                                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                                    if isSuccess {
                                        debugPrint(respJson)
                                        if !CheckBApiError(from: respJson) { return }
                                        username = respJson["data"]["name"].string ?? ""
                                        userSign = respJson["data"]["sign"].string ?? ""
                                        userFaceUrl = respJson["data"]["face"].string ?? "E"
                                        if let bd = respJson["data"]["birthday"].string, let mo = bd.split(separator: "-")[from: 0], let d = bd.split(separator: "-")[from: 1] {
                                            if let imo = Int(mo), let id = Int(d), imo == Date.now.month && id == Date.now.day {
                                                festivalType = .birthday
                                            }
                                        }
                                    } else if isShowNetworkFixing {
                                        isNetworkFixPresented = true
                                    }
                                }
                            }
                        }
                    }
                    if Date.now.month == 4 && Date.now.day == 1 {
                        festivalType = .fools
                    } else if Date.now.month == 1 && Date.now.day == 24 {
                        festivalType = .darockc
                    } else if Date.now.month == 1 && Date.now.day == 1 {
                        festivalType = .newyr
                    } else {
                        festivalType = .normal
                    }
                }
        } else {
            MainViewMain(isShowSearchButton: true)
                .navigationBarTitleDisplayMode(.inline)
        }
        #endif
    }
    struct MainViewMain: View {
        #if os(watchOS)
        var isShowSearchButton: Bool = false
        #endif
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @AppStorage("UpdateTipIgnoreVersion") var updateTipIgnoreVersion = ""
        @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
        @AppStorage("IsShowVideoSuggestionsFromDarock") var isShowVideoSuggestionsFromDarock = true
        @AppStorage("IsTipDarockSuggestions") var isTipDarockSuggestions = true
        @AppStorage("IsLargeSuggestionStyle") var isLargeSuggestionStyle = false
        @State var videos = [[String: String]]()
        @State var notice = ""
        @State var isNetworkFixPresented = false
        @State var isFirstLoaded = false
        @State var newMajorVer = ""
        @State var newBuildVer = ""
        @State var isShowDisableNewVerTip = false
        @State var isLoadingNew = false
        @State var isFailedToLoad = false
        @State var showedAvidList = [UInt64]()
        @State var freshCount = 0
        @State var darockSuggestions = [[String: String]]()
        var body: some View {
            ZStack {
                LargeFixedForm {
                    List {
                        Section {
                            if debug {
                                Button(action: {
                                    tipWithText("Test", symbol: "hammer.fill")
                                }, label: {
                                    Text("Home.debug")
                                })
                                #if os(watchOS)
                                NavigationLink(destination: { WatchUIDebugView() }, label: {
                                    Text("UIDebug")
                                })
                                #endif
                            }
                            if notice != "" {
                                NavigationLink(destination: { NoticeView() }, label: {
                                    Text(notice)
                                        .bold()
                                })
                            }
                            if newMajorVer != "" && newBuildVer != "" {
                                let nowMajorVer = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                                let nowBuildVer = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
                                if (nowMajorVer < newMajorVer || Int(nowBuildVer) ?? 1 < Int(newBuildVer) ?? 1) && updateTipIgnoreVersion != "\(newMajorVer)\(newBuildVer)" {
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
                        #if os(watchOS)
                        if isShowSearchButton {
                            Section {
                                NavigationLink(destination: { SearchMainView() }, label: {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                        Text("Home.search")
                                    }
                                    .foregroundColor(.gray)
                                })
                            }
                        }
                        #endif
                        if isShowVideoSuggestionsFromDarock && !darockSuggestions.isEmpty {
                            Section {
                                ForEach(0..<darockSuggestions.count, id: \.self) { i in
                                    VideoCard(darockSuggestions[i])
                                }
                            } header: {
                                Text("来自 Darock 的推荐")
                                    .textCase(nil)
                            } footer: {
                                if isTipDarockSuggestions {
                                    NavigationLink(destination: { NetworkSettingsView().navigationTitle("互联网") }, label: {
                                        Text("如不希望显示来自 Darock 的推荐，可前往\(Text("设置").foregroundColor(Color.blue).bold())关闭")
                                    })
                                    .buttonStyle(.plain)
                                    .onDisappear {
                                        isTipDarockSuggestions = false
                                    }
                                }
                            }
                        }
                        if videos.count != 0 {
                            Section {
                                ForEach(0..<videos.count, id: \.self) { i in
                                    if !isLargeSuggestionStyle {
                                        VideoCard(videos[i])
                                            .accessibilityIdentifier("SuggestedVideo\(i)")
                                            .onAppear {
                                                if i == videos.count - 1 {
                                                    LoadNewVideos()
                                                }
                                            }
                                    } else {
                                        LargeVideoCard(videos[i])
                                            .accessibilityIdentifier("SuggestedVideo\(i)")
                                            .onAppear {
                                                if i == videos.count - 1 {
                                                    LoadNewVideos()
                                                }
                                            }
                                    }
                                }
                            }
                            Section {
                                if isLoadingNew {
                                    ProgressView()
                                }
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
                    .scrollIndicators(.never)
                }
                if debugBuild {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("喵哩喵哩\n调试构建。 Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String).xc_verd.\(Text({ () -> String in let df = DateFormatter(); df.dateFormat = "yyMMdd-hhmm"; return df.string(from: Date(timeIntervalSince1970: TimeInterval(CodingTime.getCodingTimestamp()))) }()))")
                                .font(.system(size: 7))
                                .multilineTextAlignment(.trailing)
                            Spacer()
                                .frame(width: 10)
                        }
                        Spacer()
                            .frame(height: 10)
                    }
                    .allowsHitTesting(false)
                    .ignoresSafeArea()
                }
            }
            .navigationTitle("Home")
            .refreshable {
                videos.removeAll()
                LoadNewVideos(clearWhenFinish: true)
            }
            .onAppear {
                LoadDarockSuggestions()
                if !isFirstLoaded {
                    LoadNewVideos()
                    isFirstLoaded = true
                }
                DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/bili/notice") { respStr, isSuccess in
                    if isSuccess {
                        notice = respStr.apiFixed()
                    }
                }
                DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/bili/newver") { respStr, isSuccess in
                    if isSuccess && respStr.apiFixed().contains("|") {
                        newMajorVer = String(respStr.apiFixed().split(separator: "|")[0])
                        newBuildVer = String(respStr.apiFixed().split(separator: "|")[1])
                    }
                }
            }
            .sheet(isPresented: $isNetworkFixPresented, content: { NetworkFixView() })
        }
        
        func LoadNewVideos(clearWhenFinish: Bool = false) {
            isLoadingNew = true
            isFailedToLoad = false
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            var lastShowlist = "&last_showlist="
            for avid in showedAvidList {
                lastShowlist += "av_\(avid)"
            }
            if lastShowlist == "&last_showlist=" {
                lastShowlist = ""
            }
            biliWbiSign(paramEncoded: "y_num=5&fresh_type=3&feed_version=V_FAVOR_WATCH_LATER&fresh_idx_1h=\(freshCount)&fetch_row=1&fresh_idx=\(freshCount)&brush=4&homepage_ver=1&ps=20&last_y_num=5&screen=2353-686&seo_info=\(lastShowlist)".base64Encoded()) { signed in
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
                                // Bilibili inserts ADVERTISEMENTS here dirtctly. Ads don't have bvid, filter them
                                if videoInfo.1["bvid"].string ?? "E" != "" {
                                    videos.append(["Pic": videoInfo.1["pic"].string ?? "E", "Title": videoInfo.1["title"].string ?? "[加载失败]", "BV": videoInfo.1["bvid"].string ?? "E", "UP": videoInfo.1["owner"]["name"].string ?? "[加载失败]", "View": String(videoInfo.1["stat"]["view"].int ?? -1), "Danmaku": String(videoInfo.1["stat"]["danmaku"].int ?? -1)])
                                    showedAvidList.append(bv2av(bvid: videoInfo.1["bvid"].string ?? "BV1PP41137Px"))
                                }
                            }
                            isLoadingNew = false
                            freshCount++
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
        func LoadDarockSuggestions() {
            DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/bili/sgsfrmdrk") { respStr, isSuccess in
                if isSuccess {
                    if !respStr.apiFixed().hasPrefix("BV") { return }
                    let bvs = respStr.apiFixed().split(separator: "|").map { String($0) }
                    let headers: HTTPHeaders = [
                        "cookie": "SESSDATA=\(sessdata)",
                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                    ]
                    darockSuggestions.removeAll()
                    for bvid in bvs {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(bvid)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                if !CheckBApiError(from: respJson) { return }
                                var vd = ["BV": bvid]
                                vd.updateValue(respJson["data"]["title"].string ?? "[加载失败]", forKey: "Title")
                                vd.updateValue(String(respJson["data"]["stat"]["view"].int ?? 0), forKey: "View")
                                vd.updateValue(String(respJson["data"]["stat"]["danmaku"].int ?? 0), forKey: "Danmaku")
                                vd.updateValue(respJson["data"]["pic"].string ?? "[加载失败]", forKey: "Pic")
                                vd.updateValue(respJson["data"]["owner"]["name"].string ?? "[加载失败]", forKey: "UP")
                                darockSuggestions.append(vd)
                            }
                        }
                    }
                }
            }
        }
        
        @ViewBuilder
        func LargeFixedForm(@ViewBuilder _ content: () -> some View) -> some View {
            #if os(watchOS)
            if isLargeSuggestionStyle {
                Form {
                    content()
                }
                .scrollIndicators(.never)
            } else {
                content()
            }
            #else
            content()
            #endif
        }
    }
    
    enum FestivalType {
        case normal
        case darockc
        case fools
        case newyr
        case birthday
    }
}
