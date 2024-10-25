//
//
//  MeowWidgetWatch.swift
//  MeowWidgetWatchExtension
//
//  Created by feng on 10/25/24.
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

import WidgetKit
import SwiftUI
import Intents

struct MeowWidgetEntry: TimelineEntry {
    let date: Date
    let videoTitle: String
    let videoAuthor: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MeowWidgetEntry {
        MeowWidgetEntry(date: Date(), videoTitle: "miku miku oo ee oo", videoAuthor: "未来de残像")
    }

    func getSnapshot(in context: Context, completion: @escaping (MeowWidgetEntry) -> ()) {
        let entry = MeowWidgetEntry(date: Date(), videoTitle: "视频名称", videoAuthor: "作者")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MeowWidgetEntry>) -> ()) {
        Task {
            let trendingResult = await BiliBiliAPIService().fetchBiliBiliData(for: .trending, limit: 5)
            let recommendationsResult = await BiliBiliAPIService().fetchBiliBiliData(for: .recommendations, limit: 5)

            var allVideos: [(title: String, description: String, author: String, views: String)] = []
            if case .success(let trendingVideos) = trendingResult {
                allVideos.append(contentsOf: trendingVideos)
            }
            if case .success(let recommendationsVideos) = recommendationsResult {
                allVideos.append(contentsOf: recommendationsVideos)
            }

            if !allVideos.isEmpty {
                var entries: [MeowWidgetEntry] = []
                let currentDate = Date()
                
                for (index, video) in allVideos.enumerated() {
                    let entryDate = Calendar.current.date(byAdding: .minute, value: index * 10, to: currentDate) ?? currentDate
                    let entry = MeowWidgetEntry(
                        date: entryDate,
                        videoTitle: video.title,
                        videoAuthor: video.author
                    )
                    entries.append(entry)
                }
                
                let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate) ?? currentDate
                let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
                completion(timeline)
            } else {
                let entry = MeowWidgetEntry(date: Date(), videoTitle: "暂无数据", videoAuthor: "")
                completion(Timeline(entries: [entry], policy: .atEnd))
            }
        }
    }
}

struct MeowWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("喵哩喵哩")
                    .font(.headline)
                    .foregroundColor(Color("WidgetTitleColor"))
            }

            Spacer().frame(height: 10)

            switch family {
            case .accessoryCircular, .accessoryRectangular:
                Text(entry.videoTitle)
                    .font(.headline)

            default:
                Text(entry.videoTitle)
                    .font(.headline)
            }
        }
        .padding()
        .widgetURL(URL(string: "meowbili://")!)
    }
}

struct MeowWidget: Widget {
    let kind: String = "MeowWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MeowWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("喵哩喵哩小组件")
        .description("热门或推荐的视频内容")
        .supportedFamilies([.accessoryCircular, .accessoryRectangular])
    }
}
