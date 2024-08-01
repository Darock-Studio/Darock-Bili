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
import EFQRCode
import DarockKit
import MarkdownUI
import AuthenticationServices

#if os(watchOS)
struct FeedbackView: View {
    @State var qrImage: CGImage?
    var body: some View {
        InAppFeedbackView()
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

#if os(watchOS)
fileprivate let globalStates = ["未标记", "按预期工作", "无法修复", "问题重复", "搁置", "正在修复", "已在未来版本修复", "已修复", "正在加载", "未能复现", "问题并不与App相关。", "需要更多细节"]
fileprivate let globalStateColors = [Color.secondary, Color.red, Color.red, Color.red, Color.orange, Color.orange, Color.orange, Color.green, Color.secondary, Color.red, Color.secondary, Color.orange]
fileprivate let globalStateIcons = ["minus", "curlybraces", "xmark", "arrow.triangle.merge", "books.vertical", "hammer", "clock.badge.checkmark", "checkmark", "ellipsis", "questionmark", "bolt.horizontal", "arrowshape.turn.up.backward.badge.clock"]

struct InAppFeedbackView: View {
    @State var feedbackIds = [String]()
    @State var badgeOnIds = [String]()
    var body: some View {
        List {
            Section {
                NavigationLink(destination: { NewFeedbackView() }, label: {
                    Label("新建反馈", systemImage: "exclamationmark.bubble.fill")
                })
                .accessibilityIdentifier("NewFeedbackButton")
                NavigationLink(destination: { StateMeaningsView() }, label: {
                    Label("了解反馈状态", systemImage: "bolt.badge.clock")
                })
            }
            if feedbackIds.count != 0 {
                Section {
                    ForEach(0..<feedbackIds.count, id: \.self) { i in
                        NavigationLink(destination: { FeedbackDetailView(id: feedbackIds[i]) }, label: {
                            HStack {
                                if badgeOnIds.contains(feedbackIds[i]) {
                                    Image(systemName: "1.circle.fill")
                                        .foregroundColor(.red)
                                }
                                Text("ID: \(feedbackIds[i])")
                            }
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
            badgeOnIds.removeAll()
            for id in feedbackIds {
                DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/radar/details/喵哩喵哩/\(id)") { respStr, isSuccess in
                    if isSuccess {
                        let repCount = respStr.apiFixed().components(separatedBy: "---").count - 1
                        let lastViewCount = UserDefaults.standard.integer(forKey: "RadarFB\(id)ReplyCount")
                        if repCount > lastViewCount {
                            badgeOnIds.append(id)
                        }
                    }
                }
            }
        }
    }
    
    struct NewFeedbackView: View {
        @Environment(\.dismiss) var dismiss
        @State var titleInput = ""
        @State var contentInputs = [""]
        @State var feedbackType = 0
        @State var isSending = false
        @State var isDraftAlertPresented = false
        @State var isDraftLoaded = false
        var body: some View {
            Form {
                List {
                    Section {
                        TextField("标题", text: $titleInput)
                    } header: {
                        Text("请为你的反馈提供描述性的标题：")
                    } footer: {
                        Text("示例：评论区缺少最新的回复")
                    }
                    Section {
                        ForEach(0..<contentInputs.count, id: \.self) { i in
                            TextField("描述行\(i + 1)", text: $contentInputs[i])
                                .swipeActions {
                                    if contentInputs.count > 1 {
                                        Button(role: .destructive, action: {
                                            contentInputs.remove(at: i)
                                        }, label: {
                                            Image(systemName: "xmark.circle.fill")
                                        })
                                    }
                                }
                        }
                        Button(action: {
                            contentInputs.append("")
                        }, label: {
                            Label("换行", systemImage: "text.append")
                        })
                    } header: {
                        Text("请描述该问题以及重现问题的步骤：")
                    } footer: {
                        Text("""
                        请包括：
                        - 问题的清晰描述
                        - 逐步说明重现问题的详细步骤（如果可能）
                        - 期望的结果
                        - 当前所示结果
                        """)
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
                                tipWithText("标题不能为空", symbol: "xmark.circle.fill")
                                return
                            }
                            isSending = true
                            let msgToSend = """
                            \(titleInput)
                            State：0
                            Type：\(feedbackType)
                            Content：\(contentInputs.joined(separator: "\\n"))
                            Time：\(Date.now.timeIntervalSince1970)
                            Version：v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)
                            OS：\(WKInterfaceDevice.current().systemVersion)
                            Sender: User
                            """
                            DarockKit.Network.shared
                                .requestString("https://fapi.darock.top:65535/feedback/submit/anony/喵哩喵哩/\(msgToSend.base64Encoded().replacingOccurrences(of: "/", with: "{slash}"))") { respStr, isSuccess in
                                    if isSuccess {
                                        if Int(respStr) != nil {
                                            var arr = UserDefaults.standard.stringArray(forKey: "RadarFBIDs") ?? [String]()
                                            arr.insert(respStr, at: 0)
                                            UserDefaults.standard.set(arr, forKey: "RadarFBIDs")
                                            tipWithText("已发送", symbol: "paperplane.fill")
                                            dismiss()
                                        } else {
                                            tipWithText("服务器错误", symbol: "xmark.circle.fill")
                                        }
                                    }
                                }
                        }, label: {
                            if !isSending {
                                Text("提交")
                            } else {
                                ProgressView()
                            }
                        })
                        .disabled(isSending)
                    }
                }
            }
            .navigationTitle("提交反馈")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        if !isSending && !titleInput.isEmpty || contentInputs != [""] {
                            isDraftAlertPresented = true
                        } else {
                            dismiss()
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                    })
                }
            }
            .onAppear {
                if !isDraftLoaded {
                    titleInput = UserDefaults.standard.string(forKey: "FeedbackNewDraftTitle") ?? ""
                    contentInputs = UserDefaults.standard.stringArray(forKey: "FeedbackNewDraftContent") ?? [""]
                    isDraftLoaded = true
                }
            }
            .alert("未完成的编辑", isPresented: $isDraftAlertPresented, actions: {
                Button(role: .destructive, action: {
                    UserDefaults.standard.removeObject(forKey: "FeedbackNewDraftTitle")
                    UserDefaults.standard.removeObject(forKey: "FeedbackNewDraftContent")
                    dismiss()
                }, label: {
                    Text("删除草稿")
                })
                Button(role: .cancel, action: {
                    UserDefaults.standard.set(titleInput, forKey: "FeedbackNewDraftTitle")
                    UserDefaults.standard.set(contentInputs, forKey: "FeedbackNewDraftContent")
                    dismiss()
                }, label: {
                    Text("存储草稿")
                })
            }, message: {
                Text("你要存储当前的草稿吗？")
            })
        }
    }
    struct FeedbackDetailView: View {
        var id: String
        private let projName = "喵哩喵哩"
        @Environment(\.dismiss) var dismiss
        @State var feedbackText = ""
        @State var formattedTexts = [String]()
        @State var replies = [[String]]()
        @State var isNoReply = true
        @State var isReplyPresented = false
        @State var replyInput = ""
        @State var isReplySubmitted = false
        @State var isReplyDisabled = false
        var body: some View {
            List {
                if formattedTexts.count != 0 {
                    getView(from: formattedTexts)
                }
                if !isNoReply {
                    ForEach(0..<replies.count, id: \.self) { i in
                        getView(from: replies[i], isReply: true)
                    }
                }
                Section {
                    Button(action: {
                        isReplyPresented = true
                    }, label: {
                        Label("回复", systemImage: "arrowshape.turn.up.left.2")
                    })
                    .disabled(isReplyDisabled)
                } footer: {
                    if isReplyDisabled {
                        Text("此反馈已关闭，若要重新进行反馈，请创建一个新的反馈")
                    }
                }
            }
            .sheet(isPresented: $isReplyPresented, onDismiss: {
                refresh()
            }, content: {
                TextField("回复信息", text: $replyInput) {
                    if isReplySubmitted {
                        return
                    }
                    isReplySubmitted = true
                    if replyInput != "" {
                        let enced = """
                        Content：\(replyInput)
                        Sender：User
                        Time：\(Date.now.timeIntervalSince1970)
                        """.base64Encoded().replacingOccurrences(of: "/", with: "{slash}")
                        DarockKit.Network.shared
                            .requestString("https://fapi.darock.top:65535/radar/reply/喵哩喵哩/\(id)/\(enced)") { respStr, isSuccess in
                                if isSuccess {
                                    if respStr.apiFixed() == "Success" {
                                        refresh()
                                        replyInput = ""
                                        isReplyPresented = false
                                    } else {
                                        tipWithText("未知错误", symbol: "xmark.circle.fill")
                                    }
                                    isReplySubmitted = false
                                }
                            }
                    }
                }
            })
            .navigationTitle(id)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                refresh()
            }
        }
        
        @inline(__always)
        func refresh() {
            DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/radar/details/\(projName)/\(id)") { respStr, isSuccess in
                if isSuccess {
                    formattedTexts.removeAll()
                    replies.removeAll()
                    feedbackText = respStr.apiFixed()
                        .replacingOccurrences(of: "\\\\n", with: "____LINEBREAK_REPLACE_TOKEN____")
                        .replacingOccurrences(of: "\\n", with: "\n")
                        .replacingOccurrences(of: "____LINEBREAK_REPLACE_TOKEN____", with: "\\n")
                        .replacingOccurrences(of: "\\\"", with: "\"")
                    let spd = feedbackText.split(separator: "\n")
                    for text in spd {
                        if text == "---" { break }
                        formattedTexts.append(String(text))
                    }
                    debugPrint(formattedTexts)
                    if feedbackText.split(separator: "---").count > 1 {
                        let repliesText = Array(feedbackText.split(separator: "---").dropFirst()).map { String($0) }
                        for text in repliesText {
                            let spd = text.split(separator: "\n").map { String($0) }
                            var tar = [String]()
                            for lt in spd {
                                tar.append(lt)
                                if _slowPath(lt.hasPrefix("State：")) {
                                    if let st = Int(String(lt.dropFirst(6))) {
                                        isReplyDisabled = st == 1 || st == 2 || st == 3 || st == 7 || st == 10
                                    }
                                }
                            }
                            replies.append(tar)
                        }
                        
                        isNoReply = false
                    }
                    UserDefaults.standard.set(feedbackText.split(separator: "---").count, forKey: "RadarFB\(id)ReplyCount")
                }
            }
        }
        
        @ViewBuilder
        func getView(from: [String], isReply: Bool = false) -> some View {
            VStack {
                ForEach(0..<from.count, id: \.self) { j in
                    if from[j].hasPrefix("Sender") {
                        HStack {
                            Text(from[j].dropFirst(7))
                                .font(.system(size: 18))
                                .bold()
                            Spacer()
                        }
                    }
                }
                ForEach(0..<from.count, id: \.self) { j in
                    if from[j].hasPrefix("Time") {
                        if let intt = Double(String(from[j].dropFirst(5))) {
                            HStack {
                                Text({ () -> String in
                                    let df = DateFormatter()
                                    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
                                    return df.string(from: Date(timeIntervalSince1970: intt))
                                }())
                                .font(.system(size: 13))
                                .foregroundStyle(Color.gray)
                                Spacer()
                            }
                        }
                    }
                }
                Divider()
                if !isReply {
                    HStack {
                        Text(from[0])
                            .font(.system(size: 18))
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Divider()
                }
                ForEach(0...from.count - 1, id: \.self) { i in
                    if !(!from[i].contains("：") && !from[i].contains(":") && i == 0) && (!from[i].hasPrefix("Sender")) && (!from[i].hasPrefix("Time")) {
                        // ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                        //                     Not Title                                          Not Sender                         Not Time
                        if (from[i].contains("：") && from[i] != "：" ? from[i].split(separator: "：")[0] : "") != "" {
                            HStack {
                                Text(from[i].contains("：") && from[i] != "：" ? String(from[i].split(separator: "：")[0]).titleReadable() : "")
                                    .font(.system(size: 17))
                                    .bold()
                                Spacer()
                            }
                        }
                        HStack {
                            if (from[i].contains("：") && from[i] != "：" ? from[i].split(separator: "：")[0] : "") == "State" {
                                if let index = Int(from[i].split(separator: "：").count > 1 ? String(from[i].split(separator: "：")[1]) : from[i]) {
                                    HStack {
                                        Group {
                                            Image(systemName: globalStateIcons[index])
                                            Text(globalStates[index])
                                        }
                                        .foregroundStyle(globalStateColors[index])
                                        .font(.system(size: 14))
                                    }
                                } else {
                                    Text(from[i].split(separator: "：").count > 1 ? String(from[i].split(separator: "：")[1]) : from[i])
                                        .font(.system(size: 14))
                                }
                            } else if (from[i].contains("：") && from[i] != "：" ? from[i].split(separator: "：")[0] : "") == "NotificationToken" {
                                Text("[Hex Data]")
                                    .font(.system(size: 14))
                            } else if (from[i].contains("：") && from[i] != "：" ? from[i].split(separator: "：")[0] : "") == "Settings" {
                                Text("[Privacy Hidden]")
                                    .font(.system(size: 14))
                            } else if (from[i].contains("：") && from[i] != "："
                                       ? from[i].split(separator: "：")[0]
                                       : "") == "AddDuplicateDelete"
                                        || (from[i].contains("：") && from[i] != "："
                                            ? from[i].split(separator: "：")[0]
                                            : "") == "DuplicateTo",
                                      let goId = Int(from[i].split(separator: "：")[1]) {
                                Text("FB\(projName.projNameLinked())\(String(goId))")
                            } else if (from[i].contains("：") && from[i] != "：" ? from[i].split(separator: "：")[0] : "") == "MarkdownContent" {
                                Markdown(
                                    (from[i].split(separator: "：").count > 1
                                     ? String(from[i].split(separator: "：", maxSplits: 1)[1])
                                     : from[i]).replacingOccurrences(of: "\\n", with: "\n")
                                )
                                .font(.system(size: 14))
                                .environment(\.openURL, OpenURLAction { url in
                                    let session = ASWebAuthenticationSession(url: url, callbackURLScheme: nil) { _, _ in }
                                    session.prefersEphemeralWebBrowserSession = true
                                    session.start()
                                    return .handled
                                })
                            } else {
                                Text(
                                    (from[i].split(separator: "：").count > 1
                                     ? String(from[i].split(separator: "：", maxSplits: 1)[1])
                                     : from[i]).replacingOccurrences(of: "\\n", with: "\n")
                                )
                                .font(.system(size: 14))
                            }
                            Spacer()
                        }
                        if i != from.count - 1 {
                            Spacer()
                                .frame(height: 10)
                        }
                    }
                }
            }
        }
    }
}

private struct StateMeaningsView: View {
    var body: some View {
        ScrollView {
            Text("""
            \(Text("\(Image(systemName: globalStateIcons[0]))未标记").foregroundColor(globalStateColors[0]))：反馈暂未被阅读，或是正在验证问题。
            
            \(Text("\(Image(systemName: globalStateIcons[1]))按预期工作").foregroundColor(globalStateColors[1]))：报告中描述的是预期中的表现。
            
            \(Text("\(Image(systemName: globalStateIcons[2]))无法修复").foregroundColor(globalStateColors[2]))：报告中的问题无法被修复，或是不具有可行性。
            
            \(Text("\(Image(systemName: globalStateIcons[3]))问题重复").foregroundColor(globalStateColors[3]))：在你提交此报告前，已有另一人提出了相同的问题，你仍会在第一个报告得到修复后收到“已修复”的状态更新。
                    你的报告可能会与那些初看似乎具有相同根源的类似报告分到一组。但是，类似的报告也可能包含多种原因。如果你发现该修复方案解决了类似报告中的问题，但无法完全解决你报告的问题，请提交新报告。
            
            \(Text("\(Image(systemName: globalStateIcons[4]))搁置").foregroundColor(globalStateColors[4]))：短时间内可能无法解决此问题。
            
            \(Text("\(Image(systemName: globalStateIcons[5]))正在修复").foregroundColor(globalStateColors[5]))：Darock 正在为此问题提供修复方案。
            
            \(Text("\(Image(systemName: globalStateIcons[6]))已在未来版本修复").foregroundColor(globalStateColors[6]))：修复工作已完成，但还未提交更新或是更新正在等待发布。
            
            \(Text("\(Image(systemName: globalStateIcons[7]))已修复").foregroundColor(globalStateColors[7]))：修复工作已完成，可更新至最新版本验证修复。
            
            \(Text("\(Image(systemName: globalStateIcons[8]))问题并不与 App 相关").foregroundColor(globalStateColors[8]))：报告与 App 本身无关，或是问题并非由 App 本身引起。
            
            \(Text("\(Image(systemName: globalStateIcons[9]))未能复现").foregroundColor(globalStateColors[9]))：未能通过报告中的问题复现问题，需要提供更多信息。
            
            \(Text("\(Image(systemName: globalStateIcons[10]))需要更多细节").foregroundColor(globalStateColors[10]))：提供的信息不足以让我们确定问题，你需要补充更多信息。
            """)
        }
        .navigationTitle("反馈状态")
    }
}
#endif

extension String {
    func dropFirst(_ k: Character) -> String {
        if self.hasPrefix(String(k)) {
            return String(self.dropFirst())
        } else {
            return self
        }
    }
    func dropLast(_ k: Character) -> String {
        if self.hasSuffix(String(k)) {
            return String(self.dropLast())
        } else {
            return self
        }
    }
    func projNameLinked() -> Self {
        let shortMd5d = String(self.md5.prefix(8)).lowercased()
        let a2nchart: [Character: Int] = ["a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7, "i": 8, "j": 9, "k": 0, "l": 1, "m": 2, "n": 3, "o": 4, "p": 5, "q": 6, "r": 7, "s": 8, "t": 9, "u": 0, "v": 1, "w": 2, "x": 3, "y": 4, "z": 5] // swiftlint:disable:this line_length
        var ced = ""
        for c in shortMd5d {
            if Int(String(c)) == nil {
                ced += String(a2nchart[c]!)
            } else {
                ced += String(c)
            }
        }
        return ced
    }
    func titleReadable() -> LocalizedStringKey {
        switch self {
        case "State":
            return "状态"
        case "Type":
            return "类型"
        case "Content", "MarkdownContent":
            return "描述"
        case "Version":
            return "App 版本"
        case "OS":
            return "系统版本"
        case "DuplicateTo":
            return "与此反馈重复"
        case "AddDuplicateDelete":
            return "关联反馈"
        case "NotificationToken":
            return "通知令牌"
        case "Settings":
            return "设置"
        default:
            return LocalizedStringKey(self)
        }
    }
}
extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
