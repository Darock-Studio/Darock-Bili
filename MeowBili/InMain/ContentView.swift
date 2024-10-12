//
//
//  ContentView.swift
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
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

var pIsAudioControllerAvailable = false
var pShouldPresentAudioController = false

struct ContentView: View {
    public static var nowAppVer = "1.0.0|106"
    @AppStorage("IsNewFeatureTipped1") var isNewFeatureTipped = false
    @AppStorage("LastUsingVer") var lastUsingVer = ""
    @AppStorage("IsReadTerms") var isReadTerms = false
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var mainTabSelection = 1
    @State var isTermsPresented = false
    @State var userFaceUrl = ""
    @State var isAudioControllerPresented = false
    @State var isNewFeaturePresented = false
    @FocusState var isSearchKeyboardFocused: Bool
    var body: some View {
        NavigationStack {
            TabView(selection: $mainTabSelection.onUpdate { oldValue, newValue in
                if oldValue == newValue && newValue == 4 {
                    isSearchKeyboardFocused = true
                }
            }) {
                MainView(mainTabSelection: $mainTabSelection)
#if !os(watchOS)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            if dedeUserID != "" {
                                Button(action: {
                                    mainTabSelection = 2
                                }, label: {
                                    WebImage(url: URL(string: userFaceUrl))
                                        .resizable()
                                        .placeholder {
                                            Circle()
                                                .frame(width: 35, height: 35)
                                                .redacted(reason: .placeholder)
                                        }
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())
                                })
                                .buttonStyle(.borderless)
                            }
                        }
                    }
#endif
                    .tag(1)
                    .tabItem {
                        Label("navbar.suggest", systemImage: "sparkles")
                    }
                PersonAccountView()
                    .tag(2)
                    .tabItem {
                        Label("navbar.my", systemImage: "person.fill")
                    }
                UserDynamicMainView()
                    .tag(3)
                    .tabItem {
                        Label("navbar.dynamic", systemImage: "rectangle.stack.fill")
                    }
#if !os(watchOS)
                SearchMainView(isSearchKeyboardFocused: $isSearchKeyboardFocused)
                    .tag(4)
                    .tabItem {
                        Label("搜索", systemImage: "magnifyingglass")
                    }
#endif
            }
            .accessibility(identifier: "MainTabView")
            #if os(watchOS)
            .sheet(isPresented: $isAudioControllerPresented, content: { AudioControllerView() })
            .sheet(isPresented: $isNewFeaturePresented, onDismiss: {
                isNewFeatureTipped = true
            }, content: { NewFeaturesView() })
            #endif
            .sheet(isPresented: $isTermsPresented, onDismiss: {
                isReadTerms = true
            }, content: { TermsListView() })
            .onAppear {
#if os(watchOS)
                if !isNewFeatureTipped {
                    isNewFeaturePresented = true
                }
                if !isReadTerms {
                    isTermsPresented = true
                }
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    if pShouldPresentAudioController {
                        pShouldPresentAudioController = false
                        isAudioControllerPresented = true
                    }
                }
#endif
            }
        }
        .onAppear {
            updateBiliTicket(csrf: biliJct)
            if dedeUserID != "" {
                getBuvid(url: "https://api.bilibili.com/x/space/wbi/acc/info".urlEncoded()) { buvid3, buvid4, _uuid, _ in
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
                                    userFaceUrl = respJson["data"]["face"].string ?? "E"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct TermsListView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("IsReadTerms") var isReadTerms = false
    var body: some View {
        ScrollView {
            VStack {
                Text("""
                    在使用本 App 前，您需要先知晓以下信息：
                    · 本 App 由第三方开发者以及部分社区用户贡献，与哔哩哔哩无合作关系，哔哩哔哩是上海宽娱数码科技有限公司的商标。
                    · 本 App 并不是哔哩哔哩的替代品，我们建议您在能够使用官方客户端时尽量使用官方客户端。
                    · 本 App 均使用来源于网络的公开信息进行开发。
                    · 本 App 中和B站相关的功能完全免费
                    · 本 App 中所呈现的B站内容来自哔哩哔哩官方。
                    · 本 App 的开发者、负责人和实际责任人是\(Text("WindowsMEMZ").foregroundColor(Color.accentColor))\n  联系QQ：3245146430
                    """)
                Button(action: {
                    isReadTerms = true
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Home.understand")
                })
                .buttonStyle(.borderedProminent)
            }
            .scenePadding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
