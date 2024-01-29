//
//  ContentView.swift
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

struct ContentView: View {
    public static var nowAppVer = "1.0.0|106"
    @AppStorage("IsFirstUsing") var isFirstUsing = true
    @AppStorage("LastUsingVer") var lastUsingVer = ""
    @AppStorage("IsReadTerms") var isReadTerms = false
    @State var isTermsPresented = false
    //@State var isSystemVerTipPresented = false
    var body: some View {
        NavigationStack {
            TabView {
                MainView()
                    .tag(1)
//                PersonAccountView()
//                    .tag(2)
                UserDynamicMainView()
                    .tag(2)
            }
            .accessibility(identifier: "MainTabView")
            .sheet(isPresented: $isTermsPresented, onDismiss: {
                isReadTerms = true
            }, content: {TermsListView()})
            .onAppear {
//                if isFirstUsing {
//                    isGuidePresented = true
//                }
                if !isReadTerms {
                    isTermsPresented = true
                }
            }
//            .sheet(isPresented: $isSystemVerTipPresented, onDismiss: {
//                isNoTipSystemVer = true
//            }, content: {
//                ScrollView {
//                    VStack {
//                        Text("您正在使用支持度低的版本")
//                            .font(.system(size: 18, weight: .bold))
//                        Spacer()
//                            .frame(height: 20)
//                        Text("喵哩喵哩目前主要支持 watchOS 10，使用旧版本系统可能会遇到更多的问题，建议更新新版本系统。")
//                            .multilineTextAlignment(.center)
//                    }
//                }
//            })
        }
    }
}

struct TermsListView: View {
    @Environment(\.dismiss) var dismiss
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
