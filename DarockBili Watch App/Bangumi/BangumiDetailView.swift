//
//  BangumiDetailView.swift
//  DarockBili Watch App
//
//  Created by 雷美淳 on 2024/1/13.
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

import SwiftUI
import Marquee
import SFSymbol
import DarockKit
import Alamofire
import SwiftyJSON
import CachedAsyncImage
import SDWebImageSwiftUI

struct BangumiDetailView: View {
    public static var willPlayBangumiLink = ""
    public static var willPlayBangumiData: BangumiData?
    @State var bangumiData: BangumiData
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @State var epDatas = [BangumiEp]()
    @State var isLoading = false
    @State var mainTabSelection = 1
    @State var isBangumiPlayerPresented = false
    @State var isMoreMenuPresented = false
    @State var backgroundPicOpacity = 0.0
    var body: some View {
        TabView {
            ZStack {
                Group {
                    if #available(watchOS 10, *) {
                        TabView(selection: $mainTabSelection) {
                            DetailViewFirstPageBase(bangumiData: $bangumiData, isBangumiPlayerPresented: $isBangumiPlayerPresented, isLoading: $isLoading)
                                .offset(y: 16)
                                .tag(1)
                                .toolbar {
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button(action: {
                                            isMoreMenuPresented = true
                                        }, label: {
                                            Image(systemName: "ellipsis")
                                        })
                                        .sheet(isPresented: $isMoreMenuPresented, content: {
                                            List {
                                                //                                            Button(action: {
                                                //                                                isDownloadPresented = true
                                                //                                            }, label: {
                                                //                                                Label("下载视频", systemImage: "arrow.down.doc")
                                                //                                            })
                                                //                                            .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                                            }
                                        })
                                    }
                                    ToolbarItemGroup(placement: .bottomBar) {
                                        Spacer()
                                        Button(action: {
                                            mainTabSelection = 3
                                        }, label: {
                                            Image(systemName: "rectangle.stack")
                                        })
                                    }
                                }
                            EpisodeListView(bangumiData: $bangumiData, epDatas: $epDatas, isBangumiPlayerPresented: $isBangumiPlayerPresented, isLoading: $isLoading)
                                .tag(3)
                        }
                        .tabViewStyle(.verticalPage)
                        .sheet(isPresented: $isBangumiPlayerPresented, content: {BangumiPlayerView()})
                        .containerBackground(for: .navigation) {
                            if !isInLowBatteryMode {
                                ZStack {
                                    CachedAsyncImage(url: URL(string: bangumiData.cover)) { phase in
                                        switch phase {
                                        case .empty:
                                            Color.black
                                        case .success(let image):
                                            image
                                                .onAppear {
                                                    backgroundPicOpacity = 1.0
                                                }
                                        case .failure:
                                            Color.black
                                        @unknown default:
                                            Color.black
                                        }
                                    }
                                    .blur(radius: 20)
                                    .opacity(backgroundPicOpacity)
                                    .animation(.easeOut(duration: 1.2), value: backgroundPicOpacity)
                                    Color.black
                                        .opacity(0.4)
                                }
                            }
                        }
                    } else {
                        
                    }
                }
                .blur(radius: isLoading ? 14 : 0)
                if isLoading {
                    Text("正在解析...")
                        .font(.title2)
                        .bold()
                }
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/pgc/view/web/season?season_id=\(bangumiData.seasonId)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if !CheckBApiError(from: respJson) { return }
                    bangumiData = .init(mediaId: respJson["result"]["media_id"].int64 ?? 0, seasonId: respJson["result"]["season_id"].int64 ?? 0, title: respJson["result"]["title"].string ?? "[加载失败]", originalTitle: respJson["result"]["subtitle"].string ?? "[加载失败]", cover: respJson["result"]["cover"].string ?? "E", description: respJson["result"]["evaluate"].string ?? "[加载失败]", score: BangumiData.Score(userCount: respJson["result"]["rating"]["count"].int ?? 0, score: respJson["result"]["rating"]["count"].float ?? 0.0), isFollow: false)
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/pgc/web/season/section?season_id=\(bangumiData.seasonId)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    for ep in respJson["result"]["main_section"]["episodes"] {
                        epDatas.append(BangumiEp(aid: ep.1["aid"].int64 ?? 0, epid: ep.1["id"].int64 ?? 0, cid: ep.1["cid"].int64 ?? 0, cover: ep.1["cover"].string ?? "E", title: ep.1["title"].string ?? "[加载失败]", longTitle: ep.1["long_title"].string ?? "[加载失败]"))
                    }
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
                WebImage(url: URL(string: bangumiData.cover + "@240w_160h")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(width: 120, height: 80)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 80)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 1, y: 2)
                    .offset(y: 8)
                    .sheet(isPresented: $isCoverImageViewPresented, content: {ImageViewerView(url: bangumiData.cover)})
                    .onTapGesture {
                        isCoverImageViewPresented = true
                    }
                Spacer()
                    .frame(height: 20)
                Marquee {
                    Text(bangumiData.title)
                        .lineLimit(1)
                        .font(.system(size: 12, weight: .bold))
                        .multilineTextAlignment(.center)
                }
                .marqueeWhenNotFit(true)
                .marqueeDuration(10)
                .frame(height: 20)
                .padding(.horizontal, 10)
                
                Text(bangumiData.style ?? "")
                    .lineLimit(1)
                    .font(.system(size: 12))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 0)
                    .opacity(0.65)
                Spacer()
                    .frame(height: 20)
                if #unavailable(watchOS 10) {
                    Button(action: {
                        
                    }, label: {
                        Label("播放", systemImage: "play.fill")
                    })
//                    Button(action: {
//                        isMoreMenuPresented = true
//                    }, label: {
//                        Label("更多", systemImage: "ellipsis")
//                    })
//                    .sheet(isPresented: $isMoreMenuPresented, content: {
//                        List {
//                            Button(action: {
//                                isDownloadPresented = true
//                            }, label: {
//                                Label("下载视频", image: "arrow.down.doc")
//                            })
//                            .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
//                            Button(action: {
//                                let headers: HTTPHeaders = [
//                                    "cookie": "SESSDATA=\(sessdata)",
//                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
//                                ]
//                                AF.request("https://api.bilibili.com/x/v2/history/toview/add", method: .post, parameters: ["bvid": videoDetails["BV"]!, "csrf": biliJct], headers: headers).response { response in
//                                    do {
//                                        let json = try JSON(data: response.data ?? Data())
//                                        if let code = json["code"].int {
//                                            if code == 0 {
//                                                tipWithText("添加成功", symbol: SFSymbol.Checkmark.circleFill.rawValue)
//                                            } else {
//                                                tipWithText(json["message"].string ?? "未知错误", symbol: SFSymbol.Xmark.circleFill.rawValue)
//                                            }
//                                        } else {
//                                            tipWithText("未知错误", symbol: SFSymbol.Xmark.circleFill.rawValue)
//                                        }
//                                    } catch {
//                                        tipWithText("未知错误", symbol: SFSymbol.Xmark.circleFill.rawValue)
//                                    }
//                                }
//                            }, label: {
//                                Label("添加到稍后再看", systemImage: "memories.badge.plus")
//                            })
//                        }
//                    })
                }
            }
        }
    }
    struct EpisodeListView: View {
        @Binding var bangumiData: BangumiData
        @Binding var epDatas: [BangumiEp]
        @Binding var isBangumiPlayerPresented: Bool
        @Binding var isLoading: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        var body: some View {
            List {
                if epDatas.count != 0 {
                    ForEach(0..<epDatas.count, id: \.self) { i in
                        Button(action: {
                            isLoading = true
                            
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)",
                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                            ]
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/pgc/player/web/playurl?ep_id=\(epDatas[i].epid)&qn=\(sessdata == "" ? 64 : 80)", headers: headers) { respJson, isSuccess in
                                if !CheckBApiError(from: respJson) { return }
                                BangumiDetailView.willPlayBangumiLink = respJson["result"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                BangumiDetailView.willPlayBangumiData = bangumiData
                                isBangumiPlayerPresented = true
                                isLoading = false
                            }
                        }, label: {
                            Text(epDatas[i].longTitle)
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    BangumiDetailView(bangumiData: BangumiData(mediaId: 28224080, seasonId: 29310, title: "异度侵入 ID:INVADED", originalTitle: "イド：インヴェイデッド", cover: "https://i0.hdslb.com/bfs/bangumi/image/9bf9e66968f85b33ec3769a16c86b36dc984abbc.png", area: "日本", style: "原创/科幻/推理", cvs: ["酒井户：津田健次郎", "百贵：细谷佳正", "富久田：竹内良太", "本堂町：M・A・O", "东乡：布里德卡特·塞拉·惠美", "早濑浦：村治学", "白岳：近藤隆", "羽二重：岩濑周平", "若鹿：榎木淳弥", "国府：加藤涉", "西村：落合福嗣", "松冈：西凛太朗"], staffs: ["监督：青木英", "脚本：舞城王太郎", "角色原案：小玉有起", "角色设计：碇谷敦", "美术：曽野由大", "作画监督：又贺大介", "副监督：久保田雄大", "色彩设计：千叶絵美", "动画制作：NAZ"], description: "本片讲述利用能检测出人们杀意的装置以及利用思想粒子做出的“井”，来探知事件真相的科幻故事。", pubtime: 1578240000))
}
