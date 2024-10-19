//
//
//  TrendingView.swift
//  DarockBili
//
//  Created by feng on 10/19/24.
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

struct TrendingView: View {
    @State private var trendingVideos: [(title: String, description: String, author: String, views: String)] = []
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(trendingVideos, id: \.title) { video in
                    VStack(alignment: .leading) {
                        Text(video.title)
                            .font(.headline)
                        Text(video.description)
                            .font(.subheadline)
                        Text("作者: \(video.author) | 播放量: \(video.views)")
                            .font(.footnote)
                    }
                }
            }
        }
        .onAppear {
            fetchTrendingVideos()
        }
    }

    private func fetchTrendingVideos() {
        Task {
            let result = await BiliBiliAPIService().fetchBiliBiliData(for: .trending, limit: 5)
            switch result {
            case .success(let videos):
                trendingVideos = videos
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

