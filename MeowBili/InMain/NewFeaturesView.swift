//
//
//  NewFeaturesView.swift
//  DarockBili
//
//  Created by memz233 on 7/19/24.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI

@available(iOS, unavailable)
struct NewFeaturesView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("“喵哩喵哩”新功能")
                        .font(.system(size: 18, weight: .bold))
                        .accessibilityIdentifier("NewFeaturesTitle")
                    SingleFeatureRow(symbol: "music.note.list", mainText: "音频播放", detailText: "轻触视频页左下角按钮即可以纯音频播放")
                }
            }
        }
    }
}

private struct SingleFeatureRow: View {
    var symbol: String
    var mainText: LocalizedStringKey
    var detailText: LocalizedStringKey
    var navigateTo: (() -> AnyView)?
    var body: some View {
        NavigationLink(destination: {
            if let navigateTo {
                navigateTo()
            } else {
                EmptyView()
            }
        }, label: {
            HStack {
                Spacer()
                Image(systemName: symbol)
                    .font(.system(size: 28))
                    .foregroundColor(.accentColor)
                VStack {
                    HStack {
                        Text(mainText)
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        Text(detailText)
                            .font(.system(size: 14))
                            .opacity(0.6)
                        Spacer()
                    }
                }
                if navigateTo != nil {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .opacity(0.7)
                }
            }
        })
        .buttonStyle(.plain)
        .padding(.vertical)
        .allowsHitTesting(navigateTo != nil)
    }
}
