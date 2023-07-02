//
//  AboutView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import SwiftUI
import CryptoKit

struct AboutView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("腕上哔哩 v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                    Text("遇到问题？下载\(Text("暗礁反馈").foregroundColor(.blue))（暂未上线），附带上方文本进行反馈")
                }
                Text("Powered by:")
                Text("Darock Studio")
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

#Preview {
    AboutView()
}
