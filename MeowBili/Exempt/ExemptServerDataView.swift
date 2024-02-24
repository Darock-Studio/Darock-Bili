//
//
//  ExemptServerDataView.swift
//  DarockBili
//
//  Created by memz233 on 2024/2/24.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI

struct ExemptServerDataView: View {
    @Binding var serverBind: String
    @State var serverInput = ""
    @State var isHelpPresented = false
    var body: some View {
        List {
            Section {
                TextField("服务器地址", text: $serverInput)
                #if !os(watchOS)
                    .textFieldStyle(.roundedBorder)
                #endif
                    .submitLabel(.continue)
                    .onSubmit {
                        if serverInput != "" {
                            UserDefaults.standard.set(serverInput, forKey: "APIServer")
                            serverBind = serverInput
                        }
                    }
            }
            Section {
                Button(action: {
                    isHelpPresented = true
                }, label: {
                    Text("这是什么？")
                        .foregroundStyle(Color.blue)
                })
                .sheet(isPresented: $isHelpPresented) {
                    NavigationStack {
                        ScrollView {
                            VStack {
                                Text("""
                                暗礁流媒体高度可自定义，您需要一个可用的服务器地址以供 App 获取视频等信息。
                                
                                您可以搭建自己的服务器，也可以在网络上查找符合 Darock Video Protocol 协议的公开服务器
                                """)
                                Link("自建服务器帮助", destination: URL(string: "https://darock.top/dvp/help")!)
                            }
                        }
                    }
                }
            }
            Section {
                Text("请确认您对您输入的链接拥有访问权限，视频内容由您输入的服务提供商提供，Darock 不对其内容负责")
            }
        }
    }
}
