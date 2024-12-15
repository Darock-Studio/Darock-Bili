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

struct MeowWidgetEntry: TimelineEntry {
    let date: Date
    let video: Video
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MeowWidgetEntry {
        MeowWidgetEntry(date: Date(), video: Video(id: 0, title: "miku miku oo ee oo", description: "https://twitter.com/i/status/1697029186777706544 channel（twi:_CASTSTATION）", authorName: "未来de残像", viewCount: 0, likeCount: 0, coinCount: 0, shareCount: 0, danmakuCount: 0))
    }

    func getSnapshot(in context: Context, completion: @escaping (MeowWidgetEntry) -> Void) {
        let placeholder = MeowWidgetEntry(date: Date(), video: Video(id: 0, title: "Snapshot", description: "Loading...", authorName: "Author", viewCount: 0, likeCount: 0, coinCount: 0, shareCount: 0, danmakuCount: 0))
        completion(placeholder)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MeowWidgetEntry>) -> Void) {
        BiliBiliAPIService.shared.fetchPopularVideos { videos in
            let entries: [MeowWidgetEntry] = videos.enumerated().map { index, video in
                let interval = 10 * 60 // 每10分钟更新
                let date = Calendar.current.date(byAdding: .second, value: interval * index, to: Date()) ?? Date()
                return MeowWidgetEntry(date: date, video: video)
            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct MeowWidgetView: View {
    @Environment(\.widgetFamily) var family
    var entry: MeowWidgetEntry

    var body: some View {
        switch family {
        case .accessoryInline:
            Text("\(entry.video.title) ，作者： \(entry.video.authorName)")
        case .accessoryCircular:
            VStack {
                Image(systemName: "play.circle.fill")
                Text(entry.video.title)
                    .font(.caption)
            }
        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Text(entry.video.title)
                    .font(.headline)
                Text("作者： \(entry.video.authorName)")
                    .font(.subheadline)
            }
        case .systemSmall:
            VStack {
                Text(entry.video.title)
                    .font(.headline)
                Text("作者： \(entry.video.authorName)")
                    .font(.subheadline)
            }
        case .systemMedium:
            HStack {
                VStack(alignment: .leading) {
                    Text(entry.video.title)
                        .font(.headline)
                    Text(entry.video.description)
                        .font(.caption)
                        .lineLimit(2)
                }
                Spacer()
                VStack {
                    Text("观看量： \(entry.video.viewCount)")
                    Text("点赞量： \(entry.video.likeCount)")
                }
            }
        case .systemLarge:
            VStack(alignment: .leading) {
                Text(entry.video.title)
                    .font(.title)
                Text(entry.video.description)
                    .font(.body)
                    .lineLimit(3)
                Spacer()
                HStack {
                    Text("观看量： \(entry.video.viewCount)")
                    Text("点赞量： \(entry.video.likeCount)")
                }
            }
        default:
            Text("Unsupported Widget Family")
        }
    }
}

@main
struct MeowWidget: Widget {
    let kind: String = "MeowWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MeowWidgetView(entry: entry)
        }
        .configurationDisplayName("MeowWidget")
        .description("热门或推荐的视频内容")
        .supportedFamilies(families)
    }
    
    private var families: [WidgetFamily] {
        #if os(watchOS)
        return [.accessoryInline, .accessoryCircular, .accessoryRectangular]
        #else
        return [.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular]
        #endif
    }
}

/*The Old Version For Reference in Future Updates
 
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
        MeowWidgetEntry(date: Date(), videoTitle: "miku miku oo ee oo", videoDescription: "https://twitter.com/i/status/1697029186777706544 channel（twi:_CASTSTATION）", videoAuthor: "未来de残像", videoViews: "365.4万")
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
            case .systemSmall:
                Text("在喵哩喵哩查看视频")
                    .font(.headline)
                
            case .systemMedium:
                Text(entry.videoTitle)
                    .font(.headline)
                Text(entry.videoDescription)
                    .font(.subheadline)
                
            case .systemLarge:
                Text(entry.videoTitle)
                    .font(.headline)
                Text(entry.videoDescription)
                    .font(.subheadline)
                VStack(alignment: .leading) {
                    Text("作者: \(entry.videoAuthor)")
                        .font(.footnote)
                    Text("播放量: \(entry.videoViews)")
                        .font(.footnote)
                }
                Spacer()
                Text("在喵哩喵哩查看视频")
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
*/
