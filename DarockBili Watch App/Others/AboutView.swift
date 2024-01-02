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
     var body: some View {
         NavigationStack {
            List {
                Section {
                    Text("喵哩喵哩 v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                    Text("编译时间: \(CodingTime.getCodingTime())")
                    Text("遇到问题？在设置页面点击“反馈问题”进行反馈，感谢您的支持！")
                }
                Section(header: Text("Credits")) {
                    VStack {
                        Text("Darock Studio")
                        Label("来自 \(Text("Darock Studio").bold()) 的消息：欢迎加群 248036605 获取最新消息谢谢喵！", systemImage: "arrowshape.up")
                    }
                    Text("ThreeManager785")
                    Text("Lightning-Lion")
                    Text("Linecom")
                    Text("-- And You --")
                }
                Section {
                    NavigationLink(destination: {OpenSource()}, label: {
                        Text("开源组件许可")
                    })
                }
            }
            .bold()
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
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
