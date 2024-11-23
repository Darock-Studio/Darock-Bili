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
import RadarKitCore
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
import RadarKit

struct InAppFeedbackView: View {
    @State var feedbackIds = [String]()
    @State var badgeOnIds = [String]()
    var body: some View {
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
    }
}
#endif

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
