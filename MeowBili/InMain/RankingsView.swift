//
//
//  RankingsView.swift
//  DarockBili
//
//  Created by memz233 on 2025/1/1.
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
import Alamofire
import DarockFoundation

struct RankingsView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: { RankingCategoryListView(rid: 0) }, label: {
                    Label(title: {
                        Text("全站")
                    }, icon: {
                        Image(systemName: "sparkles.tv.fill")
                            .foregroundStyle(.accent)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 1) }, label: {
                    Label(title: {
                        Text("动画")
                    }, icon: {
                        Image(systemName: "play.square.fill")
                            .foregroundStyle(.purple)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 3) }, label: {
                    Label(title: {
                        Text("音乐")
                    }, icon: {
                        Image(systemName: "headphones")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 129) }, label: {
                    Label(title: {
                        Text("舞蹈")
                    }, icon: {
                        Image(systemName: "figure.barre")
                            .foregroundStyle(.red)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 4) }, label: {
                    Label(title: {
                        Text("游戏")
                    }, icon: {
                        Image(systemName: "gamecontroller.fill")
                            .foregroundStyle(.green)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 36) }, label: {
                    Label(title: {
                        Text("知识")
                    }, icon: {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 188) }, label: {
                    Label(title: {
                        Text("科技")
                    }, icon: {
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 234) }, label: {
                    Label(title: {
                        Text("运动")
                    }, icon: {
                        Image(systemName: "figure.run")
                            .foregroundStyle(.green)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 223) }, label: {
                    Label(title: {
                        Text("汽车")
                    }, icon: {
                        Image(systemName: "car.fill")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 160) }, label: {
                    Label(title: {
                        Text("生活")
                    }, icon: {
                        Image(systemName: "fish.fill")
                            .foregroundStyle(.yellow)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 211) }, label: {
                    Label(title: {
                        Text("美食")
                    }, icon: {
                        Image(systemName: "carrot.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 217) }, label: {
                    Label(title: {
                        Text("动物圈")
                    }, icon: {
                        Image(systemName: "pawprint.fill")
                            .foregroundStyle(.pink)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 119) }, label: {
                    Label(title: {
                        Text("鬼畜")
                    }, icon: {
                        Image(systemName: "figure.roll")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 155) }, label: {
                    Label(title: {
                        Text("时尚")
                    }, icon: {
                        Image(systemName: "figure.wave")
                            .foregroundStyle(.pink)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 5) }, label: {
                    Label(title: {
                        Text("娱乐")
                    }, icon: {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 181) }, label: {
                    Label(title: {
                        Text("影视")
                    }, icon: {
                        Image(systemName: "movieclapper.fill")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 177) }, label: {
                    Label(title: {
                        Text("纪录片")
                    }, icon: {
                        Image(systemName: "camera.shutter.button.fill")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 23) }, label: {
                    Label(title: {
                        Text("电影")
                    }, icon: {
                        Image(systemName: "sunglasses.fill")
                            .foregroundStyle(.green)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(rid: 11) }, label: {
                    Label(title: {
                        Text("电视剧")
                    }, icon: {
                        Image(systemName: "chair.lounge.fill")
                            .foregroundStyle(.orange)
                    })
                })
            } header: {
                Text("分区")
            }
        }
        .navigationTitle("排行榜")
        .navigationBarTitleDisplayMode(.large)
    }
}

private struct RankingCategoryListView: View {
    var rid: Int
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var videos = [[String: String]]()
    var body: some View {
        List {
            if !videos.isEmpty {
                Section {
                    ForEach(0..<videos.count, id: \.self) { i in
                        VideoCard(videos[i])
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "accept": "*/*",
                "accept-encoding": "gzip, deflate, br",
                "accept-language": "zh-CN,zh;q=0.9",
                "cookie": "SESSDATA=\(sessdata); buvid_fp=e651c1a382430ea93631e09474e0b395; buvid3=\(UuidInfoc.gen()); buvid4=buvid4-failed-1",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
                "Referer": "https://www.bilibili.com/v/popular/rank"
            ]
            biliWbiSign(paramEncoded: "rid=\(rid)&type=all".base64Encoded()) { signed in
                if let signed {
                    requestJSON("https://api.bilibili.com/x/web-interface/ranking/v2?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            if !CheckBApiError(from: respJson) { return }
                            let data = respJson["data"]["list"]
                            for videoInfo in data {
                                videos.append(["Pic": videoInfo.1["pic"].string ?? "E", "Title": videoInfo.1["title"].string ?? "[加载失败]", "BV": videoInfo.1["bvid"].string ?? "E", "UP": videoInfo.1["owner"]["name"].string ?? "[加载失败]", "View": String(videoInfo.1["stat"]["view"].int ?? -1), "Danmaku": String(videoInfo.1["stat"]["danmaku"].int ?? -1)])
                            }
                        }
                    }
                }
            }
        }
    }
}
