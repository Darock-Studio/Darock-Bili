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
import DarockKit
import Alamofire
import Foundation
#if !os(visionOS)
import SDWebImageSwiftUI
#endif
import MobileCoreServices
import AuthenticationServices

@ViewBuilder func VideoCard(_ videoDetails: [String: String], onAppear: @escaping () -> Void = {}) -> some View {
    NavigationLink(destination: {VideoDetailView(videoDetails: videoDetails).onAppear { onAppear() }}, label: {
        VStack {
            HStack {
                #if !os(visionOS)
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
                #else
                AsyncImage(url: URL(string: videoDetails["Pic"]! + "@200w")!) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    case .success(let image):
                        image.resizable()
                    case .failure(let error):
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                }
                .scaledToFit()
                .frame(width: 100)
                .cornerRadius(7)
                #endif
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
        if (UserDefaults.standard.object(forKey: "IsUseExtHaptic") as? Bool) ?? true {
            PlayHaptic(sharpness: 0.05, intensity: 0.5)
        }
        var cpdDetail = videoDetails
        cpdDetail.updateValue("archive", forKey: "Type")
        let itemData = try? NSKeyedArchiver.archivedData(withRootObject: cpdDetail, requiringSecureCoding: false)
        let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: kUTTypeData as String)
        return provider
    }
    .onDrop(of: [kUTTypeData as String], isTargeted: nil) { items in
        if (UserDefaults.standard.object(forKey: "IsUseExtHaptic") as? Bool) ?? true {
            PlayHaptic(sharpness: 0.05, intensity: 0.5)
        }
        for item in items {
            item.loadDataRepresentation(forTypeIdentifier: kUTTypeData as String) { (data, error) in
                if let data = data, let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String] {
                    if let action = dict["VideoAction"] {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(UserDefaults.standard.string(forKey: "SESSDATA") ?? ""); buvid3=\(globalBuvid3)",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        let biliJct = UserDefaults.standard.string(forKey: "bili_jct") ?? ""
                        if action == "Like" {
                            AF.request("https://api.bilibili.com/x/web-interface/archive/like", method: .post, parameters: ["bvid": videoDetails["BV"]!, "like": 1, "eab_x": 2, "ramval": 0, "source": "web_normal", "ga": 1, "csrf": biliJct], headers: headers).response { _ in
                                if items.count == 1 {
                                    #if !os(visionOS)
                                    AlertKitAPI.present(title: "已点赞", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                    #endif
                                } else if item == items.last! {
                                    #if !os(visionOS)
                                    AlertKitAPI.present(title: "已完成\(items.count)项操作", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                    #endif
                                }
                            }
                        } else if action == "Coin" {
                            AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: videoDetails["BV"]!, multiply: 1, csrf: biliJct), headers: headers).response { _ in
                                if items.count == 1 {
                                    #if !os(visionOS)
                                    AlertKitAPI.present(title: "已投币", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                    #endif
                                } else if item == items.last! {
                                    #if !os(visionOS)
                                    AlertKitAPI.present(title: "已完成\(items.count)项操作", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                    #endif
                                }
                            }
                        } else if action == "Favorite" {
                            let avid = bv2av(bvid: videoDetails["BV"]!)
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v3/fav/folder/created/list-all?type=2&rid=\(avid)&up_mid=\(UserDefaults.standard.string(forKey: "DedeUserID") ?? "")", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    if !CheckBApiError(from: respJson) { return }
                                    AF.request("https://api.bilibili.com/x/v3/fav/resource/deal", method: .post, parameters: ["rid": avid, "type": 2, "add_media_ids": respJson["data"]["list"][0]["id"].int ?? 0, "csrf": biliJct], headers: headers).response { _ in
                                        if items.count == 1 {
                                            #if !os(visionOS)
                                            AlertKitAPI.present(title: "已收藏", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                            #endif
                                        } else if item == items.last! {
                                            #if !os(visionOS)
                                            AlertKitAPI.present(title: "已完成\(items.count)项操作", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                            #endif
                                        }
                                     }
                                }
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}

@ViewBuilder func BangumiCard(_ bangumiData: BangumiData) -> some View {
    NavigationLink(destination: {BangumiDetailView(bangumiData: bangumiData)}, label: {
        VStack {
            HStack {
                #if !os(visionOS)
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
                #else
                AsyncImage(url: URL(string: bangumiData.cover + "@100w")!) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50, height: 30)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    case .success(let image):
                        image.resizable()
                    case .failure(let error):
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50, height: 30)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                }
                .scaledToFit()
                .frame(width: 50)
                .cornerRadius(7)
                #endif
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
                #if !os(visionOS)
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
                #else
                AsyncImage(url: URL(string: liveDetails["Cover"]! + "@100w")!) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50, height: 30)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    case .success(let image):
                        image.resizable()
                    case .failure(let error):
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50, height: 30)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                }
                .scaledToFit()
                .frame(width: 50)
                .cornerRadius(7)
                #endif
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
                #if !os(visionOS)
                WebImage(url: URL(string: article["Pic"]! + "@100w"), options: [.progressiveLoad])
                    .cornerRadius(4)
                #else
                AsyncImage(url: URL(string: article["Pic"]! + "@100w"))
                    .cornerRadius(4)
                #endif
            }
        }
    })
}

struct zoomable: ViewModifier {
    @AppStorage("MaxmiumScale") var maxmiumScale = 6.0
    @State var scale: CGFloat = 1.0
    @State var offset = CGSize.zero
    @State var lastOffset = CGSize.zero
    func body(content: Content) -> some View {
            content
                .scaleEffect(self.scale)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = CGSize(width: gesture.translation.width + lastOffset.width, height: gesture.translation.height + lastOffset.height)
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            self.scale = value
                        }
                )
                .onDisappear {
                    offset = CGSize.zero
                    lastOffset = CGSize.zero
                }
    }
}

#if !os(visionOS)
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
#endif

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

@usableFromInline
struct TextSelectView: View {
    @usableFromInline
    var text: String
    
    @usableFromInline
    init(text: String) {
        self.text = text
    }
    
    @usableFromInline
    var body: some View {
        VStack {
            TextEditor(text: .constant(text))
                .padding()
        }
    }
}

struct CopyableView<V: View>: View {
    var content: String
    var allowSelect: Bool
    var view: () -> V
    @State var present = false
    init(_ content: String, allowSelect: Bool = true, view: @escaping () -> V) {
        self.content = content
        self.allowSelect = allowSelect
        self.view = view
    }
    var body: some View {
        view()
            .contextMenu {
                Button(action: {
                    UIPasteboard.general.string = content
                    #if !os(visionOS)
                    AlertKitAPI.present(title: "已复制", subtitle: "简介内容已复制到剪贴板", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                    #endif
                }, label: {
                    Label("复制", systemImage: "doc.on.doc")
                })
                if allowSelect {
                    Button(action: {
                        present = true
                    }, label: {
                        Label("选择文本", systemImage: "selection.pin.in.out")
                    })
                }
            }
            .sheet(isPresented: $present, content: {
                TextSelectView(text: content)
            })
    }
}

extension View {
    @usableFromInline func onPressChange(_ action: @escaping (Bool) -> Void) -> some View {
        self.buttonStyle(ButtonStyleForPressAction(pressAction: action))
    }
}
private struct ButtonStyleForPressAction: ButtonStyle {
    var pressAction: (Bool) -> Void
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { value in
                pressAction(value)
            }
    }
}

