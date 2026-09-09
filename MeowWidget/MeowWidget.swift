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

import SwiftUI
import WidgetKit

struct MeowWidgetEntry: TimelineEntry {
    let date: Date
    let video: Video
    var coverImage: UIImage?
    var accentColor: Color?
}

struct Provider: TimelineProvider {
    @AppStorage("WidgetRefreshInterval") private var refreshInterval: Int = 10
    func placeholder(in context: Context) -> MeowWidgetEntry {
        MeowWidgetEntry(
            date: Date(),
            video: Video(
                id: 0,
                title: "miku miku oo ee oo",
                description: "https://twitter.com/i/status/1697029186777706544 channel（twi:_CASTSTATION）",
                coverImageURL: URL(string: "https://example.com")!,
                authorName: "未来de残像",
                viewCount: 0,
                likeCount: 0,
                coinCount: 0,
                shareCount: 0,
                danmakuCount: 0
            )
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (MeowWidgetEntry) -> Void) {
        let placeholder = MeowWidgetEntry(
            date: Date(),
            video: Video(
                id: 0,
                title: "miku miku oo ee o",
                description: "https://twitter.com/i/status/1697029186777706544 channel（twi:_CASTSTATION）",
                coverImageURL: URL(string: "https://example.com")!,
                authorName: "未来de残像",
                viewCount: 0,
                likeCount: 0,
                coinCount: 0,
                shareCount: 0,
                danmakuCount: 0
            )
        )
        completion(placeholder)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MeowWidgetEntry>) -> Void) {
        BiliBiliAPIService.shared.fetchPopularVideos { videos in
            Task {
                var entries: [MeowWidgetEntry] = videos.enumerated().map { index, video in
                    let interval = refreshInterval * 60
                    let date = Calendar.current.date(byAdding: .second, value: interval * index, to: .now) ?? .now
                    return MeowWidgetEntry(date: date, video: video)
                }
                
                await withTaskGroup { group in
                    for (index, entry) in entries.enumerated() {
                        group.addTask {
                            let urlString = entry.video.coverImageURL.absoluteString
                            let url = URL(string: urlString + "@400w")!
                            if let (data, _) = try? await URLSession.shared.data(from: url),
                               let image = UIImage(data: data) {
                                entries[index].coverImage = image
                                #if !os(watchOS)
                                if let color = ColorThief.getColor(from: image) {
                                    entries[index].accentColor = Color(uiColor: color.makeUIColor())
                                }
                                #endif
                            }
                        }
                    }
                }
                
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            }
        }
    }
}

struct MeowWidgetView: View {
    @Environment(\.widgetFamily) private var family
    var entry: MeowWidgetEntry
    
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
            ZStack {
                if let image = entry.coverImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .blur(radius: 30)
                }
                Group {
                    VStack {
                        HStack(spacing: 5) {
                            Image("AppIconImageTemplate")
                                .resizable()
                                .interpolation(.high)
                                .foregroundStyle(.accent)
                                .frame(width: 30, height: 30)
                            Spacer()
                            Text(entry.video.authorName)
                        }
                        .font(.caption)
                        Spacer()
                    }
                    .offset(y: -5)
                    VStack(alignment: .leading) {
                        Text(entry.video.title)
                            .font(.system(size: 17, weight: .bold))
                        Text(entry.video.description)
                            .font(.caption)
                    }
                    .lineLimit(2)
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Spacer()
                            HStack {
                                Text("\(entry.video.viewCount)")
                                Image(systemName: "play.fill")
                                    .frame(width: 10)
                            }
                            HStack {
                                Text("\(entry.video.likeCount)")
                                Image(systemName: "hand.thumbsup.fill")
                                    .frame(width: 10)
                            }
                        }
                        .lineLimit(1)
                        .font(.caption)
                    }
                    .padding(.bottom, -5)
                    .padding(.trailing, 5)
                }
                .foregroundStyle(.white)
                .padding()
                .padding(.horizontal, 60)
            }
            .widgetURL(widgetURL)
        case .systemMedium:
            ZStack {
                if let image = entry.coverImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                if let color = entry.accentColor {
                    VStack {
                        Rectangle()
                            .fill(.clear)
                        Rectangle()
                            .fill(LinearGradient(colors: [
                                color.opacity(0),
                                color.opacity(0.5),
                                color,
                                color
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: 100)
                    }
                }
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(entry.video.title)
                                .font(.title3)
                            Text(entry.video.description)
                                .font(.caption)
                        }
                        .lineLimit(1)
                        Spacer(minLength: 5)
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("\(entry.video.viewCount)")
                                Image(systemName: "play")
                                    .frame(width: 10)
                            }
                            HStack {
                                Text("\(entry.video.likeCount)")
                                Image(systemName: "hand.thumbsup")
                                    .frame(width: 10)
                            }
                        }
                        .font(.caption)
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .padding(.bottom, 10)
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
                .containerBackground(.background, for: .widget)
        }
        .contentMarginsDisabled()
        .configurationDisplayName("喵哩喵哩小组件")
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
