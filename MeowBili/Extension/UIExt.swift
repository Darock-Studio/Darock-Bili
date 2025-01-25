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
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import UIKit
import SwiftUI
import Dynamic
import DarockUI
import NotifKit
import Alamofire
import Foundation
import DarockFoundation
import MobileCoreServices
import AuthenticationServices
import SDWebImageSwiftUI
#if os(watchOS)
import Cepheus
import WatchKit
#else
import WebKit
#endif

#if !os(watchOS)
@ViewBuilder
func VideoCard(_ videoDetails: [String: String], onAppear: @escaping () -> Void = {}) -> some View {
    NavigationLink(destination: { VideoDetailView(videoDetails: videoDetails).onAppear { onAppear() } }, label: {
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
        if (UserDefaults.standard.object(forKey: "IsUseExtHaptic") as? Bool) ?? true {
            PlayHaptic(sharpness: 0.05, intensity: 0.5)
        }
        var cpdDetail = videoDetails
        cpdDetail.updateValue("archive", forKey: "Type")
        let itemData = try? NSKeyedArchiver.archivedData(withRootObject: cpdDetail, requiringSecureCoding: false)
        let provider = NSItemProvider(item: itemData as NSSecureCoding?, typeIdentifier: UTType.data.identifier)
        return provider
    }
    .onDrop(of: [UTType.data.identifier], isTargeted: nil) { items in
        if (UserDefaults.standard.object(forKey: "IsUseExtHaptic") as? Bool) ?? true {
            PlayHaptic(sharpness: 0.05, intensity: 0.5)
        }
        for item in items {
            item.loadDataRepresentation(forTypeIdentifier: UTType.data.identifier) { (data, _) in
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
                                    tipWithText("已点赞", symbol: "checkmark.circle.fill")
                                } else if item == items.last! {
                                    tipWithText("已完成\(items.count)项操作", symbol: "checkmark.circle.fill")
                                }
                            }
                        } else if action == "Coin" {
                            AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: videoDetails["BV"]!, multiply: 1, csrf: biliJct), headers: headers).response { _ in
                                if items.count == 1 {
                                    tipWithText("已投币", symbol: "checkmark.circle.fill")
                                } else if item == items.last! {
                                    tipWithText("已完成\(items.count)项操作", symbol: "checkmark.circle.fill")
                                }
                            }
                        } else if action == "Favorite" {
                            let avid = bv2av(bvid: videoDetails["BV"]!)
                            requestJSON("https://api.bilibili.com/x/v3/fav/folder/created/list-all?type=2&rid=\(avid)&up_mid=\(UserDefaults.standard.string(forKey: "DedeUserID") ?? "")", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    if !CheckBApiError(from: respJson) { return }
                                    AF.request("https://api.bilibili.com/x/v3/fav/resource/deal", method: .post, parameters: ["rid": avid, "type": 2, "add_media_ids": respJson["data"]["list"][0]["id"].int ?? 0, "csrf": biliJct], headers: headers).response { _ in
                                        if items.count == 1 {
                                            tipWithText("已收藏", symbol: "checkmark.circle.fill")
                                        } else if item == items.last! {
                                            tipWithText("已完成\(items.count)项操作", symbol: "checkmark.circle.fill")
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

@ViewBuilder
func BangumiCard(_ bangumiData: BangumiData) -> some View {
    NavigationLink(destination: { BangumiDetailView(bangumiData: bangumiData) }, label: {
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

@ViewBuilder
func LiveCard(_ liveDetails: [String: String]) -> some View {
    NavigationLink(destination: { LiveDetailView(liveDetails: liveDetails) }, label: {
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

@ViewBuilder
func ArticleCard(_ article: [String: String]) -> some View {
    NavigationLink(destination: { ArticleView(cvid: article["CV"]!) }, label: {
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
#else
@ViewBuilder
func VideoCard(_ videoDetails: [String: String]) -> some View {
    NavigationLink(destination: { VideoDetailView(videoDetails: videoDetails) }, label: {
        VStack {
            HStack {
                WebImage(url: URL(string: videoDetails["Pic"]! + "@100w")!, options: [.progressiveLoad, .scaleDownLargeImages])
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
                Text(videoDetails["Title"]!)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(2)
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
            .opacity(0.6)
        }
    })
    .buttonBorderShape(.roundedRectangle(radius: 14))
}

@ViewBuilder
func BangumiCard(_ bangumiData: BangumiData) -> some View {
    NavigationLink(destination: { BangumiDetailView(bangumiData: bangumiData) }, label: {
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

@ViewBuilder
func LiveCard(_ liveDetails: [String: String]) -> some View {
    NavigationLink(destination: { LiveDetailView(liveDetails: liveDetails) }, label: {
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

struct SegmentedPicker: View {
    @Binding var selection: Int
    private var leftText: (any StringProtocol)?
    private var rightText: (any StringProtocol)?
    private var localizedLeftText: LocalizedStringKey?
    private var localizedRightText: LocalizedStringKey?
    @State private var selectionOffset: CGFloat = 0
    
    init(selection: Binding<Int>, leftText: LocalizedStringKey, rightText: LocalizedStringKey) {
        self._selection = selection
        self.localizedLeftText = leftText
        self.localizedRightText = rightText
    }
    init(selection: Binding<Bool>, leftText: LocalizedStringKey, rightText: LocalizedStringKey) {
        self._selection = Binding(get: { Int(selection.wrappedValue) }, set: { newValue in selection.wrappedValue = Bool(newValue) })
        self.localizedLeftText = leftText
        self.localizedRightText = rightText
    }
    @_disfavoredOverload
    init<S>(selection: Binding<Int>, leftText: S, rightText: S) where S: StringProtocol {
        self._selection = selection
        self.leftText = leftText
        self.rightText = rightText
    }
    @_disfavoredOverload
    init<S>(selection: Binding<Bool>, leftText: S, rightText: S) where S: StringProtocol {
        self._selection = Binding(get: { Int(selection.wrappedValue) }, set: { newValue in selection.wrappedValue = Bool(newValue) })
        self.leftText = leftText
        self.rightText = rightText
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9.8)
                .fill(Color(hex: 0x5d5251))
                .frame(height: 36)
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: 0x7d7877))
                    .frame(width: 75, height: 32)
                    .offset(x: selectionOffset)
                Spacer()
            }
            .padding(.horizontal, 3)
            HStack {
                Group {
                    if let lt = leftText, let rt = rightText {
                        Text(lt)
                            .onTapGesture {
                                selection = 0
                                withAnimation(.easeOut(duration: 0.2)) {
                                    selectionOffset = 0
                                }
                            }
                        Text(rt)
                            .onTapGesture {
                                selection = 1
                                withAnimation(.easeOut(duration: 0.2)) {
                                    selectionOffset = 72
                                }
                            }
                    } else if let ldlt = localizedLeftText, let ldrt = localizedRightText {
                        Text(ldlt)
                            .onTapGesture {
                                selection = 0
                                withAnimation(.easeOut(duration: 0.2)) {
                                    selectionOffset = 0
                                }
                            }
                        Text(ldrt)
                            .onTapGesture {
                                selection = 1
                                withAnimation(.easeOut(duration: 0.2)) {
                                    selectionOffset = 72
                                }
                            }
                    }
                }
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .fontWeight(.semibold)
                .frame(width: 75, height: 32)
            }
        }
        .onAppear {
            selectionOffset = selection == 0 ? 0 : 72
        }
    }
}
#endif

@ViewBuilder
func LargeVideoCard(_ videoDetails: [String: String]) -> some View {
    #if os(watchOS)
    NavigationLink(destination: { VideoDetailView(videoDetails: videoDetails) }, label: {
        VStack {
            WebImage(url: URL(string: videoDetails["Pic"]! + "@400w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                .placeholder {
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: WKInterfaceDevice.current().screenBounds.width - 20, height: 80)
                        .foregroundColor(Color(hex: 0x3D3D3D))
                        .redacted(reason: .placeholder)
                }
                .resizable()
                .cornerRadius(7)
                .scaledToFit()
                .frame(width: WKInterfaceDevice.current().screenBounds.width - 20)
            HStack {
                Text(videoDetails["Title"]!)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(2)
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
    #else
    VideoCard(videoDetails)
    #endif
}

func tipWithText(_ text: String, symbol: String = "", time: Double = 3.0) {
    #if os(watchOS)
    NKTipper.scaleStyle.present(text: text, symbol: symbol, duration: time)
    #else
    NKTipper.tinyStyle.present(text: text, symbol: symbol, duration: time)
    #endif
}

// swiftlint:disable unused_closure_parameter
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
// swiftlint:enable unused_closure_parameter

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

@ViewBuilder
func Label(_ titleKey: LocalizedStringKey, privateSystemImage systemName: String) -> some View {
    Label(title: {
        Text(titleKey)
    }, icon: {
        Image(_internalSystemName: systemName)
    })
}

#if os(watchOS)
struct BlurBackground: ViewModifier {
    var imageUrl: URL?
    @State private var backgroundPicOpacity: CGFloat = 0.0
    func body(content: Content) -> some View {
        if #available(watchOS 10, *) {
            content
                .containerBackground(for: .navigation) {
                    if let imageUrl {
                        ZStack {
                            WebImage(url: imageUrl)
                                .onSuccess { _, _, _ in
                                    backgroundPicOpacity = 1.0
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(width: WKInterfaceDevice.current().screenBounds.width, height: WKInterfaceDevice.current().screenBounds.height)
                                .blur(radius: 20)
                                .opacity(backgroundPicOpacity)
                                .animation(.easeOut(duration: 1.2), value: backgroundPicOpacity)
                            Color.black
                                .opacity(0.4)
                        }
                    }
                }
        } else {
            content
        }
    }
}

// Ext Keyboard
struct TextField: View {
    var titleKey: LocalizedStringResource?
    var titleKeyString: String?
    var text: Binding<String>
    var _onSubmit: () -> Void
    @AppStorage("IsUseExtKeyboard") private var _isUseExtKeyboard = false
    
    init(_ titleKey: LocalizedStringResource, text: Binding<String>, onSubmit: @escaping () -> Void = {}) {
        self.titleKey = titleKey
        self.text = text
        self._onSubmit = onSubmit
    }
    @_disfavoredOverload
    init(_ titleKey: String, text: Binding<String>, onSubmit: @escaping () -> Void = {}) {
        self.titleKeyString = titleKey
        self.text = text
        self._onSubmit = onSubmit
    }
    
    var body: some View {
        if _isUseExtKeyboard {
            if let titleKey {
                CepheusKeyboard(input: text, prompt: titleKey, defaultLanguage: "zh-hans-pinyin", onSubmit: { _onSubmit() })
            } else if let titleKeyString {
                CepheusKeyboard(input: text, prompt: LocalizedStringResource(stringLiteral: titleKeyString), defaultLanguage: "zh-hans-pinyin", onSubmit: { _onSubmit() })
            }
        } else {
            if let titleKey {
                SwiftUI.TextField(String(localized: titleKey), text: text)
                    .onSubmit(_onSubmit)
            } else if let titleKeyString {
                SwiftUI.TextField(titleKeyString, text: text)
                    .onSubmit(_onSubmit)
            }
        }
    }
}
#endif
