//
//
//  LinkDetectText.swift
//  DarockBili
//
//  Created by lion on 2024/2/17.
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

import Foundation
import SwiftUI
import AuthenticationServices

struct LinkDetectText: View {
    @Binding
    var inputURL:String
    @State
    var markdownText = try! AttributedString(markdown: "")
    @State var linkColor = Color.blue
    @State
    var error:Error?
    var body: some View {
        Group {
            if let error {
                VStack(alignment: .leading, content: {
                    Text("文本加载失败")
                    Text(error.localizedDescription)
                        .font(.footnote)
                })
            } else {
                Text(markdownText)
                    .tint(linkColor)
#if os(watchOS)
                //拦截，然后用暗礁浏览器打开
                    .environment(\.openURL, OpenURLAction(handler: { url in
                        //加一个小动画，因为下一步操作【真机上】会卡1秒
                        bling()
                        // Source: https://www.reddit.com/r/apple/comments/rcn2h7/comment/hnwr8do/
                        let session = ASWebAuthenticationSession(
                            url: url,
                            callbackURLScheme: nil
                        ) { _, _ in
                        }
                        
                        // Makes the "Watch App Wants To Use example.com to Sign In" popup not show up
                        session.prefersEphemeralWebBrowserSession = true
                        
                        session.start()
                        return .handled
                    }))
                //iOS端可以直接用系统浏览器打开链接，不需要拦截
#endif
            }
        }
        .onAppear {
            loadText(inputURL:inputURL)
        }
        .onChange(of: inputURL, perform: { newValue in
            loadText(inputURL:newValue)
        })
        .animation(.smooth, value: markdownText)
     
    }
    func loadText(inputURL:String) {
        let markdownURLs = detectURLs(in: inputURL)
        do {
            let markdownLink = try AttributedString(markdown: markdownURLs)
            self.markdownText = markdownLink
            self.error = nil
        } catch {
            self.error = error
        }
    }
    func bling() {
        withAnimation(.smooth, {
            linkColor = .clear
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            withAnimation(.smooth, {
                linkColor = .blue
            })
        })
    }
    func detectURLs(in text: String) -> String {
            let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector?.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))

            var markdownString = text
            if let matches = matches {
                for match in matches {
                    if let url = match.url {
                        let link = "[\(url.absoluteString)](\(url.absoluteString))"
                        markdownString = markdownString.replacingOccurrences(of: url.absoluteString, with: link)
                    }
                }
            }

            return markdownString
        }

}
