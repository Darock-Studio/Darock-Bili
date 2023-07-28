//
//  ContentView.swift
//  DarockBili
//
//  Created by WindowsMEMZ on 2023/7/22.
//

import SwiftUI
import DarockKit

struct ContentView: View {
    @AppStorage("IsNetworkGetted") var isNetworkGetted = false
    var body: some View {
        NStack {
            VStack {
                NeuText("您需要在 iPhone 上授予 Apple Watch 网络权限", fontSize: 22)
                    .multilineTextAlignment(.center)
                NeuButton(action: {
                    DarockKit.Network.shared.requestString("https://api.darock.top") { respStr, isSuccess in
                        if isSuccess {
                            debugPrint(respStr)
                            isNetworkGetted = true
                        }
                    }
                }, label: {
                    Text("授权")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 5)
                })
                if isNetworkGetted {
                    NeuText("已授权", fontSize: 22)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
