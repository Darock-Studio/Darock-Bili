//
//
//  LiveDetailView.swift
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
import DarockKit
import Alamofire
import SwiftyJSON
import MarqueeText
import SDWebImageSwiftUI

struct LiveDetailView: View {
    var liveDetails: [String: String]
    public static var willPlayStreamUrl = ""
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var watchingCount = 0
    @State var description = ""
    @State var liveStatus = LiveRoomStatus.notStart
    @State var startTime = ""
    @State var streamerId: Int64 = 0
    @State var streamerName = ""
    @State var streamerFaceUrl = ""
    @State var streamerFansCount = 0
    @State var tagName = ""
    @State var backgroundPicOpacity = 0.0
    #if !os(watchOS)
    @State var isDecoded = false
    #else
    @State var isLoading = false
    @State var isLivePlayerPresented = false
    #endif
    var body: some View {
        Group {
            #if !os(watchOS)
            VStack {
                if isDecoded {
                    LivePlayerView()
                        .frame(height: 240)
                } else {
                    Rectangle()
                        .frame(height: 240)
                        .redacted(reason: .placeholder)
                }
                ScrollView {
                    VStack {
                        Spacer()
                        MarqueeText(text: liveDetails["Title"]!, font: .systemFont(ofSize: 18, weight: .bold), leftFade: 5, rightFade: 5, startDelay: 1.5)
                            .padding(.horizontal, 10)
                        Spacer()
                            .frame(height: 20)
                        if streamerId != 0 {
                            NavigationLink(destination: { UserDetailView(uid: String(streamerId)) }, label: {
                                HStack {
                                    AsyncImage(url: URL(string: streamerFaceUrl + "@40w"))
                                        .cornerRadius(100)
                                        .frame(width: 40, height: 40)
                                    VStack {
                                        HStack {
                                            Text(streamerName)
                                                .font(.system(size: 16, weight: .bold))
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.1)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Video.fans.\(String(streamerFansCount).shorter())")
                                                .font(.system(size: 11))
                                                .lineLimit(1)
                                                .opacity(0.6)
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 18))
                        }
                        LazyVStack {
                            Spacer()
                                .frame(height: 10)
                            VStack {
                                HStack {
                                    Image(systemName: "person.2")
                                    Text("Video.details.watching-people.\(watchingCount)")
                                        .offset(x: -1)
                                    Spacer()
                                }
                                HStack {
                                    Image(systemName: "clock")
                                    Text("Live.starting.\(startTime)")
                                    Spacer()
                                }
                                HStack {
                                    Image(systemName: "movieclapper")
                                    Text(liveDetails["ID"]!)
                                    Spacer()
                                }
                            }
                            .font(.system(size: 11))
                            .opacity(0.6)
                            .padding(.horizontal, 10)
                            Spacer()
                                .frame(height: 5)
                            HStack {
                                VStack {
                                    Image(systemName: "info.circle")
                                    Spacer()
                                }
                                Text(description)
                                Spacer()
                            }
                            .font(.system(size: 12))
                            .opacity(0.65)
                            .padding(.horizontal, 8)
                            HStack {
                                VStack {
                                    Image(systemName: "tag")
                                    Spacer()
                                }
                                Text(tagName)
                                Spacer()
                            }
                            .font(.system(size: 12))
                            .opacity(0.65)
                            .padding(.horizontal, 8)
                        }
                    }
                }
            }
            #else
            ZStack {
                TabView {
                    FirstPageBase(liveDetails: liveDetails, streamerName: $streamerName, isLoading: $isLoading, isLivePlayerPresented: $isLivePlayerPresented)
                        .tag(1)
                        .offset(y: 16)
                        .toolbar {
                            ToolbarItemGroup(placement: .bottomBar) {
                                Spacer()
                                Button(action: {
                                    isLoading = true
                                    
                                    DarockKit.Network.shared.requestJSON("https://api.live.bilibili.com/room/v1/Room/playUrl?cid=\(liveDetails["ID"]!)&qn=150&platform=h5") { respJson, isSuccess in
                                        if isSuccess {
                                            debugPrint(respJson)
                                            LiveDetailView.willPlayStreamUrl = respJson["data"]["durl"][0]["url"].string ?? ""
                                            debugPrint(LiveDetailView.willPlayStreamUrl)
                                            isLivePlayerPresented = true
                                            isLoading = false
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "play.fill")
                                })
                            }
                        }
                    SecondPageBase(liveDetails: liveDetails, watchingCount: $watchingCount, description: $description, liveStatus: $liveStatus, startTime: $startTime, streamerId: $streamerId, streamerName: $streamerName, streamerFaceUrl: $streamerFaceUrl, streamerFansCount: $streamerFansCount, tagName: $tagName)
                        .tag(2)
                }
                .tabViewStyle(.verticalPage)
                .containerBackground(for: .navigation) {
                    if !isInLowBatteryMode {
                        ZStack {
                            WebImage(url: URL(string: liveDetails["Cover"]!))
                                .resizable()
                                .onSuccess { _, _, _ in
                                    backgroundPicOpacity = 1.0
                                }
                                .scaledToFill()
                                .blur(radius: 20)
                                .opacity(backgroundPicOpacity)
                                .animation(.easeOut(duration: 1.2), value: backgroundPicOpacity)
                            Color.black
                                .opacity(0.4)
                        }
                    }
                }
                .blur(radius: isLoading ? 14 : 0)
                if isLoading {
                    Text("Video.analyzing")
                        .font(.title2)
                        .bold()
                }
            }
            .sheet(isPresented: $isLivePlayerPresented, content: { LivePlayerView() })
            #endif
        }
        .navigationTitle("Live")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.live.bilibili.com/room/v1/Room/get_info?room_id=\(liveDetails["ID"]!)") { respJson, isSuccess in
                if isSuccess {
                    watchingCount = respJson["data"]["online"].int ?? 0
                    description = respJson["data"]["description"].string ?? "[加载失败]"
                    liveStatus = LiveRoomStatus(rawValue: respJson["data"]["live_status"].int ?? 0) ?? .notStart
                    startTime = respJson["data"]["live_time"].string ?? "0000-00-00 00:00:00"
                    tagName = respJson["data"]["tags"].string ?? "[加载失败]"
                    if let upUid = respJson["data"]["uid"].int64 {
                        streamerId = upUid
                        biliWbiSign(paramEncoded: "mid=\(upUid)".base64Encoded()) { signed in
                            if let signed {
                                debugPrint(signed)
                                autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                                    if isSuccess {
                                        if !CheckBApiError(from: respJson) { return }
                                        streamerFaceUrl = respJson["data"]["face"].string ?? "E"
                                        streamerName = respJson["data"]["name"].string ?? "[加载失败]"
                                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/stat?vmid=\(upUid)", headers: headers) { respJson, isSuccess in
                                            if isSuccess {
                                                streamerFansCount = respJson["data"]["follower"].int ?? -1
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            #if !os(watchOS)
            DarockKit.Network.shared.requestJSON("https://api.live.bilibili.com/room/v1/Room/playUrl?cid=\(liveDetails["ID"]!)&qn=150&platform=h5") { respJson, isSuccess in
                if isSuccess {
                    debugPrint(respJson)
                    LiveDetailView.willPlayStreamUrl = respJson["data"]["durl"][0]["url"].string ?? ""
                    debugPrint(LiveDetailView.willPlayStreamUrl)
                    isDecoded = true
                }
            }
            #endif
        }
    }
    
    #if os(watchOS)
    struct FirstPageBase: View {
        var liveDetails: [String: String]
        @Binding var streamerName: String
        @Binding var isLoading: Bool
        @Binding var isLivePlayerPresented: Bool
        @State var isCoverImageViewPresented = false
        var body: some View {
            VStack {
                Spacer()
                WebImage(url: URL(string: liveDetails["Cover"]! + "@240w_160h")!, options: [.progressiveLoad, .scaleDownLargeImages])
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
                    .sheet(isPresented: $isCoverImageViewPresented, content: { ImageViewerView(url: liveDetails["Cover"]!) })
                    .onTapGesture {
                        isCoverImageViewPresented = true
                    }
                Spacer()
                    .frame(height: 20)
                MarqueeText(text: liveDetails["Title"]!, font: .systemFont(ofSize: 12, weight: .bold), leftFade: 5, rightFade: 5, startDelay: 1.5)
                    .padding(.horizontal, 10)
                Text(streamerName)
                    .lineLimit(1)
                    .font(.system(size: 12))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 0)
                    .opacity(0.65)
                Spacer()
                    .frame(height: 20)
                if #unavailable(watchOS 10) {
                    Button(action: {
                        isLoading = true
                        
                        DarockKit.Network.shared.requestJSON("https://api.live.bilibili.com/room/v1/Room/playUrl?cid=\(liveDetails["ID"]!)&qn=150&platform=h5") { respJson, isSuccess in
                            if isSuccess {
                                debugPrint(respJson)
                                LiveDetailView.willPlayStreamUrl = respJson["data"]["durl"][0]["url"].string ?? ""
                                debugPrint(LiveDetailView.willPlayStreamUrl)
                                isLivePlayerPresented = true
                                isLoading = false
                            }
                        }
                    }, label: {
                        Label("Video.play", systemImage: "play.fill")
                    })
                }
            }
        }
    }
    
    struct SecondPageBase: View {
        var liveDetails: [String: String]
        @Binding var watchingCount: Int
        @Binding var description: String
        @Binding var liveStatus: LiveRoomStatus
        @Binding var startTime: String
        @Binding var streamerId: Int64
        @Binding var streamerName: String
        @Binding var streamerFaceUrl: String
        @Binding var streamerFansCount: Int
        @Binding var tagName: String
        @State var ownerBlockOffset: CGFloat = 20
        @State var nowWatchingCountOffset: CGFloat = 20
        @State var publishTimeTextOffset: CGFloat = 20
        @State var liveIdTextOffset: CGFloat = 20
        @State var descOffset: CGFloat = 20
        var body: some View {
            ScrollView {
                VStack {
                    if streamerId != 0 {
                        NavigationLink(destination: { UserDetailView(uid: String(streamerId)) }, label: {
                            HStack {
                                AsyncImage(url: URL(string: streamerFaceUrl + "@40w"))
                                    .cornerRadius(100)
                                    .frame(width: 40, height: 40)
                                VStack {
                                    HStack {
                                        Text(streamerName)
                                            .font(.system(size: 16, weight: .bold))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Video.fans.\(Int(String(streamerFansCount).shorter()) ?? 0)")
                                            .font(.system(size: 11))
                                            .lineLimit(1)
                                            .opacity(0.6)
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        })
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        .offset(y: ownerBlockOffset)
                        .animation(.easeOut(duration: 0.3), value: ownerBlockOffset)
                        .onAppear {
                            ownerBlockOffset = 0
                        }
                    }
                    LazyVStack {
                        Spacer()
                            .frame(height: 10)
                        VStack {
                            HStack {
                                Image(systemName: "person.2")
                                Text("Video.details.watching-people.\(watchingCount)")
                                    .offset(x: -1)
                                Spacer()
                            }
                            .offset(x: -2, y: nowWatchingCountOffset)
                            .animation(.easeOut(duration: 0.55), value: nowWatchingCountOffset)
                            .onAppear {
                                nowWatchingCountOffset = 0
                            }
                            HStack {
                                Image(systemName: "clock")
                                Text("Live.starting.\(startTime)")
                                Spacer()
                            }
                            .offset(y: publishTimeTextOffset)
                            .animation(.easeOut(duration: 0.65), value: publishTimeTextOffset)
                            .onAppear {
                                publishTimeTextOffset = 0
                            }
                            HStack {
                                Image(systemName: "movieclapper")
                                Text(liveDetails["ID"]!)
                                Spacer()
                            }
                            .offset(x: -1, y: liveIdTextOffset)
                            .animation(.easeOut(duration: 0.75), value: liveIdTextOffset)
                            .onAppear {
                                liveIdTextOffset = 0
                            }
                        }
                        .font(.system(size: 11))
                        .opacity(0.6)
                        .padding(.horizontal, 10)
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            VStack {
                                Image(systemName: "info.circle")
                                Spacer()
                            }
                            Text(description)
                            Spacer()
                        }
                        .font(.system(size: 12))
                        .opacity(0.65)
                        .padding(.horizontal, 8)
                        .offset(y: descOffset)
                        .animation(.easeOut(duration: 0.4), value: descOffset)
                        .onAppear {
                            descOffset = 0
                        }
                        HStack {
                            VStack {
                                Image(systemName: "tag")
                                Spacer()
                            }
                            Text(tagName)
                            Spacer()
                        }
                        .font(.system(size: 12))
                        .opacity(0.65)
                        .padding(.horizontal, 8)
                        .offset(y: descOffset)
                        .animation(.easeOut(duration: 0.4), value: descOffset)
                    }
                }
            }
        }
    }
    #endif
}

enum LiveRoomStatus: Int {
    case notStart = 0
    case streaming = 1
    case playbacking = 2
}

//#Preview {
//    LiveDetailView()
//}
