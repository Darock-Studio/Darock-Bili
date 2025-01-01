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
import DarockKit
import Alamofire

struct RankingsView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: { RankingCategoryListView(tid: 1) }, label: {
                    Label(title: {
                        Text("动画")
                    }, icon: {
                        Image(systemName: "play.square.fill")
                            .foregroundStyle(.purple)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 13) }, label: {
                    Label(title: {
                        Text("番剧")
                    }, icon: {
                        Image(systemName: "tv.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 167) }, label: {
                    Label(title: {
                        Text("国创")
                    }, icon: {
                        Image(systemName: "flag.fill")
                            .foregroundStyle(.red)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 3) }, label: {
                    Label(title: {
                        Text("音乐")
                    }, icon: {
                        Image(systemName: "headphones")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 129) }, label: {
                    Label(title: {
                        Text("舞蹈")
                    }, icon: {
                        Image(systemName: "figure.barre")
                            .foregroundStyle(.red)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 4) }, label: {
                    Label(title: {
                        Text("游戏")
                    }, icon: {
                        Image(systemName: "gamecontroller.fill")
                            .foregroundStyle(.green)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 36) }, label: {
                    Label(title: {
                        Text("知识")
                    }, icon: {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 188) }, label: {
                    Label(title: {
                        Text("科技")
                    }, icon: {
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 234) }, label: {
                    Label(title: {
                        Text("运动")
                    }, icon: {
                        Image(systemName: "figure.run")
                            .foregroundStyle(.green)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 223) }, label: {
                    Label(title: {
                        Text("汽车")
                    }, icon: {
                        Image(systemName: "car.fill")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 160) }, label: {
                    Label(title: {
                        Text("生活")
                    }, icon: {
                        Image(systemName: "fish.fill")
                            .foregroundStyle(.yellow)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 211) }, label: {
                    Label(title: {
                        Text("美食")
                    }, icon: {
                        Image(systemName: "carrot.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 217) }, label: {
                    Label(title: {
                        Text("动物圈")
                    }, icon: {
                        Image(systemName: "pawprint.fill")
                            .foregroundStyle(.pink)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 119) }, label: {
                    Label(title: {
                        Text("鬼畜")
                    }, icon: {
                        Image(systemName: "figure.roll")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 155) }, label: {
                    Label(title: {
                        Text("时尚")
                    }, icon: {
                        Image(systemName: "figure.wave")
                            .foregroundStyle(.pink)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 5) }, label: {
                    Label(title: {
                        Text("娱乐")
                    }, icon: {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(.orange)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 181) }, label: {
                    Label(title: {
                        Text("影视")
                    }, icon: {
                        Image(systemName: "movieclapper.fill")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 177) }, label: {
                    Label(title: {
                        Text("纪录片")
                    }, icon: {
                        Image(systemName: "camera.shutter.button.fill")
                            .foregroundStyle(.blue)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 23) }, label: {
                    Label(title: {
                        Text("电影")
                    }, icon: {
                        Image(systemName: "sunglasses.fill")
                            .foregroundStyle(.green)
                    })
                })
                NavigationLink(destination: { RankingCategoryListView(tid: 11) }, label: {
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
    var tid: Int
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
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/ranking/v2?tid=\(tid)&type=all", headers: headers) { respJson, isSuccess in
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
