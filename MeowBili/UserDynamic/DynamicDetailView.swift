//
//
//  DynamicDetailView.swift
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
#if !os(visionOS)
import SDWebImageSwiftUI
#endif

struct DynamicDetailView: View {
    var dynamicDetails: [String: Any?]
    @State var isDynamicImagePresented = [Bool]()
    var body: some View {
        TabView {
            ScrollView {
                VStack {
                    NavigationLink(destination: { UserDetailView(uid: dynamicDetails["SenderID"]! as! String) }, label: {
                        HStack {
                            #if !os(visionOS)
                            WebImage(url: URL(string: dynamicDetails["SenderPic"]! as! String + "@30w"), options: [.progressiveLoad])
                                .clipShape(Circle())
                            #else
                            AsyncImage(url: URL(string: dynamicDetails["SenderPic"]! as! String + "@30w"))
                                .clipShape(Circle())
                            #endif
                            VStack {
                                HStack {
                                    Text(dynamicDetails["SenderName"]! as! String)
                                        .font(.system(size: 14, weight: .bold))
                                        .lineLimit(1)
                                    Spacer()
                                }
                                HStack {
                                    Text(dynamicDetails["SendTimeStr"]! as! String + { () -> String in
                                        switch dynamicDetails["Type"]! as! BiliDynamicType {
                                        case .draw, .text:
                                            return ""
                                        case .video:
                                            return " · 投稿了视频"
                                        case .live:
                                            return "直播了"
                                        case .forward:
                                            return " · 转发动态"
                                        case .article:
                                            return " · 投稿了专栏"
                                        }
                                    }())
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                    })
                    .buttonStyle(.plain)
                    if dynamicDetails["WithText"]! as! String != "" {
                        HStack {
                            LinkDetectText(inputURL: Binding<String>(get: {
                                dynamicDetails["WithText"]! as! String
                            }, set: { _ in }))
                            .font(.system(size: 16))
                            Spacer()
                        }
                    }
                    if dynamicDetails["Type"]! as! BiliDynamicType == .draw {
                        if let draws = dynamicDetails["Draws"] as? [[String: String]] {
                            #if !os(visionOS)
                            #if !os(watchOS)
                            LazyVGrid(columns: [GridItem(.fixed((UIScreen.main.bounds.width - 50) / 3)), GridItem(.fixed((UIScreen.main.bounds.width - 50) / 3)), GridItem(.fixed((UIScreen.main.bounds.width - 50) / 3))]) {
                                ForEach(0..<draws.count, id: \.self) { j in
                                    VStack {
                                        NavigationLink(destination: { ImageViewerView(url: draws[j]["Src"]!) }) {
                                            WebImage(url: URL(string: draws[j]["Src"]!), options: [.progressiveLoad])
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                            #else
                            LazyVGrid(columns: [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]) {
                                ForEach(0..<draws.count, id: \.self) { i in
                                    if isDynamicImagePresented.count > i {
                                        VStack {
                                            NavigationLink("", isActive: $isDynamicImagePresented[i], destination: { ImageViewerView(url: draws[i]["Src"]!) })
                                                .frame(width: 0, height: 0)
                                            WebImage(url: URL(string: draws[i]["Src"]! + "@60w_40h"), options: [.progressiveLoad])
                                                .cornerRadius(5)
                                                .onTapGesture {
                                                    isDynamicImagePresented[i] = true
                                                }
                                        }
                                    }
                                }
                            }
                            #endif
                            #else
                            LazyVGrid(columns: [GridItem(.fixed((globalWindowSize.width - 50) / 3)), GridItem(.fixed((globalWindowSize.width - 50) / 3)), GridItem(.fixed((globalWindowSize.width - 50) / 3))]) {
                                ForEach(0..<draws.count, id: \.self) { j in
                                    VStack {
                                        NavigationLink(destination: { ImageViewerView(url: draws[j]["Src"]!) }) {
                                            AsyncImage(url: URL(string: draws[j]["Src"]!)) { phase in
                                                switch phase {
                                                case .empty:
                                                    Color.clear
                                                        .frame(width: 0, height: 0)
                                                case .success(let image):
                                                    image.resizable()
                                                case .failure(let error):
                                                    Color.clear
                                                        .frame(width: 0, height: 0)
                                                }
                                            }
                                            .scaledToFit()
                                            .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                            #endif
                        }
                    } else if dynamicDetails["Type"]! as! BiliDynamicType == .video {
                        if let archive = dynamicDetails["Archive"] as? [String: String] {
                            VideoCard(archive)
                        }
                    } else if dynamicDetails["Type"]! as! BiliDynamicType == .live {
                        if let liveInfo = dynamicDetails["Live"] as? [String: String] {
                            NavigationLink(destination: { LiveDetailView(liveDetails: liveInfo) }, label: {
                                VStack {
                                    HStack {
                                        #if !os(visionOS)
                                        WebImage(url: URL(string: liveInfo["Cover"]! + "@50w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                                            .placeholder {
                                                RoundedRectangle(cornerRadius: 7)
                                                    .frame(width: 50)
                                                    .foregroundColor(Color(hex: 0x3D3D3D))
                                                    .redacted(reason: .placeholder)
                                            }
                                            .cornerRadius(7)
                                        #else
                                        AsyncImage(url: URL(string: liveInfo["Cover"]! + "@50w")!) { phase in
                                            switch phase {
                                            case .empty:
                                                RoundedRectangle(cornerRadius: 7)
                                                    .frame(width: 50)
                                                    .foregroundColor(Color(hex: 0x3D3D3D))
                                                    .redacted(reason: .placeholder)
                                            case .success(let image):
                                                image
                                            case .failure(let error):
                                                RoundedRectangle(cornerRadius: 7)
                                                    .frame(width: 50)
                                                    .foregroundColor(Color(hex: 0x3D3D3D))
                                                    .redacted(reason: .placeholder)
                                            }
                                        }
                                        .cornerRadius(7)
                                        #endif
                                        Text(liveInfo["Title"]!)
                                            .font(.system(size: 14, weight: .bold))
                                            .lineLimit(2)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(liveInfo["Type"]!) · \(liveInfo["ViewStr"]!)")
                                        Spacer()
                                    }
                                    .lineLimit(1)
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 14))
                        }
                    } else if dynamicDetails["Type"]! as! BiliDynamicType == .forward {
                        if let origData = dynamicDetails["Forward"] as? [String: Any?]? {
                            if let orig = origData {
                                NavigationLink(destination: { DynamicDetailView(dynamicDetails: orig) }, label: {
                                    VStack {
                                        HStack {
                                            #if !os(visionOS)
                                            WebImage(url: URL(string: orig["SenderPic"]! as! String + "@30w"), options: [.progressiveLoad])
                                                .clipShape(Circle())
                                            #else
                                            AsyncImage(url: URL(string: orig["SenderPic"]! as! String + "@30w"))
                                                .clipShape(Circle())
                                            #endif
                                            VStack {
                                                HStack {
                                                    Text(orig["SenderName"]! as! String)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .lineLimit(1)
                                                    Spacer()
                                                }
                                                HStack {
                                                    Text(orig["SendTimeStr"]! as! String + { () -> String in
                                                        switch orig["Type"]! as! BiliDynamicType {
                                                        case .draw, .text:
                                                            return ""
                                                        case .video:
                                                            return "投稿了视频"
                                                        case .live:
                                                            return "直播了"
                                                        case .forward:
                                                            return "转发动态"
                                                        case .article:
                                                            return "投稿了专栏"
                                                        }
                                                    }())
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.gray)
                                                    .lineLimit(1)
                                                    Spacer()
                                                }
                                            }
                                            Spacer()
                                        }
                                        if orig["WithText"]! as! String != "" {
                                            HStack {
                                                LinkDetectText(inputURL: Binding<String>(get: {
                                                    orig["WithText"]! as! String
                                                }, set: { _ in }))
                                                .font(.system(size: 16))
                                                    .lineLimit(5)
                                                Spacer()
                                            }
                                        }
                                        if orig["Type"]! as! BiliDynamicType == .draw {
                                            if let draws = orig["Draws"] as? [[String: String]] {
                                                #if !os(visionOS)
                                                #if !os(watchOS)
                                                LazyVGrid(columns: [GridItem(.fixed((UIScreen.main.bounds.width - 50) / 3)), GridItem(.fixed((UIScreen.main.bounds.width - 50) / 3)), GridItem(.fixed((UIScreen.main.bounds.width - 50) / 3))]) {
                                                    ForEach(0..<draws.count, id: \.self) { j in
                                                        VStack {
                                                            NavigationLink(destination: { ImageViewerView(url: draws[j]["Src"]!) }) {
                                                                WebImage(url: URL(string: draws[j]["Src"]!), options: [.progressiveLoad])
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .cornerRadius(5)
                                                            }
                                                        }
                                                    }
                                                }
                                                #else
                                                LazyVGrid(columns: [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]) {
                                                    ForEach(0..<draws.count, id: \.self) { i in
                                                        if isDynamicImagePresented.count > i {
                                                            VStack {
                                                                NavigationLink("", isActive: $isDynamicImagePresented[i], destination: { ImageViewerView(url: draws[i]["Src"]!) })
                                                                    .frame(width: 0, height: 0)
                                                                WebImage(url: URL(string: draws[i]["Src"]! + "@60w_40h"), options: [.progressiveLoad])
                                                                    .cornerRadius(5)
                                                                    .onTapGesture {
                                                                        isDynamicImagePresented[i] = true
                                                                    }
                                                            }
                                                        }
                                                    }
                                                }
                                                #endif
                                                #else
                                                LazyVGrid(columns: [GridItem(.fixed((globalWindowSize.width - 50) / 3)), GridItem(.fixed((globalWindowSize.width - 50) / 3)), GridItem(.fixed((globalWindowSize.width - 50) / 3))]) {
                                                    ForEach(0..<draws.count, id: \.self) { j in
                                                        VStack {
                                                            NavigationLink(destination: { ImageViewerView(url: draws[j]["Src"]!) }) {
                                                                AsyncImage(url: URL(string: draws[j]["Src"]!)) { phase in
                                                                    switch phase {
                                                                    case .empty:
                                                                        Color.clear
                                                                            .frame(width: 0, height: 0)
                                                                    case .success(let image):
                                                                        image.resizable()
                                                                    case .failure(let error):
                                                                        Color.clear
                                                                            .frame(width: 0, height: 0)
                                                                    }
                                                                }
                                                                .scaledToFit()
                                                                .cornerRadius(5)
                                                            }
                                                        }
                                                    }
                                                }
                                                #endif
                                            }
                                        } else if orig["Type"]! as! BiliDynamicType == .video {
                                            if let archive = orig["Archive"] as? [String: String] {
                                                VideoCard(archive)
                                                    .disabled(true)
                                            }
                                        } else if orig["Type"]! as! BiliDynamicType == .live {
                                            if let liveInfo = orig["Live"] as? [String: String] {
                                                NavigationLink(destination: { LiveDetailView(liveDetails: liveInfo) }, label: {
                                                    VStack {
                                                        HStack {
                                                            #if !os(visionOS)
                                                            WebImage(url: URL(string: liveInfo["Cover"]! + "@50w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                                                                .placeholder {
                                                                    RoundedRectangle(cornerRadius: 7)
                                                                        .frame(width: 50)
                                                                        .foregroundColor(Color(hex: 0x3D3D3D))
                                                                        .redacted(reason: .placeholder)
                                                                }
                                                                .cornerRadius(7)
                                                            #else
                                                            AsyncImage(url: URL(string: liveInfo["Cover"]! + "@50w")!) { phase in
                                                                switch phase {
                                                                case .empty:
                                                                    RoundedRectangle(cornerRadius: 7)
                                                                        .frame(width: 50)
                                                                        .foregroundColor(Color(hex: 0x3D3D3D))
                                                                        .redacted(reason: .placeholder)
                                                                case .success(let image):
                                                                    image
                                                                case .failure(let error):
                                                                    RoundedRectangle(cornerRadius: 7)
                                                                        .frame(width: 50)
                                                                        .foregroundColor(Color(hex: 0x3D3D3D))
                                                                        .redacted(reason: .placeholder)
                                                                }
                                                            }
                                                            .cornerRadius(7)
                                                            #endif
                                                            Text(liveInfo["Title"]!)
                                                                .font(.system(size: 14, weight: .bold))
                                                                .lineLimit(2)
                                                            Spacer()
                                                        }
                                                        HStack {
                                                            Text("\(liveInfo["Type"]!) · \(liveInfo["ViewStr"]!)")
                                                            Spacer()
                                                        }
                                                        .lineLimit(1)
                                                        .font(.system(size: 11))
                                                        .foregroundColor(.gray)
                                                    }
                                                })
                                                .buttonBorderShape(.roundedRectangle(radius: 14))
                                                .disabled(true)
                                            }
                                        }
                                    }
                                })
                                .buttonBorderShape(.roundedRectangle(radius: 14))
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("动态详情")
            .navigationBarTitleDisplayMode(.inline)
            .tag(1)
            .tabItem {
                Label("内容", systemImage: "shippingbox.fill")
            }
            if dynamicDetails["Type"]! as! BiliDynamicType == .text || dynamicDetails["Type"]! as! BiliDynamicType == .forward || dynamicDetails["Type"]! as! BiliDynamicType == .draw {
                CommentsView(oid: dynamicDetails["DynamicID"]! as! String, type: (dynamicDetails["Type"]! as! BiliDynamicType) == .draw ? 11 : 17)
                    .navigationTitle("动态评论")
                    .navigationBarTitleDisplayMode(.inline)
                    .tag(2)
                    .tabItem {
                        Label("评论", systemImage: "bubble.left.and.text.bubble.right.fill")
                    }
            }
        }
    }
}

//#Preview {
//    DynamicDetailView()
//}
