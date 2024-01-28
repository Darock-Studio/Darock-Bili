//
//  AboutView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
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

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    @State var isEasterEgg1Presented = false
    @State var isGenshin = false
    @State var genshinOverlayTextOpacity: CGFloat = 0.0
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("喵哩喵哩 v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                    Text("编译时间: \(CodingTime.getCodingTime())")
                        .onTapGesture(count: 9) {
                            debug = true
                            tipWithText("You're now in Developer Mode", symbol: "hammer.circle.fill")
                        }
                    Text("遇到问题？在设置页面点击“反馈问题”进行反馈，感谢您的支持！")
                }
                Section(header: Text("Credits")) {
                    VStack {
                        Text("Darock Studio")
                        Label("来自 \(Text("Darock Studio").bold()) 的消息：欢迎加群 248036605 获取最新消息谢谢喵！", systemImage: "arrowshape.up")
                    }
                    Text("Lightning-Lion")
                    Text("Linecom")
                    Text("令枫")
                    Text("-- And You --")
                        .sheet(isPresented: $isEasterEgg1Presented, content: {EasterEgg1View(isGenshin: $isGenshin)})
                        .onTapGesture(count: 10) {
                            isEasterEgg1Presented = true
                        }
                }
                Section {
                    NavigationLink(destination: {OpenSource()}, label: {
                        Text("开源组件许可")
                    })
                }
            }
            .bold()
        }
        .navigationBarHidden(isGenshin)
        .overlay {
            if isGenshin {
                ZStack(alignment: .center) {
                    Color.white
                    Text("原神")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(.black)
                        .opacity(genshinOverlayTextOpacity)
                }
                .ignoresSafeArea()
                .animation(.smooth(duration: 2.0), value: genshinOverlayTextOpacity)
                .onAppear {
                    genshinOverlayTextOpacity = 1.0
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                        isGenshin = false
                        dismiss()
                    }
                }
            }
        }
    }
    struct OpenSource: View {
        var body: some View {
            ScrollView {
                Text("""
                --- Alamofire ---
                Licensed under MIT license
                -----------------
                
                --- Dynamic ---
                Licensed under Apache License 2.0
                ---------------
                
                --- EFQRCode ---
                Licensed under MIT license
                ----------------
                
                --- libwebp ---
                Licensed under BSD-3-Clause license
                ---------------
                
                --- SDWebImage ---
                Licensed under MIT license
                ------------------
                
                --- SDWebImagePDFCoder ---
                Licensed under MIT license
                --------------------------
                
                --- SDWebImageSVGCoder ---
                Licensed under MIT license
                --------------------------
                
                --- SDWebImageSwiftUI ---
                Licensed under MIT license
                -------------------------
                
                --- SDWebImageWebPCoder ---
                Licensed under MIT license
                ---------------------------
                
                --- SFSymbol ---
                Licensed under MIT license
                ----------------
                
                --- swift_qrcodejs ---
                Licensed under MIT license
                ----------------------
                
                --- SwiftyJSON ---
                Licensed under MIT license
                ------------------
                """)
            }
        }
    }
    
    // MARK: Easter Eggs
    struct EasterEgg1View: View {
        @Binding var isGenshin: Bool
        @Environment(\.dismiss) var dismiss
        @State var codeInput = ""
        var body: some View {
            VStack {
                TextField("神秘代码", text: $codeInput)
                Button(action: {
                    if codeInput == "Genshin" {
                        isGenshin = true
                        dismiss()
                    } else {
                        codeInput = "输入错误"
                    }
                }, label: {
                    Text("确认")
                })
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
