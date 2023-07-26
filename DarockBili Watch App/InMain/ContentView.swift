//
//  ContentView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI

struct ContentView: View {
    public static var nowAppVer = "1.0.0|106"
    @AppStorage("IsFirstUsing") var isFirstUsing = true
    @AppStorage("LastUsingVer") var lastUsingVer = ""
    @AppStorage("IsNoTipSystemVer") var isNoTipSystemVer = false
    @State var isGuidePresented = false
    @State var isSystemVerTipPresented = false
    var body: some View {
        NavigationStack {
            TabView {
                MainView()
                    .tag(1)
                PersonAccountView()
                    .tag(2)
            }
            .sheet(isPresented: $isGuidePresented, onDismiss: {
                isFirstUsing = false
            }, content: {FirstUsingView()})
            .onAppear {
                if isFirstUsing {
                    isGuidePresented = true
                }
                if !isNoTipSystemVer {
                    if #unavailable(watchOS 10) {
                        isSystemVerTipPresented = true
                    }
                }
            }
            .sheet(isPresented: $isSystemVerTipPresented, onDismiss: {
                isNoTipSystemVer = true
            }, content: {
                ScrollView {
                    VStack {
                        Text("您正在使用支持度低的版本")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                            .frame(height: 20)
                        Text("喵哩喵哩目前主要支持 watchOS 10，使用旧版本系统可能会遇到更多的问题，建议更新新版本系统。")
                            .multilineTextAlignment(.center)
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
