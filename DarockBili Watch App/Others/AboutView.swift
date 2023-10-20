//
//  AboutView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import SwiftUI
import EFQRCode
import AuthenticationServices

struct AboutView: View {
    @State var easterEggText = ""
    @State var rexEasterEggColor = Color.white
    @State var rexEasterEggCount = 0
    @State var isEasterEggPresented = false
    @State var isEasterEgg2Presented = false
    var body: some View {
         NavigationStack {
            List {
                Section {
                    Text("喵哩喵哩 v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                    Text("编译时间: \(CodingTime.getCodingTime())")
                    Text("遇到问题？在设置页面点击“反馈问题”进行反馈，感谢您的支持！")
                }
                Section {
                    Text("Credits:")
                    Text("Darock Studio")
                        .onTapGesture(count: 5) {
                            if easterEggText == "" {
                                easterEggText = "继续？"
                            } else {
                                easterEggText = "不是这里！"
                            }
                        }
                    Label("来自 \(Text("Darock Studio").bold()) 的消息：欢迎加群 248036605 获取最新消息谢谢喵！", systemImage: "arrowshape.up")
                        .onTapGesture(count: 14) {
                            isEasterEgg2Presented = true
                        }
                        .sheet(isPresented: $isEasterEgg2Presented, content: {EasterEgg2View()})
                    Text("ReX")
                        .foregroundColor(rexEasterEggColor)
                        .onTapGesture {
                            if easterEggText == "继续？" || easterEggText == "不是这里！" {
                                rexEasterEggCount += 1
                                if rexEasterEggCount == 6 {
                                    rexEasterEggColor = .red
                                } else if rexEasterEggCount == 7 {
                                    rexEasterEggColor = .orange
                                } else if rexEasterEggCount == 8 {
                                    rexEasterEggColor = .yellow
                                } else if rexEasterEggCount == 9 {
                                    rexEasterEggColor = .green
                                } else if rexEasterEggCount == 10 {
                                    rexEasterEggColor = .cyan
                                } else if rexEasterEggCount == 11 {
                                    rexEasterEggColor = .blue
                                } else if rexEasterEggCount == 12 {
                                    rexEasterEggColor = .purple
                                } else if rexEasterEggCount == 13 {
                                    rexEasterEggColor = .white
                                    isEasterEggPresented = true
                                }
                            }
                            debugPrint(rexEasterEggCount)
                        }
                        .sheet(isPresented: $isEasterEggPresented, content: {EasterEggView()})
                    Button(action: {
                        let session = ASWebAuthenticationSession(url: URL(string: "https://wear.rexwe.net")!, callbackURLScheme: nil) { _, _ in
                            
                        }
                        session.prefersEphemeralWebBrowserSession = true
                        session.start()
                    }, label: {
                        Label("来自ReX的消息：界面与交互设计来自 腕上生花 - ReX Design（wear.rexwe.net）", systemImage: "arrowshape.up")
                    })
                }
                Section {
                    NavigationLink(destination: {OpenSource()}, label: {
                        Text("开源组件许可")
                    })
                }
            }
            .navigationTitle(easterEggText)
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
    struct EasterEggView: View {
        @State var isDetailPresented = false
        var body: some View {
            VStack {
                Text("是...边缘的风景。")
                    .onTapGesture(count: 10) {
                        isDetailPresented = true
                    }
                    .sheet(isPresented: $isDetailPresented, content: {UserDetailView(uid: "342729006")})
            }
            .padding()
        }
    }
    struct EasterEgg2View: View {
        @State var inputPwdCache = ""
        @State var tipText = ""
        @State var errTimes = 0
        @State var isArchivePresented = false
        var body: some View {
            VStack {
                Text("您有一份惊喜礼包可领取！")
                TextField("输入密码", text: $inputPwdCache)
                    .onSubmit {
                        if inputPwdCache == "114514" {
                            isArchivePresented = true
                        } else {
                            errTimes += 1
                            tipText = "密码错误！"
                        }
                    }
                    .sheet(isPresented: $isArchivePresented, content: {ArchiveView()})
                Text(tipText)
                if errTimes >= 3 {
                    Text("密码提示：纯数字")
                }
            }
        }
        
        struct ArchiveView: View {
            var body: some View {
                VStack {
                    Image(uiImage: UIImage(cgImage: EFQRCode.generate(for: "https://darock.top/Archive.zip")!))
                        .resizable()
                        .frame(width: 120, height: 120)
                    Text("手机扫码领取")
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
