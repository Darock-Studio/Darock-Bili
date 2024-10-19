//
//
//  MeowWidget.swift
//  MeowWidgetExtension
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

import WidgetKit
import SwiftUI
import Intents

struct MeowWidgetEntry: TimelineEntry {
    let date: Date
    let videoTitle: String
    let videoDescription: String
    let videoAuthor: String
    let videoViews: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MeowWidgetEntry {
        MeowWidgetEntry(date: Date(), videoTitle: "视频名称", videoDescription: "描述", videoAuthor: "作者", videoViews: "播放量")
    }

    func getSnapshot(in context: Context, completion: @escaping (MeowWidgetEntry) -> ()) {
        let entry = MeowWidgetEntry(date: Date(), videoTitle: "视频名称", videoDescription: "描述", videoAuthor: "作者", videoViews: "播放量")
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

            // 如果有数据，则创建entries
            if !allVideos.isEmpty {
                var entries: [MeowWidgetEntry] = []
                let currentDate = Date()
                
                // 每隔 10 分钟轮播一个视频
                for (index, video) in allVideos.enumerated() {
                    let entryDate = Calendar.current.date(byAdding: .minute, value: index * 10, to: currentDate) ?? currentDate
                    let entry = MeowWidgetEntry(
                        date: entryDate,
                        videoTitle: video.title,
                        videoDescription: video.description,
                        videoAuthor: video.author,
                        videoViews: video.views
                    )
                    entries.append(entry)
                }
                
                let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate) ?? currentDate
                let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
                completion(timeline)
            } else {
                let entry = MeowWidgetEntry(date: Date(), videoTitle: "暂无数据", videoDescription: "", videoAuthor: "", videoViews: "")
                completion(Timeline(entries: [entry], policy: .atEnd))
            }
        }
    }
}

struct MeowWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("MeowBili")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("喵哩喵哩")
                    .font(.headline)
                    .foregroundColor(Color("WidgetTitleColor"))
            }

            Spacer().frame(height: 10)

            switch family {
            case .systemSmall:
                Text(entry.videoTitle)
                    .font(.headline)
                
            case .systemMedium:
                Text(entry.videoTitle)
                    .font(.headline)
                Text(entry.videoDescription)
                    .font(.subheadline)
                Spacer()
                Text("在喵哩喵哩查看更多内容")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            case .systemLarge:
                Text(entry.videoTitle)
                    .font(.headline)
                Text(entry.videoDescription)
                    .font(.subheadline)
                Text("作者: \(entry.videoAuthor)")
                    .font(.footnote)
                Text("播放量: \(entry.videoViews)")
                    .font(.footnote)
                Spacer()
                Text("在喵哩喵哩查看更多内容")
                    .font(.footnote)
                    .foregroundColor(.gray)

            case .accessoryCircular, .accessoryRectangular:
                if entry.videoTitle == "打开喵哩喵哩" {
                    Text("打开喵哩喵哩")
                        .font(.headline)
                } else {
                    Text(entry.videoTitle)
                        .font(.headline)
                }

            default:
                Text(entry.videoTitle)
                    .font(.headline)
                Text(entry.videoDescription)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color("WidgetBackgroundColor"))
        .widgetURL(URL(string: "meowbili://")!)
    }
}


struct MeowWidget: Widget {
    let kind: String = "MeowWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MeowWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("喵哩喵哩Widget")
        .description("热门或推荐的视频内容")
        .supportedFamilies(families)
    }
    
    private var families: [WidgetFamily] {
        #if os(watchOS)
        return [.accessoryCircular, .accessoryRectangular]
        #else
        return [.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular]
        #endif
    }
}
