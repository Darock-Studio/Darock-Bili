//
//  AboutView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
         NavigationStack {
            List {
                Section {
                    Text("喵哩喵哩 v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                    Text("编译时间: \(CodingTime.getCodingTime())")
                    Text("版本签名：\n#1: \("*Darock \(CodingTime.getCodingTime()) \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String) Salt*".DDMD5Encrypt(.lowercase16))\n#2: \("*Darock \(CodingTime.getCodingTime()) \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String) Salt*".DDMD5Encrypt(.lowercase32))")
                    Text("遇到问题？在设置页面点击“反馈问题”进行反馈，感谢您的支持！")
                }
                Section {
                    Text("Credits:")
                    Text("Darock Studio")
                    Label("来自 \(Text("Darock Studio").bold()) 的消息：欢迎加群 248036605 获取最新消息谢谢喵！", systemImage: "arrowshape.up")
                    Text("ReX\n\(Text("帮助了点UI").font(.system(size: 14, weight: .regular)).foregroundColor(.gray))")
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
