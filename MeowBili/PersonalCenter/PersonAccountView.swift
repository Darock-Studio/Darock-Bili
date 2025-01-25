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
import Alamofire
import SwiftyJSON
import AVFoundation
import DarockFoundation
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
                    Section {
                        NavigationLink(destination: { FeedbackView() }, label: {
                            HStack {
                                Image(systemName: "exclamationmark.bubble")
                                    .foregroundColor(.accentColor)
                                Text("反馈助理")
                            }
                            .font(.system(size: 16))
                        })
                    }
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
            getAccountInfo()
        }
        .sheet(isPresented: $isNetworkFixPresented, content: { NetworkFixView() })
    }
    func getAccountInfo() {
        if username == "" {
            Task {
                if let info = await BiliAPI.shared.userInfo() {
                    username = info.name
                    userSign = info.sign
                    userFaceUrl = info.face
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
