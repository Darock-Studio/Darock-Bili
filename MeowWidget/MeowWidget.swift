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
    @AppStorage("widgetRefreshInterval") var refreshInterval: Int = 10
    func placeholder(in context: Context) -> MeowWidgetEntry {
        MeowWidgetEntry(date: Date(), video: Video(id: 0, title: "miku miku oo ee oo", description: "https://twitter.com/i/status/1697029186777706544 channel（twi:_CASTSTATION）", authorName: "未来de残像", viewCount: 0, likeCount: 0, coinCount: 0, shareCount: 0, danmakuCount: 0))
    }

    func getSnapshot(in context: Context, completion: @escaping (MeowWidgetEntry) -> Void) {
        let placeholder = MeowWidgetEntry(date: Date(), video: Video(id: 0, title: "miku miku oo ee o", description: "https://twitter.com/i/status/1697029186777706544 channel（twi:_CASTSTATION）", authorName: "未来de残像", viewCount: 0, likeCount: 0, coinCount: 0, shareCount: 0, danmakuCount: 0))
        completion(placeholder)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MeowWidgetEntry>) -> Void) {
        BiliBiliAPIService.shared.fetchPopularVideos { videos in
            let entries: [MeowWidgetEntry] = videos.enumerated().map { index, video in
                let interval = refreshInterval * 60 // 每10分钟更新的时代已经结束了～不然可太杂鱼咯～嘻嘻～
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
    
    @ViewBuilder
    var body: some View {
        let widgetURL = URL(string: "wget://openURL/\(entry.video.id)")
        switch family {
        case .accessoryInline:
            Text(entry.video.title)
                .widgetURL(widgetURL)
        case .accessoryCircular:
            VStack {
                Image(systemName: "play.circle.fill")
                    .foregroundColor(Color("WidgetTitleColor"))
                Text(entry.video.title)
                    .font(.caption)
            }
            .widgetURL(widgetURL)
        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Text(entry.video.title)
                    .font(.headline)
                Text(entry.video.authorName)
                    .font(.subheadline)
            }
            .widgetURL(widgetURL)
        case .systemSmall:
            Text("在喵哩喵哩查看视频")
                .font(.headline)
            .widgetURL(widgetURL)
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
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "play.rectangle")
                            .foregroundColor(Color("WidgetTitleColor"))
                        Text("\(entry.video.viewCount)")
                            .font(.caption)
                    }
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("WidgetTitleColor"))
                        Text("\(entry.video.likeCount)")
                            .font(.caption)
                    }
                }
            }
            .widgetURL(widgetURL)
        case .systemLarge:
            VStack(alignment: .leading) {
                Text(entry.video.title)
                    .font(.headline)
                Text(entry.video.description)
                    .font(.caption)
                    .lineLimit(3)
                Spacer()
                HStack {
                    HStack {
                        Image(systemName: "play.rectangle.fill")
                            .foregroundColor(Color("WidgetTitleColor"))
                        Text("\(entry.video.viewCount)")
                            .font(.footnote)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("WidgetTitleColor"))
                        Text("\(entry.video.likeCount)")
                            .font(.footnote)
                    }
                }
                Spacer()
                Text("在喵哩喵哩查看更多视频")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .widgetURL(widgetURL)
        default:
            Text("Unsupported Widget Family")
        }
    }
}
    
struct MeowWidget: Widget {
    let kind: String = "MeowWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MeowWidgetView(entry: entry)
        }
        .configurationDisplayName("MeowWidget")
        .description("热门或推荐的视频内容")
        #if os(watchOS)
        .supportedFamilies([.accessoryCircular,
                            .accessoryRectangular, .accessoryInline])
        #else
        .supportedFamilies([.accessoryCircular,
                            .accessoryRectangular, .accessoryInline,
                            .systemSmall, .systemMedium, .systemLarge])
        #endif
    }
}
