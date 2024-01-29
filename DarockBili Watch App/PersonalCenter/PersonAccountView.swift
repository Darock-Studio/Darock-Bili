//
//  PersonAccountView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
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

import AVKit
import SwiftUI
import Combine
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation
import CachedAsyncImage
import SDWebImageSwiftUI

struct PersonAccountView: View {
    var isSettingsButtonTrailing = false
    @AppStorage("UsingSkin") var usingSkin = ""
    @AppStorage("IsSkinNoBlur") var isSkinNoBlur = false
    var body: some View {
        NavigationStack {
            if #available(watchOS 10, *) {
                MainView()
                    .toolbar {
                        if isSettingsButtonTrailing {
                            ToolbarItem(placement: .topBarTrailing) {
                                NavigationLink(destination: {SettingsView()}, label: {
                                    Image(systemName: "gear")
                                        .foregroundColor(.accentColor)
                                })
                                .accessibility(identifier: "AppSettingsButton")
                            }
                        } else {
                            ToolbarItem(placement: .topBarLeading) {
                                NavigationLink(destination: {SettingsView()}, label: {
                                    Image(systemName: "gear")
                                        .foregroundColor(.accentColor)
                                })
                                .accessibility(identifier: "AppSettingsButton")
                            }
                        }
//                        ToolbarItem(placement: .topBarTrailing) {
//                            NavigationLink(destination: {SkinExplorerView()}, label: {
//                                Image(systemName: "paintbrush")
//                                    .foregroundColor(.accentColor)
//                            })
//                        }
                    }
//                    .containerBackground(for: .navigation) {
//                        if usingSkin != "" {
//                            let playerItem = AVPlayerItem(url: AppFileManager(path: "skin/\(usingSkin)").GetFilePath(name: "head_myself_mp4_bg.mp4"))
//                            let player = AVPlayer(playerItem: playerItem)
//                            var finishObserver: AnyCancellable?
//                            ZStack {
//                                VideoPlayer(player: player)
//                                    .ignoresSafeArea()
//                                    .scaleEffect(1.5)
//                                    .onAppear {
//                                        finishObserver = NotificationCenter.default
//                                            .publisher(for: .AVPlayerItemDidPlayToEndTime, object: playerItem)
//                                            .sink { _ in
//                                                player.seek(to: CMTime.zero)
//                                                player.play()
//                                            }
//                                        
//                                        debugPrint(AppFileManager(path: "skin/\(usingSkin)").GetFilePath(name: "head_myself_mp4_bg.mp4"))
//                                        player.play()
//                                    }
//                                    .onDisappear {
//                                        finishObserver?.cancel()
//                                    }
//                                if !isSkinNoBlur {
//                                    Color.black
//                                        .ignoresSafeArea()
//                                        .opacity(0.4)
//                                }
//                            }
//                            .blur(radius: isSkinNoBlur ? 0 : 16)
//                        }
//                    }
            } else {
                MainView(isShowSettingsButton: true)
            }
        }
    }
    
    struct MainView: View {
        var isShowSettingsButton: Bool = false
        @Namespace public var imageAnimation
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
        @State var isLoginPresented = false
        @State var username = ""
        @State var userSign = ""
        @State var userFaceUrl = ""
        @State var isLogoutAlertPresented = false
        @State var isUserDetailSelfPresented = false
        @State var isNetworkFixPresented = false
        var body: some View {
            List {
                //VStack {
                    if sessdata == "" {
                        Button(action: {
                            isLoginPresented = true
                        }, label: {
                            Text("User.tap-to-login")
                        })
                        .sheet(isPresented: $isLoginPresented, content: {LoginView()})
                    } else {
                        VStack {
                            NavigationLink("", isActive: $isUserDetailSelfPresented, destination: {UserDetailView(uid: dedeUserID)})
                                .frame(width: 0, height: 0)
                            HStack {
                                if userFaceUrl != "" {
                                    CachedAsyncImage(url: URL(string: userFaceUrl + "@30w"))
                                        .frame(width: 30)
                                        .clipShape(Circle())
                                        .matchedGeometryEffect(id: "image", in: imageAnimation)
                                } else {
                                    Image("Placeholder")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .redacted(reason: .placeholder)
                                        .cornerRadius(100)
                                }
                                VStack {
                                    if username != "" {
                                        Text(username)
                                            .font(.system(size: 15))
                                    } else {
                                        Text("")
                                            .font(.system(size: 15))
                                            .redacted(reason: .placeholder)
                                    }
                                }
                            }
                            .onTapGesture {
                                isUserDetailSelfPresented = true
                            }
                        }
                            Group {
                                Section {
                                    NavigationLink(destination: {FollowListView(viewUserId: dedeUserID)}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "person.2.fill")
                                                    .foregroundColor(.accentColor)
                                                    .offset(x: -3)
                                                Text("User.subcribed-accounts")
                                                    .offset(x: -6)
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {DownloadsView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "square.and.arrow.down.fill")
                                                    .foregroundColor(.accentColor)
                                                Text("User.offline-cache")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {FavoriteView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.accentColor)
                                                Text("User.favorites")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {HistoryView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "clock.arrow.circlepath")
                                                    .foregroundColor(.accentColor)
                                                Text("User.histories")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                    NavigationLink(destination: {WatchLaterView()}, label: {
                                        HStack {
                                            HStack {
                                                Image(systemName: "memories")
                                                    .foregroundColor(.accentColor)
                                                Text("User.watch-later")
                                            }
                                            .font(.system(size: 16))
                                            Spacer()
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 13))
                                }
                                if isShowSettingsButton {
                                    Section {
                                        NavigationLink(destination: {SettingsView()}, label: {
                                            HStack {
                                                HStack {
                                                    Image(systemName: "gear")
                                                        .foregroundColor(.accentColor)
                                                    Text("Settings")
                                                }
                                                .font(.system(size: 16))
                                                Spacer()
                                            }
                                        })
                                    }
                                }
                            }
                            .navigationTitle("About-me")
                            .navigationBarTitleDisplayMode(.large)
                        .onAppear {
                            if username == "" {
                                getBuvid(url: "https://api.bilibili.com/x/space/wbi/acc/info".urlEncoded()) { buvid3, buvid4, _uuid, resp in
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata); innersign=0; buvid3=\(buvid3); b_nut=1704873471; i-wanna-go-back=-1; b_ut=7; b_lsid=9910433CB_18CF260AB89; _uuid=\(_uuid); enable_web_push=DISABLE; header_theme_version=undefined; home_feed_column=4; browser_resolution=3440-1440; buvid4=\(buvid4);",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                    biliWbiSign(paramEncoded: "mid=\(dedeUserID)".base64Encoded()) { signed in
                                        if let signed {
                                            debugPrint(signed)
                                            autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                                                if isSuccess {
                                                    debugPrint(respJson)
                                                    if !CheckBApiError(from: respJson) { return }
                                                    username = respJson["data"]["name"].string ?? ""
                                                    userSign = respJson["data"]["sign"].string ?? ""
                                                    userFaceUrl = respJson["data"]["face"].string ?? "E"
                                                } else if isShowNetworkFixing {
                                                    isNetworkFixPresented = true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
                    }
                //}
            }
        }
    }
}

struct PersonAccountView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAccountView()
    }
}
