//
//  ErrorGetView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
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

struct ErrorGetView: View {
    var error: GetableError
    @Environment(\.dismiss) var dismiss
    @State var doing = ""
    @State var isClosePresented = false
    @State var isSendPresented = false
    @State var isSent = false
    @State var sentCode = ""
    @State var isError = false
    @State var isNetworkFixPresented = false
    var body: some View {
        ScrollView {
            Group {
                Text("出现问题！")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                    .frame(height: 15)
                Text("非常抱歉，喵哩喵哩在 \(error.when) 时出现了问题。\(error.ignoreable ? "" : "应用程序无法正常运行")")
                if error.area == "网络请求" {
                    Spacer()
                        .frame(height: 15)
                    Button(action: {
                        isNetworkFixPresented = true
                    }, label: {
                        Text("错误与网络有关，您应当先点此尝试 网络疑难解答")
                    })
                    .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
                }
                Spacer()
                    .frame(height: 10)
                Text("以下为错误详情：")
                Text("范围：\(error.area)")
                Text("位置：\(error.inAppArea)")
                Text("详细信息：\(error.errDetail)")
                Spacer()
                    .frame(height: 15)
            }
            Group {
                if error.sendable {
                    Text("您可以将此信息发送至 Darock 以帮助我们改进喵哩喵哩")
                    Spacer()
                        .frame(height: 10)
                    Text("发送的信息中不含任何您的个人信息")
                    TextField("发生问题前...(选填)", text: $doing)
                    Spacer()
                        .frame(height: 15)
                    Button(action: {
                        isSendPresented = true
                    }, label: {
                        Text("发送")
                            .bold()
                    })
                    .sheet(isPresented: $isSendPresented, content: {
                        VStack {
                            if !isSent {
                                ProgressView()
                                Text("正在发送...")
                                    .bold()
                                Text("感谢您的支持！")
                                    .bold()
                            } else {
                                Text("已发送")
                                    .bold()
                                Text("案例编号为 \(Text(sentCode).font(.system(size: 18, design: .monospaced))) 后续可通过此编号跟进状态")
                                    .font(.system(size: 18, weight: .bold))
                                if error.ignoreable {
                                    Button(action: {
                                        dismiss()
                                    }, label: {
                                        Text("返回")
                                            .bold()
                                    })
                                } else {
                                    Button(action: {
                                        exit(114514)
                                    }, label: {
                                        Text("退出程序")
                                            .bold()
                                    })
                                }
                            }
                        }
                        .onAppear {
                            DarockKit.Network.shared.requestString("https://api.darock.top/bili/feedback/\(("范围：\(error.area)\n位置：\(error.inAppArea)\n详细信息：\(error.errDetail)\n用户描述：\(doing)").base64Encoded())") { respStr, isSuccess in
                                if isSuccess {
                                    sentCode = respStr
                                    isSent = true
                                }
                            }
                        }
                    })
                    Button(action: {
                        if error.ignoreable {
                            dismiss()
                        } else {
                            isClosePresented = true
                        }
                    }, label: {
                        Text("不发送")
                    })
                    .sheet(isPresented: $isClosePresented, content: {
                        Text("即将退出...")
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                                    timer.invalidate()
                                    exit(114514)
                                }
                            }
                    })
                } else {
                    Text("此错误无需或无法发送至 Darock")
                }
            }
        }
    }
}

struct GetableError {
    let when: String
    let area: String
    let inAppArea: String
    let errDetail: String
    var ignoreable: Bool = true
    var sendable: Bool = true
}

struct ErrorGetView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorGetView(error: GetableError(when: "Test", area: "Test", inAppArea: "Test", errDetail: "Test"))
    }
}
