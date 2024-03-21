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
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import DarockKit
import EFQRCode

#if os(watchOS)
struct FeedbackView: View {
    @State var qrImage: CGImage?
    var body: some View {
        VStack {
            if qrImage != nil {
                Image(uiImage: UIImage(cgImage: qrImage!))
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Feedback.continue-on-other-device")
                    .bold()
                NavigationLink(destination: { InAppFeedbackView() }, label: {
                    Text("在App内反馈")
                        .bold()
                        .foregroundStyle(Color.blue)
                })
                .buttonStyle(.plain)
            }
        }
        .onAppear {
            if let image = EFQRCode.generate(for: "https://github.com/Darock-Studio/Darock-Bili/issues") {
                qrImage = image
            }
        }
    }
}
#else
struct FeedbackView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://github.com/Darock-Studio/Darock-Bili/issues")!)
        }
    }
}
#endif

fileprivate let globalStates = ["未标记", "按预期工作", "无法修复", "问题重复", "搁置", "正在修复", "已在未来版本修复", "已修复", "正在加载", "未能复现", "问题并不与App相关。", "需要更多细节"]
fileprivate let globalStateColors = [Color.secondary, Color.red, Color.red, Color.red, Color.orange, Color.orange, Color.orange, Color.green, Color.secondary, Color.red, Color.secondary, Color.orange]
fileprivate let globalStateIcons = ["minus", "curlybraces", "xmark", "arrow.triangle.merge", "books.vertical", "hammer", "clock.badge.checkmark", "checkmark", "ellipsis", "questionmark", "bolt.horizontal", "arrowshape.turn.up.backward.badge.clock"]

struct InAppFeedbackView: View {
    @State var feedbackIds = [String]()
    var body: some View {
        List {
            Section {
                NavigationLink(destination: { NewFeedbackView() }, label: {
                    Label("新建反馈", systemImage: "exclamationmark.bubble.fill")
                })
            }
            if feedbackIds.count != 0 {
                Section {
                    ForEach(0..<feedbackIds.count, id: \.self) { i in
                        NavigationLink(destination: { FeedbackDetailView(id: feedbackIds[i]) }, label: {
                            Text("ID: \(feedbackIds[i])")
                        })
                        .swipeActions {
                            Button(role: .destructive, action: {
                                feedbackIds.remove(at: i)
                                UserDefaults.standard.set(feedbackIds, forKey: "RadarFBIDs")
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                            })
                        }
                    }
                } header: {
                    Text("发送的反馈")
                }
            }
        }
        .navigationTitle("反馈助理")
        .onAppear {
            feedbackIds = UserDefaults.standard.stringArray(forKey: "RadarFBIDs") ?? [String]()
        }
    }
    
    struct NewFeedbackView: View {
        @Environment(\.dismiss) var dismiss
        @State var titleInput = ""
        @State var contentInput = ""
        @State var feedbackType = 0
        @State var isSending = false
        var body: some View {
            List {
                Section {
                    TextField("标题", text: $titleInput)
                } footer: {
                    Text("简洁地描述问题")
                }
                Section {
                    TextField("详情", text: $contentInput)
                }
                Section {
                    Picker("反馈类型", selection: $feedbackType) {
                        Text("错误/异常行为").tag(0)
                        Text("建议").tag(1)
                    }
                }
                Section {
                    Button(action: {
                        if titleInput == "" {
                            #if os(watchOS) || os(visionOS)
                            tipWithText("标题不能为空", symbol: "xmark.circle.fill")
                            #else
                            AlertKitAPI.present(title: "标题不能为空", icon: .error, style: .iOS17AppleMusic, haptic: .error)
                            #endif
                            return
                        }
                        isSending = true
                        #if os(watchOS)
                        let banId = WKInterfaceDevice.current().identifierForVendor?.uuidString ?? "nil"
                        #else
                        let banId = UIDevice.current.identifierForVendor?.uuidString ?? "nil"
                        #endif
                        let msgToSend = """
                        \(titleInput)
                        State：0
                        Type：\(feedbackType)
                        Content：\(contentInput)
                        Version：v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)
                        Time：\(Date.now.timeIntervalSince1970)
                        Sender: User
                        BanID：\(banId)
                        BanUID：\(UserDefaults.standard.string(forKey: "DedeUserID") ?? "Empty")
                        """
                        DarockKit.Network.shared.requestString("https://api.darock.top/feedback/submit/anony/喵哩喵哩/\(msgToSend.base64Encoded().replacingOccurrences(of: "/", with: "{slash}"))") { respStr, isSuccess in
                            if isSuccess {
                                if Int(respStr) != nil {
                                    var arr = UserDefaults.standard.stringArray(forKey: "RadarFBIDs") ?? [String]()
                                    arr.insert(respStr, at: 0)
                                    UserDefaults.standard.set(arr, forKey: "RadarFBIDs")
                                    #if os(watchOS) || os(visionOS)
                                    tipWithText("已发送", symbol: "paperplane.fill")
                                    #else
                                    AlertKitAPI.present(title: "已发送", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                    #endif
                                    dismiss()
                                } else {
                                    #if os(watchOS) || os(visionOS)
                                    tipWithText("服务器错误", symbol: "xmark.circle.fill")
                                    #else
                                    AlertKitAPI.present(title: "服务器错误", icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                    #endif
                                }
                            }
                        }
                    }, label: {
                        if !isSending {
                            Text("发送")
                        } else {
                            ProgressView()
                        }
                    })
                    .disabled(isSending)
                } footer: {
                    Text("Darock 会收集必要的诊断信息以便进行改进。如果您不愿意被收集信息，请勿发送。")
                }
            }
        }
    }
    struct FeedbackDetailView: View {
        var id: String
        @State var title = ""
        @State var typeText = ""
        @State var content = ""
        @State var status = 8
        @State var replies = [(status: Int, content: String, sender: String)]()
        @State var isSendReplyPresented = false
        @State var replyInput = ""
        var body: some View {
            List {
                Section {
                    Text(title)
                } header: {
                    Text("标题")
                }
                Section {
                    Text(typeText)
                } header: {
                    Text("类型")
                }
                Section {
                    Text(content)
                } header: {
                    Text("内容")
                }
                Section {
                    HStack {
                        Image(systemName: globalStateIcons[status])
                            .foregroundStyle(globalStateColors[status])
                        Text(globalStates[status])
                    }
                } header: {
                    Text("状态")
                }
                if replies.count != 0 {
                    ForEach(0..<replies.count, id: \.self) { i in
                        Section {
                            Divider()
                        } footer: {
                            Text("回复 \(i + 1)")
                        }
                        .listRowBackground(Color.clear)
                        Section {
                            Text(replies[i].sender)
                        } header: {
                            Text("来自")
                        }
                        Section {
                            HStack {
                                Image(systemName: globalStateIcons[replies[i].status])
                                    .foregroundStyle(globalStateColors[replies[i].status])
                                Text(globalStates[replies[i].status])
                            }
                        } header: {
                            Text("状态")
                        }
                        Section {
                            Text(replies[i].content)
                        } header: {
                            Text("回复内容")
                        }
                    }
                }
            }
            .navigationTitle(id)
            .onAppear {
                DarockKit.Network.shared.requestString("https://api.darock.top/radar/details/喵哩喵哩/\(id)") { respStr, isSuccess in
                    if isSuccess {
                        let lineSpd = respStr.apiFixed().split(separator: "\\n").map { String($0) }
                        title = lineSpd[0]
                        for i in 1..<lineSpd.count {
                            if lineSpd[i] == "---" { break }
                            if lineSpd[i].split(separator: "：").count < 2 { continue }
                            let mspd = lineSpd[i].split(separator: "：").map { String($0) }
                            if mspd[0] == "State" {
                                status = Int(mspd[1]) ?? 8
                            } else if mspd[0] == "Content" {
                                content = mspd[1]
                            } else if mspd[0] == "Type" {
                                switch mspd[1] {
                                case "0":
                                    typeText = "错误/异常行为"
                                default:
                                    typeText = "建议"
                                }
                            }
                        }
                        let repSpd = respStr.apiFixed().split(separator: "---").map { String($0) }
                        if repSpd.count > 1 {
                            for i in 1..<repSpd.count {
                                let lineSpd = repSpd[i].split(separator: "\\n").map { String($0) }
                                var st = 8
                                var co = ""
                                var se = ""
                                for j in 0..<lineSpd.count {
                                    if lineSpd[i].split(separator: "：").count < 2 { continue }
                                    let mspd = lineSpd[j].split(separator: "：").map { String($0) }
                                    if mspd[0] == "State" {
                                        st = Int(mspd[1]) ?? 8
                                    } else if mspd[0] == "Content" {
                                        co = mspd[1]
                                    } else if mspd[0] == "Sender" {
                                        se = mspd[1]
                                    }
                                }
                                replies.append((status: st, content: co, sender: se))
                            }
                        }
                    }
                }
            }
            .toolbar {
                if #available(watchOS 10, *) {
                    Button(action: {
                        isSendReplyPresented = true
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                    })
                    .sheet(isPresented: $isSendReplyPresented) {
                        TextField("回复信息", text: $replyInput)
                            .onSubmit {
                                if replyInput != "" {
                                    let enced = """
                                    Content：\(replyInput)
                                    Sender：User
                                    """.base64Encoded().replacingOccurrences(of: "/", with: "{slash}")
                                    DarockKit.Network.shared.requestString("https://api.darock.top/radar/reply/喵哩喵哩/\(id)/\(enced)") { respStr, isSuccess in
                                        if isSuccess {
                                            if respStr.apiFixed() == "Success" {
                                                isSendReplyPresented = false
                                            } else {
                                                #if os(watchOS) || os(visionOS)
                                                tipWithText("未知错误", symbol: "xmark.circle.fill")
                                                #else
                                                AlertKitAPI.present(title: "未知错误", subtitle: "可能未发送此回复", icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

struct BannedTipView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("您已被 Darock 永久封禁且在设备上施行")
                #if os(watchOS)
                let banId = WKInterfaceDevice.current().identifierForVendor?.uuidString ?? "nil"
                #else
                let banId = UIDevice.current.identifierForVendor?.uuidString ?? "nil"
                #endif
                Text(banId)
                Text(UserDefaults.standard.string(forKey: "DedeUserId") ?? "Empty")
                Text("加群248036605查看群公告以申请解封")
            }
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
