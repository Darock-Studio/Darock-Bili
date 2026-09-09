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
import Alamofire
import SwiftyJSON
import DarockFoundation
import SDWebImageSwiftUI

var pIsAudioControllerAvailable = false
var pShouldPresentAudioController = false

struct ContentView: View {
    @AppStorage("IsNewFeatureTipped1") private var isNewFeatureTipped = false
    @AppStorage("LastUsingVer") private var lastUsingVer = ""
    @AppStorage("IsReadTerms") private var isReadTerms = false
    @AppStorage("ShouldShowFunderList") private var shouldShowFunderList = {
//        #if DAROCK_ALT
//        true
//        #else
        false
//        #endif
    }()
    @AppStorage("DedeUserID") private var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") private var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") private var sessdata = ""
    @AppStorage("bili_jct") private var biliJct = ""
    @State private var mainTabSelection = 1
    @State private var isTermsPresented = false
    @State private var userFaceUrl = ""
    @State private var isAudioControllerPresented = false
    @State private var isNewFeaturePresented = false
    @FocusState private var isSearchKeyboardFocused: Bool
    var body: some View {
        Group {
            if #available(iOS 18.0, watchOS 11.0, *) {
                mainTabView
            } else {
                compatibleMainTabView
            }
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
        .sheet(isPresented: $shouldShowFunderList) {
            FunderListView()
        }
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
        .onAppear {
            updateBiliTicket(csrf: biliJct)
            if dedeUserID != "" {
                Task {
                    if let info = await BiliAPI.shared.userInfo() {
                        userFaceUrl = info.face
                    }
                }
            }
        }
    }

    @available(iOS 18.0, watchOS 11.0, *)
    @ViewBuilder
    var mainTabView: some View {
        TabView(selection: $mainTabSelection) {
            Tab("navbar.suggest", systemImage: "sparkles", value: 1) {
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
            }
            Tab("navbar.my", systemImage: "person.fill", value: 2) {
                PersonAccountView()
            }
            Tab("排行榜", systemImage: "chart.bar.xaxis", value: 3) {
                RankingsView()
            }
            Tab("navbar.dynamic", systemImage: "rectangle.stack.fill", value: 4) {
                UserDynamicMainView()
            }
            #if !os(watchOS)
            Tab("搜索", systemImage: "magnifyingglass", value: 5, role: .search) {
                SearchMainView(isSearchKeyboardFocused: $isSearchKeyboardFocused)
            }
            #endif
        }
    }
    
    @ViewBuilder
    var compatibleMainTabView: some View {
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
            RankingsView()
                .tag(3)
                .tabItem {
                    Label("排行榜", systemImage: "chart.bar.xaxis")
                }
            UserDynamicMainView()
                .tag(4)
                .tabItem {
                    Label("navbar.dynamic", systemImage: "rectangle.stack.fill")
                }
            #if !os(watchOS)
            SearchMainView(isSearchKeyboardFocused: $isSearchKeyboardFocused)
                .tag(5)
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass")
                }
            #endif
        }
    }
}

struct TermsListView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("IsReadTerms") private var isReadTerms = false
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
                    """)
                Button(action: {
                    isReadTerms = true
                    dismiss()
                }, label: {
                    Text("Home.understand")
                })
                .buttonStyle(.borderedProminent)
            }
            .scenePadding(.horizontal)
        }
    }
}
private struct FunderListView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("您正在使用的喵哩喵哩测试通道由 Darock Community 的以下成员众筹支持")
                    .font(.system(size: 15))
                Text("已排序，贡献较大的已\(lustrousText("增辉"))")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                Spacer()
                    .frame(height: 10)
                if let url = Bundle.main.url(forResource: "FunderList", withExtension: "txt"),
                   let content = try? String(contentsOf: url, encoding: .utf8) {
                    ForEach(content.components(separatedBy: .newlines), id: \.self) { name in
                        if name.hasSuffix("[Lustre]") {
                            lustrousText(String(name.dropLast("[Lustre]".count)))
                        } else {
                            Text(name)
                        }
                    }
                }
                Spacer()
                    .frame(height: 10)
                Text("在 TestFlight 提供测试的开发者账户需要每年付费，众筹全额用于续费开发者账户，Darock 不从中盈利。")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
        }
    }

    private func lustrousText(_ content: String) -> Text {
        Text("\(content)\(Image(systemName: "sparkle"))")
            .foregroundColor(.yellow)
    }
}
