//
//
//  NetwokFixView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import DarockUI
import Alamofire
import SwiftyJSON
import Foundation
import DarockFoundation

struct NetworkFixView: View {
    @State var progressTimer: Timer?
    @State var networkState = 0
    @State var darockAPIState = 0
    @State var bilibiliAPIState = 0
    @State var isTroubleshooting = false
    // 0 尚未检查
    // 1 正在检查
    // 2 不可用
    // 3 可用
    // 4 无效返回
    var lightColors: [Color] = [.secondary, .orange, .red, .green, .red]
    var body: some View {
        NavigationStack {
            List {
                Section {
                    if !isTroubleshooting {
                        if networkState == 3 && darockAPIState == 3 && bilibiliAPIState == 3 {
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                Text("Troubleshoot.fine")
                                    .bold()
                            }
                            NavigationLink(destination: { FeedbackView() }, label: {
                                VStack(alignment: .leading) {
                                    Text("Troubleshoot.fine.weird")
                                    Text("Troubleshoot.feedback")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }
                            })
                        } else {
                            Text("Troubleshoot.problems-found")
                                .bold()
                            if networkState == 2 {
                                NavigationLink(destination: { NetworkProblemDetailsView() }, label: {
                                    Text("Troubleshoot.problems.internet")
                                })
                            }
                            if darockAPIState == 2 || darockAPIState == 4 {
                                NavigationLink(destination: { DarockAPIProblemDetailsView() }, label: {
                                    Text(darockAPIState == 2 ? "Troubleshoot.problems.darock-api.unavailable" : "Troubleshoot.problems.darock-api.invalid-return")
                                })
                            }
                            if bilibiliAPIState == 2 {
                                NavigationLink(destination: { BilibiliAPIProblemDetailsView() }, label: {
                                    Text("Troubleshoot.problems.bilibili-api.unavailable")
                                })
                            }
                        }
                    } else {
                        HStack {
                            ProgressView()
                            Text("Troubleshoot.troubleshooting")
                                .bold()
                        }
                    }
                } footer: {
                    if !(networkState == 3 && darockAPIState == 3 && bilibiliAPIState == 3) {
                        Text("Troubleshoot.problem.tips") //轻点问题以查看详细信息
                    }
                }
                Section("Troubleshoot.connection-states") {
                    HStack {
                        Circle()
                            .frame(width: 10)
                            .foregroundStyle(lightColors[networkState])
                            .padding(.trailing, 7)
                        if networkState == 0 {
                            Text("Troubleshoot.internet")
                        } else if networkState == 1 {
                            HStack {
                                ProgressView()
                                Text("Troubleshoot.internet.checking")
                            }
                        } else if networkState == 2 {
                            Text("Troubleshoot.internet.offline")
                        } else if networkState == 3 {
                            Text("Troubleshoot.internet.online")
                        }
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Circle()
                            .frame(width: 10)
                            .foregroundStyle(lightColors[darockAPIState])
                            .padding(.trailing, 7)
                        if darockAPIState == 0 {
                            Text("Troubleshoot.darock-api")
                                .foregroundStyle(networkState != 3 ? Color.secondary : .primary)
                        } else if darockAPIState == 1 {
                            HStack {
                                ProgressView()
                                Text("Troubleshoot.darock-api.checking")
                            }
                        } else if darockAPIState == 2 {
                            Text("Troubleshoot.darock-api.unavailable")
                        } else if darockAPIState == 3 {
                            Text("Troubleshoot.darock-api.available")
                        } else if darockAPIState == 4 {
                            Text("Troubleshoot.darock-api.invalid-return")
                        }
                        Spacer()
                    }
                    .disabled(networkState != 3)
                    .padding()
                    HStack {
                        Circle()
                            .frame(width: 10)
                            .foregroundStyle(lightColors[bilibiliAPIState])
                            .padding(.trailing, 7)
                        if bilibiliAPIState == 0 {
                            Text("Troubleshoot.bilibili-api")
                                .foregroundStyle(networkState != 3 ? Color.secondary : .primary)
                        } else if bilibiliAPIState == 1 {
                            HStack {
                                ProgressView()
                                Text("Troubleshoot.bilibili-api.checking")
                            }
                        } else if bilibiliAPIState == 2 {
                            Text("Troubleshoot.bilibili-api.unavailable")
                        } else if bilibiliAPIState == 3 {
                            Text("Troubleshoot.bilibili-api.available")
                        }
                        Spacer()
                    }
                    .disabled(networkState != 3)
                    .padding()
                    Button(action: {
                        isTroubleshooting = true
                        networkState = 0
                        darockAPIState = 0
                        bilibiliAPIState = 0
                        checkInternet()
                        func checkInternet() {
                            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                                timer.invalidate()
                                networkState = 1
                                requestString("https://apple.com.cn") { _, isSuccess in
                                    if isSuccess {
                                        darockAPIState = 1
                                        requestAPI("/") { respStr, isSuccess in
                                            if isSuccess {
                                                if respStr.apiFixed() == "OK" {
                                                    darockAPIState = 3
                                                } else {
                                                    darockAPIState = 4
                                                }
                                            } else {
                                                darockAPIState = 1
                                            }
                                            bilibiliAPIState = 2
                                            requestString("https://api.bilibili.com/") { _, isSuccess in
                                                if isSuccess {
                                                    bilibiliAPIState = 3
                                                } else {
                                                    bilibiliAPIState = 2
                                                }
                                            }
                                            isTroubleshooting = false
                                        }
                                        networkState = 3
                                    } else {
                                        networkState = 2
                                        isTroubleshooting = false
                                    }
                                }
                            }
                        }
                    }, label: {
                        Text(isTroubleshooting ? "Troubleshoot.troubleshooting" : "Troubleshoot.re-troubleshoot")
                    })
                    .disabled(isTroubleshooting)
                }
            }
            /* VStack {
                if !isFinish {
                    ProgressView(value: progress, total: 100.0)
                        .progressViewStyle(.linear)
                        .foregroundColor(.blue)
                    Text("正在\(fixingItem)")
                } else {
                    if troubles.count != 0 {
                        List {
                            Section {
                                Text("Troubleshooter.what-we-found")
                            }
                            Section {
                                ForEach(0...troubles.count - 1, id: \.self) { i in
                                    Text(troubles[i])
                                        .bold()
                                        .onAppear {
                                            if troubles[i].contains("Darock") {
                                                isDarockIssue = true
                                            } else if troubles[i] == "Troubleshooter.no-internet" {
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
                        Text("Troubleshooter.failed")
                        Text("Troubleshooter.failed.discription") //请重试之前的操作，如果问题依然存在，请联系开发者
                    }
                }
            }*/
        }
        .onAppear {
            isTroubleshooting = true
            networkState = 0
            darockAPIState = 0
            bilibiliAPIState = 0
            checkInternet()
            func checkInternet() {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                    timer.invalidate()
                    networkState = 1
                    requestString("https://baidu.com") { _, isSuccess in
                        if isSuccess {
                            darockAPIState = 1
                            requestAPI("/") { respStr, isSuccess in
                                Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { timer in
                                    if isSuccess {
                                        if respStr.apiFixed() == "OK" {
                                            darockAPIState = 3
                                        } else {
                                            darockAPIState = 4
                                            isTroubleshooting = false
                                        }
                                    } else {
                                        darockAPIState = 4
                                        isTroubleshooting = false
                                    }
                                    timer.invalidate()
                                }
                                bilibiliAPIState = 2
                                requestString("https://api.bilibili.com/") { _, isSuccess in
                                    if isSuccess {
                                        bilibiliAPIState = 3
                                    } else {
                                        bilibiliAPIState = 2
                                    }
                                }
                                isTroubleshooting = false
                            }
                            networkState = 3
                        } else {
                            networkState = 2
                            isTroubleshooting = false
                        }
                    }
                }
            }
        }
        .onDisappear {
            progressTimer?.invalidate()
        }
    }
}

struct NetworkProblemDetailsView: View {
    var body: some View {
        List {
            Section {
                Text("Troubleshoot.problem.internet")
                    .bold()
            }
            Section("Troubleshoot.problem.meaning") {
                Text("Troubleshoot.problem.internet.meaning")
            }
            Section("Troubleshoot.problem.solution") {
                Text("Troubleshoot.problem.internet.solution1")
                Text("Troubleshoot.problem.internet.solution2")
            }
            Section("Troubleshoot.problem.plan-b") {
                Text("Troubleshoot.problem.internet.plan-b")
            }
        }
    }
}

struct DarockAPIProblemDetailsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Troubleshoot.problem.darock-api")
                        .bold()
                }
                Section("Troubleshoot.problem.meaning") {
                    Text("Troubleshoot.problem.darock-api.meaning")
                }
                Section("Troubleshoot.problem.solution") {
                    Text("Troubleshoot.problem.darock-api.solution")
                }
            }
        }
    }
}

struct BilibiliAPIProblemDetailsView: View {
    var body: some View {
        List {
            Section {
                Text("Troubleshoot.problem.bilibili-api")
                    .bold()
            }
            Section("Troubleshoot.problem.meaning") {
                Text("Troubleshoot.problem.bilibili-api.meaning")
            }
            Section("Troubleshoot.problem.solution") {
                Text("Troubleshoot.problem.bilibili-api.solution")
            }
        }
    }
}

/* struct UserNetworkGuide: View {
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
} */

let errorCodeTextDic = [
    -1: "应用程序不存在或已被封禁",
    -2: "Access Key 错误",
    -3: "API 校验密匙错误",
    -4: "调用方对该 Method 没有权限",
    -101: "账号未登录",
    -102: "账号被封停",
    -103: "积分不足",
    -104: "硬币不足",
    -105: "验证码错误",
    -106: "账号非正式会员或在适应期",
    -107: "应用不存在或者被封禁",
    -108: "未绑定手机",
    -110: "未绑定手机",
    -111: "csrf 校验失败",
    -112: "系统升级中",
    -113: "账号尚未实名认证",
    -114: "请先绑定手机",
    -115: "请先完成实名认证",
    -304: "木有改动",
    -307: "撞车跳转",
    -400: "请求错误",
    -401: "未认证 / 非法请求",
    -403: "访问权限不足",
    -404: "啥都木有",
    -405: "不支持该方法",
    -409: "冲突",
    -412: "请求被拦截",
    -500: "服务器错误",
    -503: "过载保护,服务暂不可用",
    -504: "服务调用超时",
    -509: "超出限制",
    -616: "上传文件不存在",
    -617: "上传文件太大",
    -625: "登录失败次数太多",
    -626: "用户不存在",
    -628: "密码太弱",
    -629: "用户名或密码错误",
    -632: "操作对象数量限制",
    -643: "被锁定",
    -650: "用户等级太低",
    -652: "重复的用户",
    -658: "Token 过期",
    -662: "密码时间戳过期",
    -688: "地理区域限制",
    -689: "版权限制",
    -701: "扣节操失败",
    -799: "请求过于频繁，请稍后再试",
    -8888: "对不起，服务器开小差了~"
]

public func CheckBApiError(from input: JSON, noTip: Bool = false) -> Bool {
    let code = input["code"].int ?? 0
    if code == 0 {
        return true
    }
    let msg = errorCodeTextDic[code] ?? (input["message"].string ?? "")
    if !noTip {
        tipWithText(msg, symbol: "xmark.circle.fill")
    }
    return false
}

struct NetworkFixView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkFixView()
    }
}
