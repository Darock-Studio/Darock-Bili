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
                if debug {
                    Section {
                        NavigationLink(destination: {DebugMenuView()}, label: {
                            Text("调试")
                        })
                    }
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

struct DebugMenuView: View {
    var body: some View {
        List {
            NavigationLink(destination: {UserDetailView(uid: "3546572635768935")}, label: {
                Text("LongUIDUserTest")
            })
            NavigationLink(destination: {BuvidFpDebug()}, label: {
                Text("buvid_fpTest")
            })
            NavigationLink(destination: {UuidDebug()}, label: {
                Text("_uuid_Gen")
            })
            NavigationLink(destination: {Buvid34Debug()}, label: {
                Text("buvid3_4_actived")
            })
        }
    }

    struct BuvidFpDebug: View {
        @State var fp = ""
        @State var resu = ""
        var body: some View {
            List {
                TextField("fp", text: $fp)
                Button(action: {
                    do {
                        resu = try BuvidFp.gen(key: fp, seed: 31)
                    } catch {
                        resu = "Failed: \(error)"
                    }
                }, label: {
                    Text("Gen")
                })
                Text(resu)
            }
        }
    }
    struct UuidDebug: View {
        @State var uuid = ""
        var body: some View {
            List {
                Button(action: {
                    uuid = UuidInfoc.gen()
                }, label: {
                    Text("Gen")
                })
                Text(uuid)
            }
        }
    }
    struct Buvid34Debug: View {
        @State var activeBdUrl = "https://www.bilibili.com/"
        @State var locBuvid3 = ""
        @State var locBuvid4 = ""
        @State var locUplResp = ""
        var body: some View {
            List {
                Section {
                    Text("Current Global Buvid3: \(globalBuvid3)")
                    Text("Current Global Buvid4: \(globalBuvid4)")
                }
                Section {
                    TextField("activeBdUrl", text: $activeBdUrl)
                    Button(action: {
                        getBuvid(url: activeBdUrl.urlEncoded()) { buvid3, buvid4, _, resp in
                            locBuvid3 = buvid3
                            locBuvid4 = buvid4
                            locUplResp = resp
                        }
                    }, label: {
                        Text("Get new & active")
                    })
                    Text(locBuvid3)
                    Text(locBuvid4)
                    Text(locUplResp)
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
