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

#if os(watchOS)
struct FeedbackView: View {
    @State var qrImage: CGImage?
    var body: some View {
        VStack {
            if qrImage != nil {
                Image(uiImage: UIImage(cgImage: qrImage!))
                    .resizable()
                    .frame(width: 140, height: 140)
                Text("Feedback.continue-on-other-device")
                    .bold()
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

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
