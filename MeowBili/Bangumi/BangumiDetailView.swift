//
//
//  BangumiDetailView.swift
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
import Alamofire
import SwiftyJSON
import MarqueeText
import DarockFoundation
import SDWebImageSwiftUI

struct BangumiDetailView: View {
    @State var bangumiData: BangumiData
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("IsDanmakuEnabled") var isDanmakuEnabled = true
    @State var paymentData: BangumiPayment?
    @State var epDatas = [BangumiEp]()
    @State var isLoading = false
    @State var mainTabSelection = 1
    @State var isBangumiPlayerPresented = false
    @State var isMoreMenuPresented = false
    @State var backgroundPicOpacity = 0.0
    @State var navigationSelectedEpdata: BangumiEp?
    @State var bangumiLink = ""
    @State var isDecoded = false
    @State var isShouldPause = false
    @State var currentPlayTime = 0.0
    var body: some View {
        TabView {
            ZStack {
                Group {
                    #if os(watchOS)
                    ScrollView {
                        DetailViewFirstPageBase(bangumiData: $bangumiData, isBangumiPlayerPresented: $isBangumiPlayerPresented, isLoading: $isLoading)
                        DetailViewSecondPageBase(bangumiData: $bangumiData, paymentData: $paymentData)
                        EpisodeListView(bangumiData: $bangumiData, epDatas: $epDatas, isBangumiPlayerPresented: $isBangumiPlayerPresented, isLoading: $isLoading, bangumiLink: $bangumiLink)
                    }
                    #else
                    VStack {
                        if isDecoded {
                            BangumiPlayerView(bangumiData: $bangumiData, isDanmakuEnabled: $isDanmakuEnabled, bangumiLink: $bangumiLink, shouldPause: $isShouldPause, currentPlayTime: $currentPlayTime)
                                .frame(height: 240)
                        } else {
                            Rectangle()
                                .frame(height: 240)
                                .redacted(reason: .placeholder)
                                .accessibilityIdentifier("BangumiNotLoadPlaceholder")
                        }
                        ScrollView {
                            EpisodeListView(bangumiData: $bangumiData, epDatas: $epDatas, isBangumiPlayerPresented: $isBangumiPlayerPresented, isLoading: $isLoading, bangumiLink: $bangumiLink)
                            DetailViewSecondPageBase(bangumiData: $bangumiData, paymentData: $paymentData)
                        }
                    }
                    #endif
                }
                .blur(radius: isLoading ? 14 : 0)
                if isLoading {
                    Text("Video.analyzing")
                        .font(.title2)
                        .bold()
                }
            }
            .tag(1)
            
            Group {
                if epDatas.count != 0 {
                    List {
                        Text("Bangumi.comments.select")
                            .listRowBackground(Color.clear)
                        ForEach(0..<epDatas.count, id: \.self) { i in
                            if let aid = epDatas[i].aid {
                                NavigationLink(destination: { CommentsView(oid: av2bv(avid: UInt64(aid))) }, label: {
                                    Text(epDatas[i].longTitle)
                                })
                            }
                        }
                    }
                }
            }
            .tag(2)
            .navigationTitle("Bangumi.commnets")
        }
        .navigationTitle("Bangumi")
        .navigationBarTitleDisplayMode(.inline)
        #if os(watchOS)
        .sheet(isPresented: $isBangumiPlayerPresented, content: { BangumiPlayerView(bangumiData: $bangumiData, bangumiLink: $bangumiLink) })
        #endif
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            requestJSON("https://api.bilibili.com/pgc/view/web/season?season_id=\(bangumiData.seasonId)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if !CheckBApiError(from: respJson) { return }
                    debugPrint(respJson)
                    bangumiData = .init(mediaId: respJson["result"]["media_id"].int64 ?? 0, seasonId: respJson["result"]["season_id"].int64 ?? 0, title: respJson["result"]["title"].string ?? "[加载失败]", originalTitle: respJson["result"]["subtitle"].string ?? "[加载失败]", cover: respJson["result"]["cover"].string ?? "E", description: respJson["result"]["evaluate"].string ?? "[加载失败]", score: BangumiData.Score(userCount: respJson["result"]["rating"]["count"].int ?? 0, score: respJson["result"]["rating"]["score"].float ?? 0.0), isFollow: false)
                    if let discount = respJson["result"]["payment"]["vip_discount"].int {
                        paymentData = .init(discount: discount, tip: respJson["result"]["payment"]["tip"].string ?? "[加载失败]", promotion: respJson["result"]["payment"]["vip_promotion"].string ?? "[加载失败]")
                    }
                }
            }
            requestJSON("https://api.bilibili.com/pgc/web/season/section?season_id=\(bangumiData.seasonId)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    epDatas.removeAll()
                    for ep in respJson["result"]["main_section"]["episodes"] {
                        epDatas.append(BangumiEp(aid: ep.1["aid"].int64 ?? 0, epid: ep.1["id"].int64 ?? 0, cid: ep.1["cid"].int64 ?? 0, cover: ep.1["cover"].string ?? "E", title: ep.1["title"].string ?? "[加载失败]", longTitle: ep.1["long_title"].string ?? "[加载失败]"))
                    }
                    #if !os(watchOS)
                    requestJSON("https://api.bilibili.com/pgc/player/web/playurl?ep_id=\(epDatas[0].epid)&qn=16&fnval=1", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            if !CheckBApiError(from: respJson) { return }
                            bangumiLink = respJson["result"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                            isDecoded = true
                        }
                    }
                    #endif
                }
            }
        }
    }
    
    struct DetailViewFirstPageBase: View {
        @Binding var bangumiData: BangumiData
        @Binding var isBangumiPlayerPresented: Bool
        @Binding var isLoading: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var isCoverImageViewPresented = false
        var body: some View {
            VStack {
                Spacer()
                WebImage(url: URL(string: bangumiData.cover + "@130w_180h")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 13)
                            .frame(width: 65, height: 90)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 90)
                    .cornerRadius(13)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 1, y: 2)
                    .offset(y: 8)
                    .sheet(isPresented: $isCoverImageViewPresented, content: { ImageViewerView(url: bangumiData.cover) })
                    .onTapGesture {
                        isCoverImageViewPresented = true
                    }
                Spacer()
                    .frame(height: 20)
                MarqueeText(text: bangumiData.title, font: .systemFont(ofSize: 12, weight: .bold), leftFade: 5, rightFade: 5, startDelay: 1.5)
                    .padding(.horizontal, 10)
                
                Text(bangumiData.style ?? "")
                    .lineLimit(1)
                    .font(.system(size: 12))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 0)
                    .opacity(0.65)
                Spacer()
                    .frame(height: 20)
            }
        }
    }
    struct DetailViewSecondPageBase: View {
        @Binding var bangumiData: BangumiData
        @Binding var paymentData: BangumiPayment?
        var body: some View {
            ScrollView {
                VStack {
                    if let score = bangumiData.score {
                        HStack {
                            Group {
                                Image(systemName: "star.fill")
                                Text("\(Int(score.score))\(Text(".\(Int((score.score - Float(Int(score.score))) * 10))").font(.system(size: 16)))")
                            }
                            .font(.system(size: 30))
                            .foregroundColor(.yellow)
                            Spacer()
                        }
                        HStack {
                            Text("Bangumi.score.joined-people.\(score.userCount)")
                                .font(.footnote)
                                .opacity(0.65)
                            Spacer()
                        }
                    }
                    if let payment = paymentData {
                        Spacer()
                            .frame(height: 20)
                        Text(payment.tip)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
    }
    struct EpisodeListView: View {
        @Binding var bangumiData: BangumiData
        @Binding var epDatas: [BangumiEp]
        @Binding var isBangumiPlayerPresented: Bool
        @Binding var isLoading: Bool
        @Binding var bangumiLink: String
        @Environment(\.colorScheme) var colorScheme
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var playingPageIndex = 0
        var body: some View {
            #if os(watchOS)
            if epDatas.count != 0 {
                ForEach(0..<epDatas.count, id: \.self) { i in
                    Button(action: {
                        isLoading = true
                        
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata)",
                            "Referer": "https://www.bilibili.com/bangumi/play/ep\(epDatas[i].epid)",
                            "Origin": "https://www.bilibili.com",
                            "Accept": "application/json, text/plain, */*",
                            "Accept-Language": "zh-CN,zh;q=0.9",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        requestJSON("https://api.bilibili.com/pgc/player/web/v2/playurl?ep_id=\(epDatas[i].epid)&qn=32&fnval=1&session=5a90f7022988409ff9fa72a3c25cd576", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                debugPrint(respJson)
                                if !CheckBApiError(from: respJson) {
                                    isLoading = false
                                    return
                                }
                                bangumiLink = respJson["result"]["video_info"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                isBangumiPlayerPresented = true
                                isLoading = false
                            }
                        }
                    }, label: {
                        Text(epDatas[i].longTitle)
                    })
                }
            }
            #else
            if epDatas.count != 0 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<epDatas.count, id: \.self) { i in
                            Button(action: {
                                playingPageIndex = i
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "Referer": "https://www.bilibili.com/bangumi/play/ep\(epDatas[i].epid)",
                                    "Origin": "https://www.bilibili.com",
                                    "Accept": "application/json, text/plain, */*",
                                    "Accept-Language": "zh-CN,zh;q=0.9",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                requestJSON("https://api.bilibili.com/pgc/player/web/v2/playurl?ep_id=\(epDatas[i].epid)&qn=64&fnval=1&session=5a90f7022988409ff9fa72a3c25cd576", headers: headers) { respJson, isSuccess in
                                    if isSuccess {
                                        if !CheckBApiError(from: respJson) { return }
                                        bangumiLink = respJson["result"]["video_info"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                    }
                                }
                            }, label: {
                                HStack {
                                    VStack {
                                        Text(String(i + 1))
                                            .foregroundColor(playingPageIndex == i ? .accentColor : (colorScheme == .dark ? .white : .black))
                                        Spacer()
                                    }
                                    Text(epDatas[i].longTitle)
                                        .lineLimit(2)
                                        .foregroundColor(playingPageIndex == i ? .accentColor : (colorScheme == .dark ? .white : .black))
                                }
                                .font(.system(size: 14))
                            })
                            .buttonStyle(.bordered)
                            .frame(height: 60)
                            .frame(maxWidth: 160)
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            #endif
        }
    }
}

#Preview {
    BangumiDetailView(bangumiData: BangumiData(mediaId: 28224080, seasonId: 29310, title: "异度侵入 ID:INVADED", originalTitle: "イド：インヴェイデッド", cover: "https://i0.hdslb.com/bfs/bangumi/image/9bf9e66968f85b33ec3769a16c86b36dc984abbc.png", area: "日本", style: "原创/科幻/推理", cvs: ["酒井户：津田健次郎", "百贵：细谷佳正", "富久田：竹内良太", "本堂町：M・A・O", "东乡：布里德卡特·塞拉·惠美", "早濑浦：村治学", "白岳：近藤隆", "羽二重：岩濑周平", "若鹿：榎木淳弥", "国府：加藤涉", "西村：落合福嗣", "松冈：西凛太朗"], staffs: ["监督：青木英", "脚本：舞城王太郎", "角色原案：小玉有起", "角色设计：碇谷敦", "美术：曽野由大", "作画监督：又贺大介", "副监督：久保田雄大", "色彩设计：千叶絵美", "动画制作：NAZ"], description: "本片讲述利用能检测出人们杀意的装置以及利用思想粒子做出的“井”，来探知事件真相的科幻故事。", pubtime: 1578240000))
}
