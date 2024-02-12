//
//
//  UIExt.swift
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

import UIKit
import WebKit
import SwiftUI
import Foundation
import SDWebImageSwiftUI
import MobileCoreServices
import AuthenticationServices

@ViewBuilder func VideoCard(_ videoDetails: [String: String]) -> some View {
    NavigationLink(destination: {VideoDetailView(videoDetails: videoDetails)}, label: {
        VStack {
            HStack {
                WebImage(url: URL(string: videoDetails["Pic"]! + "@200w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .cornerRadius(7)
                Text(videoDetails["Title"]!)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Image(systemName: "play.circle")
                Text(videoDetails["View"]!.shorter())
                    .offset(x: -3)
                Image(systemName: "person")
                Text(videoDetails["UP"]!)
                    .offset(x: -3)
                Spacer()
            }
            .lineLimit(1)
            .font(.system(size: 11))
            .foregroundColor(.gray)
        }
    })
    .buttonBorderShape(.roundedRectangle(radius: 14))
    .onDrag {
        PlayHaptic(sharpness: 0.05, intensity: 0.5)
        var cpdDetail = videoDetails
        cpdDetail.updateValue("archive", forKey: "Type")
        let itemData = try? NSKeyedArchiver.archivedData(withRootObject: cpdDetail, requiringSecureCoding: false)
        let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: kUTTypeData as String)
        return provider
    }
}

@ViewBuilder func BangumiCard(_ bangumiData: BangumiData) -> some View {
    NavigationLink(destination: {BangumiDetailView(bangumiData: bangumiData)}, label: {
        VStack {
            HStack {
                WebImage(url: URL(string: bangumiData.cover + "@100w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50, height: 30)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .cornerRadius(7)
                Text(bangumiData.title)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(2)
                Spacer()
            }
            HStack {
                if let score = bangumiData.score {
                    Image(systemName: "star.fill")
                    Text(score.score ~ 1)
                        .offset(x: -3)
                }
                if let style = bangumiData.style {
                    Image(systemName: "sparkles")
                    Text(style)
                        .lineLimit(1)
                        .offset(x: -3)
                }
                Spacer()
            }
            .lineLimit(1)
            .font(.system(size: 11))
            .foregroundColor(.gray)
        }
    })
    .buttonBorderShape(.roundedRectangle(radius: 14))
}

@ViewBuilder func LiveCard(_ liveDetails: [String: String]) -> some View {
    NavigationLink(destination: {LiveDetailView(liveDetails: liveDetails)}, label: {
        VStack {
            HStack {
                WebImage(url: URL(string: liveDetails["Cover"]! + "@100w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50, height: 30)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .cornerRadius(7)
                Text(liveDetails["Title"]!)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Image(systemName: "tag")
                Text(liveDetails["Type"]!)
                    .offset(x: -3)
                Spacer()
            }
            .lineLimit(1)
            .font(.system(size: 11))
            .foregroundColor(.gray)
        }
    })
    .buttonBorderShape(.roundedRectangle(radius: 14))
}

@ViewBuilder func ArticleCard(_ article: [String: String]) -> some View {
    NavigationLink(destination: {ArticleView(cvid: article["CV"]!)}, label: {
        VStack {
            HStack {
                Text(article["Title"]!)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(3)
                Spacer()
            }
            HStack {
                VStack {
                    Text(article["Summary"]!)
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(3)
                        .foregroundColor(.gray)
                    HStack {
                        Text(article["Type"]!)
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .foregroundColor(.gray)
                        Label(article["View"]!, systemImage: "eye.fill")
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .foregroundColor(.gray)
                        Label(article["Like"]!, systemImage: "hand.thumbsup.fill")
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .foregroundColor(.gray)
                    }
                }
                WebImage(url: URL(string: article["Pic"]! + "@100w"), options: [.progressiveLoad])
                    .cornerRadius(4)
            }
        }
    })
}

//struct zoomable: ViewModifier {
//    @AppStorage("MaxmiumScale") var maxmiumScale = 6.0
//    @State var scale: CGFloat = 1.0
//    @State var offset = CGSize.zero
//    @State var lastOffset = CGSize.zero
//    func body(content: Content) -> some View {
//            content
//                .scaleEffect(self.scale)
//                .focusable()
//                .digitalCrownRotation($scale, from: 0.5, through: maxmiumScale, by: 0.02, sensitivity: .low, isHapticFeedbackEnabled: true)
//                .offset(x: offset.width, y: offset.height)
//                .gesture(
//                    DragGesture()
//                        .onChanged { gesture in
//                            offset = CGSize(width: gesture.translation.width + lastOffset.width, height: gesture.translation.height + lastOffset.height)
//                        }
//                        .onEnded { _ in
//                            lastOffset = offset
//                        }
//                )
//                .onDisappear {
//                    offset = CGSize.zero
//                    lastOffset = CGSize.zero
//                }
//                .onChange(of: scale) { value in
//                    if value < 2.0 {
//                        withAnimation(.easeInOut(duration: 0.3)) {
//                            offset = CGSize.zero
//                            lastOffset = CGSize.zero
//                        }
//                    }
//                }
//    }
//}

extension Indicator where T == ProgressView<EmptyView, EmptyView> {
    static var activity: Indicator {
        Indicator { isAnimating, progress in
            ProgressView()
        }
    }
    
    static var progress: Indicator {
        Indicator { isAnimating, progress in
            ProgressView(value: progress.wrappedValue)
        }
    }
}

struct UIImageTransfer: Transferable {
  let image: UIImage
  enum TransferError: Error {
    case importFailed
  }
  
  static var transferRepresentation: some TransferRepresentation {
    DataRepresentation(importedContentType: .image) { data in
        guard let uiImage = UIImage(data: data) else {
          throw TransferError.importFailed
        }
        return UIImageTransfer(image: uiImage)
    }
  }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
