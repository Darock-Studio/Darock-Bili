//
//
//  PersonAccountView.swift
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

import AVKit
import SwiftUI
import Combine
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation
import SDWebImageSwiftUI

struct PersonAccountView: View {
    var isSettingsButtonTrailing = false
    @Namespace public var imageAnimation
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
    @State var username = ""
    @State var userSign = ""
    @State var userFaceUrl = ""
    @State var isLogoutAlertPresented = false
    @State var isUserDetailSelfPresented = false
    @State var isNetworkFixPresented = false
    @State var isUserSwitchPresented = false
    @State var isNewUserPresenting = false
    var body: some View {
        List {
            if sessdata == "" {
                NavigationLink(destination: { LoginView() }, label: {
                    Label("User.tap-to-login", privateSystemImage: "apple.logo.lock.open")
                })
                .sheet(isPresented: $isNewUserPresenting, content: { LoginView() })
            } else {
                NavigationLink(destination: { UserDetailView(uid: dedeUserID) }, label: {
                    HStack {
                        if userFaceUrl != "" {
                            WebImage(url: URL(string: userFaceUrl))
                                .resizable()
                                .placeholder {
                                    Circle()
                                        .redacted(reason: .placeholder)
                                }
#if !os(watchOS)
                                .frame(width: 60, height: 60)
#else
                                .frame(width: 30, height: 30)
#endif
                                .clipShape(Circle())
                        } else {
                            Image("Placeholder")
                                .resizable()
#if !os(watchOS)
                                .frame(width: 60, height: 60)
#else
                                .frame(width: 28, height: 28)
#endif
                                .redacted(reason: .placeholder)
                                .clipShape(Circle())
                        }
                        VStack {
                            if username != "" {
                                Text(username)
#if !os(watchOS)
                                    .font(.system(size: 20))
#else
                                    .font(.system(size: 15))
#endif
                            } else {
                                Text("UsernamePlaceholder")
#if !os(watchOS)
                                    .font(.system(size: 20))
#else
                                    .font(.system(size: 13))
#endif
                                    .redacted(reason: .placeholder)
                            }
                        }
                    }
                })
#if !os(watchOS)
                NavigationLink(destination: { SelfQrCardView() }, label: {
                    HStack {
                        HStack {
                            Image(systemName: "qrcode")
                                .foregroundColor(.accentColor)
                            Text("二维码名片")
                        }
                        .font(.system(size: 16))
                        Spacer()
                    }
                })
                .buttonBorderShape(.roundedRectangle(radius: 13))
#endif
                Group {
                    Section {
                        NavigationLink(destination: { FollowListView(viewUserId: dedeUserID) }, label: {
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
                        NavigationLink(destination: { DownloadsView() }, label: {
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
                        NavigationLink(destination: { FavoriteView() }, label: {
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
                        NavigationLink(destination: { HistoryView() }, label: {
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
                        NavigationLink(destination: { WatchLaterView() }, label: {
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
#if os(watchOS)
                    Section {
                        NavigationLink(destination: { InAppFeedbackView() }, label: {
                            HStack {
                                Image(systemName: "exclamationmark.bubble")
                                    .foregroundColor(.accentColor)
                                Text("反馈助理")
                            }
                            .font(.system(size: 16))
                        })
                    }
#endif
                }
            }
#if !os(watchOS)
            Section {
                NavigationLink(destination: { SettingsView() }, label: {
                    HStack {
                        Image(systemName: "gear").foregroundStyle(Color.accentColor)
                        Text("设置")
                    }
                })
            }
#endif
        }
        .navigationTitle("About-me")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: { SettingsView() }, label: {
                    Image(systemName: "gear")
                        .foregroundStyle(Color.accentColor)
                })
            }
        }
        .onAppear {
            getAccountInfos()
        }
        .sheet(isPresented: $isNetworkFixPresented, content: { NetworkFixView() })
    }
    func getAccountInfos() {
        if username == "" {
            getBuvid(url: "https://api.bilibili.com/x/space/wbi/acc/info".urlEncoded()) { buvid3, buvid4, _uuid, _ in
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
}

struct PersonAccountView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAccountView()
    }
}
