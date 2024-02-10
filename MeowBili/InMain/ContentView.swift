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
    @State var mainTabSelection = 1
    //@State var isSystemVerTipPresented = false
    var body: some View {
        NavigationStack {
            TabView(selection: $mainTabSelection) {
                MainView(mainTabSelection: $mainTabSelection)
                    .tag(1)
                    .tabItem {
                        Label("推荐", systemImage: "sparkles")
                    }
                PersonAccountView()
                    .tag(2)
                    .tabItem {
                        Label("我的", systemImage: "person.fill")
                    }
                UserDynamicMainView()
                    .tag(3)
                    .tabItem {
                        Label("动态", systemImage: "rectangle.stack.fill")
                    }
            }
            .accessibility(identifier: "MainTabView")
            .onAppear {
//                if isFirstUsing {
//                    isGuidePresented = true
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
