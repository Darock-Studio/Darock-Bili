//
//  NetworkFixView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
//

import SwiftUI
import DarockKit
import Foundation

struct NetworkFixView: View {
    @State var fixingItem = ""
    @State var isProgressAdding = true
    @State var progressTimer: Timer?
    @State var progress = 0.0
    @State var troubles = [String]()
    @State var isFinish = false
    @State var isDarockIssue = false
    @State var isNetworkIssue = false
    var body: some View {
        NavigationStack {
            VStack {
                if !isFinish {
                    ProgressView(value: progress, total: 100.0)
                        .progressViewStyle(.linear)
                        .foregroundColor(.blue)
                    Text("正在\(fixingItem)")
                } else {
                    if troubles.count != 0 {
                        List {
                            Section {
                                Text("疑难解答找到的问题：")
                            }
                            Section {
                                ForEach(0...troubles.count - 1, id: \.self) { i in
                                    Text(troubles[i])
                                        .bold()
                                        .onAppear {
                                            if troubles[i].contains("Darock") {
                                                isDarockIssue = true
                                            } else if troubles[i] == "无法访问互联网" {
                                                isNetworkIssue = true
                                            }
                                        }
                                }
                            }
                            if isNetworkIssue {
                                Section {
                                    NavigationLink(destination: {UserNetworkGuide()}, label: {
                                        Text("问题来自您的网络连接，点此查看网络说明")
                                    })
                                }
                            }
                            if isDarockIssue {
                                Section {
                                    Text("问题可能来自 Darock，请联系开发者或等待问题解决")
                                }
                            }
                        }
                    } else {
                        Text("疑难解答无法确定问题")
                        Text("请重试之前的操作，如果问题依然存在，请联系开发者")
                    }
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                progressTimer = timer
                if isProgressAdding {
                    progress += 0.5
                    if progress >= 100.0 {
                        isProgressAdding = false
                    }
                } else {
                    progress -= 0.5
                    if progress <= 0.0 {
                        isProgressAdding = true
                    }
                }
            }
            fixingItem = "检查：网络连接"
            let randTime = Double.random(in: 3.5...7.0)
            Timer.scheduledTimer(withTimeInterval: randTime, repeats: false) { timer in
                timer.invalidate()
                
                DarockKit.Network.shared.requestString("https://apple.com.cn") { _, isSuccess in
                    if isSuccess {
                        fixDarock()
                    } else {
                        troubles.append("无法访问互联网")
                        isFinish = true
                    }
                }
                
                func fixDarock() {
                    fixingItem = "检查：Darock API"
                    DarockKit.Network.shared.requestString("https://api.darock.top") { respStr, isSuccess in
                        if isSuccess {
                            if respStr.apiFixed() == "OK" {
                                
                            } else {
                                troubles.append("Darock API 响应无效")
                            }
                        } else {
                            troubles.append("Darock API 不可访问")
                        }
                        fixBili()
                    }
                }
                
                func fixBili() {
                    fixingItem = "检查：Bilibili API"
                    DarockKit.Network.shared.requestString("https://api.bilibili.com/") { _, isSuccess in
                        if isSuccess {
                            
                        } else {
                            troubles.append("Bilibili API 不可访问")
                        }
                        isFinish = true
                    }
                }
            }
        }
        .onDisappear {
            progressTimer?.invalidate()
        }
    }
}

struct UserNetworkGuide: View {
    var body: some View {
        List {
            Section {
                Text("网络说明")
            }
            Section {
                Text("您应当确认：")
                    .bold()
                Text("Watch 的状态栏（控制中心上方）显示为\(Image(systemName: "wifi"))而不是\(Image(systemName: "iphone"))")
            }
            Section {
                Text("怎么做？")
                Text("关闭 iPhone 的 Wi-Fi 以及蓝牙")
                    .bold()
            }
        }
    }
}

#Preview {
    NetworkFixView()
}
