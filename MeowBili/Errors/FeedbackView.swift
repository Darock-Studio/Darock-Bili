//
//
//  FeedbackView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
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
import EFQRCode

//struct FeedbackView: View {
//    @Environment(\.dismiss) var dismiss
//    @State var choseFeedbackType = "错误/异常行为"
//    @State var title = ""
//    @State var detail = ""
//    @State var isLoading = false
//    @State var sendStep = ""
//    @State var feedbackCode = ""
//    var body: some View {
//        List {
//            Section {
//                Picker(selection: $choseFeedbackType, label: Text("反馈类型")) {
//                    Text("错误/异常行为").tag("错误/异常行为")
//                    Text("建议").tag("建议")
//                }
//            }
//            Section(footer: Text("简单地描述问题")) {
//                TextField("标题", text: $title)
//            }
//            Section(footer: Text("描述发生问题前做了什么？预期的结果？实际的结果？")) {
//                TextField("详细信息", text: $detail)
//            }
//            Section {
//                Text("您的 App 版本将会一并被发送")
//                Text("发送的反馈中不含任何您的个人信息")
//                Text("请不要在问题描述中填写个人信息")
//            }
//            Section {
//                Button(action: {
//                    isLoading = true
//                }, label: {
//                    Text("发送")
//                })
//                .sheet(isPresented: $isLoading, onDismiss: {
//                    dismiss()
//                }, content: {
//                    VStack {
//                        if feedbackCode == "" {
//                            ProgressView()
//                            Text("正在发送...")
//                                .onAppear {
//                                    DarockKit.Network.shared.requestString("https://api.darock.top/bili/feedback/\(("类型：\(choseFeedbackType)\n标题：\(title)\n详细信息：\(detail)\n版本：v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)").base64Encoded().replacingOccurrences(of: "/", with: "{slash}"))") { respStr, isSuccess in
//                                        if isSuccess {
//                                            feedbackCode = respStr
//                                        }
//                                    }
//                                }
//                            //Text("正在\(sendStep)")
//                        } else {
//                            Text("反馈成功！后续可使用反馈 ID：\(Text(feedbackCode).font(.system(size: 18, design: .monospaced)).bold()) 跟进情况")
//                        }
//                    }
//
//                })
//            }
//        }
//    }
//}

struct FeedbackView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://github.com/Darock-Studio/Darock-Bili/issues")!)
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
