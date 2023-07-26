//
//  ContentView.swift
//  DarockBili
//
//  Created by WindowsMEMZ on 2023/7/22.
//

import SwiftUI
import DarockKit

struct ContentView: View {
    var body: some View {
        NStack {
            VStack {
                NeuText("您需要在 iPhone 上授予 Watch 网络权限", fontSize: 22)
                    .multilineTextAlignment(.center)
                NeuButton(action: {
                    DarockKit.Network.shared.requestString("https://api.darock.top") { respStr, isSuccess in
                        if isSuccess {
                            debugPrint(respStr)
                        }
                    }
                }, label: {
                    Text("授权")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 5)
                })
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
