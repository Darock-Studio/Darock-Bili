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
import DarockUI
import EFQRCode
import RadarKit
import CorvusKit
import MarkdownUI
import RadarKitCore
import DarockFoundation
import AuthenticationServices
#if os(watchOS)
import Cepheus
#endif

struct FeedbackView: View {
    @State var feedbackIds = [String]()
    @State var badgeOnIds = [String]()
    var body: some View {
        if !COKChecker.shared.cachedCheckStatus {
            RKFeedbackView(projName: "喵哩喵哩")
                .radarTitleInputSample("示例：评论区缺少最新的回复")
                .radarTipper { text, symbol in
                    tipWithText(text, symbol: symbol)
                }
                .radarMessageMarkdownRender { str in
                    Markdown(str)
                        .environment(\.openURL, OpenURLAction { url in
                            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: nil) { _, _ in }
                            session.prefersEphemeralWebBrowserSession = true
                            session.start()
                            return .handled
                        })
                }
        } else {
            CorvusBannedView()
        }
    }
}

private struct CorvusBannedView: View {
    let declaration = String(localized: "法律之前人人平等，并有权享受法律的平等保护，不受任何歧视。人人有权享受平等保护，以免受违反本宣言的任何歧视行为以及煽动这种歧视的任何行为之害。")
    @Environment(\.presentationMode) var presentationMode
    @State var copyDeclarationInput = ""
    @State var descriptionInput = ""
    @State var descriptionSnapshotCount = 0
    @State var isSubmitting = false
    var body: some View {
        List {
            Section {
                Text("""
                你因为在“反馈助理”中发送不适宜的言论而被附加 Corvus 封禁。
                
                此封禁不会影响 App 功能，但会禁用你的“反馈助理”，以及在你的 App 内加上如你现在看到的水印。
                
                你可以通过下方的表单进行申诉。
                """)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            Section {
                Text(declaration)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                #if os(watchOS)
                CepheusKeyboard(input: $copyDeclarationInput, prompt: "按原样抄写", CepheusIsEnabled: true, allowEmojis: false, aboutLinkIsHidden: true)
                #else
                TextField("按原样抄写", text: $copyDeclarationInput)
                #endif
            } header: {
                Text("前置条件")
            } footer: {
                Text("请按原样抄写上方文本。")
            }
            Section {
                #if os(watchOS)
                CepheusKeyboard(input: $descriptionInput, prompt: "描述文本", CepheusIsEnabled: true, aboutLinkIsHidden: true)
                #else
                TextField("描述文本", text: $descriptionInput)
                #endif
            } header: {
                Text("描述")
            } footer: {
                if !descriptionInput.isEmpty {
                    if descriptionInput.count < 200 {
                        Text("还差 \(200 - descriptionInput.count) 字")
                            .foregroundStyle(.red)
                    }
                } else {
                    Text("请对本次申诉情况进行详细描述。")
                }
            }
            .disabled(copyDeclarationInput != declaration)
            Section {
                Button(action: {
                    isSubmitting = true
                    Task {
                        do {
                            _ = try await RKCFeedbackManager(projectName: "Corvus申诉")
                                .newFeedback(.init(title: "喵哩喵哩", content: descriptionInput, sender: "User"))
                            tipWithText("已提交", symbol: "checkmark.circle.fill")
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            tipWithText("提交时出错", symbol: "xmark.circle.fill")
                        }
                        isSubmitting = false
                    }
                }, label: {
                    Text("提交")
                })
                .disabled(descriptionInput.count < 200 || isSubmitting)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Corvus 封禁")
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
