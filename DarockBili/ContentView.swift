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
        VStack {
            Text("您需要在 iPhone 上授予 Watch 网络权限")
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
            Button(action: {
                DarockKit.Network.shared.requestString("https://api.darock.top") { respStr, isSuccess in
                    if isSuccess {
                        debugPrint(respStr)
                    }
                }
            }, label: {
                Text("授权")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
