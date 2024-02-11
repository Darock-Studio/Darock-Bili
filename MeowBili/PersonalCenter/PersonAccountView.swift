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
            MainView(isShowSettingsButton: true)
                .toolbar {
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
        @State var userList1: [Any] = []
        @State var userList2: [Any] = []
        @State var userList3: [Any] = []
        @State var userList4: [Any] = []
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
                //VStack {
                    if sessdata == "" {
                        NavigationLink(destination: {LoginView()}, label: {
                            Label("User.tap-to-login", systemImage: "rectangle.and.pencil.and.ellipsis")
                        })
                        Button(action: {isUserSwitchPresented = true}, label: {
                            HStack {
                                HStack {
                                    Image(systemName: "person.2.badge.key.fill")
                                        .foregroundColor(.accentColor)
                                    Text("User.switch")
                                }
                                .font(.system(size: 16))
                                Spacer()
                            }
                        })
                        .sheet(isPresented: $isUserSwitchPresented, content: {
                            List {
                                if #available(watchOS 10.0, *) {} else {
                                    Button(action: {
                                        isNewUserPresenting = true
                                    }, label: {
                                        Label("User.switch.add", systemImage: "plus")
                                    })
                                }
                                
                                if userList1.isEmpty {
                                    Text("User.switch.none")
                                        .bold()
                                        .foregroundStyle(.secondary)
                                } else {
                                    Section(content: {
                                        ForEach(0..<userList1.count, id: \.self) { user in
                                            Button(action: {
                                                dedeUserID = userList1[user] as! String
                                                dedeUserID__ckMd5 = userList2[user] as! String
                                                sessdata = userList3[user] as! String
                                                biliJct = userList4[user] as! String
                                            }, label: {
                                                Text(userList1[user] as! String)
                                            })
                                        }
                                        .onDelete(perform: { user in
                                            userList1.remove(atOffsets: user)
                                            userList2.remove(atOffsets: user)
                                            userList3.remove(atOffsets: user)
                                            userList4.remove(atOffsets: user)
                                            UserDefaults.standard.set(userList1, forKey: "userList1")
                                            UserDefaults.standard.set(userList2, forKey: "userList2")
                                            UserDefaults.standard.set(userList3, forKey: "userList3")
                                            UserDefaults.standard.set(userList4, forKey: "userList4")
                                        })
                                        .onMove(perform: { users, user  in
                                            userList1.move(fromOffsets: users, toOffset: user)
                                            userList2.move(fromOffsets: users, toOffset: user)
                                            userList3.move(fromOffsets: users, toOffset: user)
                                            userList4.move(fromOffsets: users, toOffset: user)
                                            UserDefaults.standard.set(userList1, forKey: "userList1")
                                            UserDefaults.standard.set(userList2, forKey: "userList2")
                                            UserDefaults.standard.set(userList3, forKey: "userList3")
                                            UserDefaults.standard.set(userList4, forKey: "userList4")
                                        })
                                    }, footer: {
                                        Text("User.switch.description")
                                        Text("User.switch.description.1")
                                    })
                                }
                            }
                            .toolbar {
                                if #available(watchOS 10.0, *) {
                                    ToolbarItem(placement: .bottomBar) {
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                isNewUserPresenting = true
                                            }, label: {
                                                Image(systemName: "plus")
                                            })
                                        }
                                    }
                                }
                            }
                        })
                        .onAppear {
                            userList1 = UserDefaults.standard.array(forKey: "userList1") ?? []
                            userList2 = UserDefaults.standard.array(forKey: "userList2") ?? []
                            userList3 = UserDefaults.standard.array(forKey: "userList3") ?? []
                            userList4 = UserDefaults.standard.array(forKey: "userList4") ?? []
                        }
                        .sheet(isPresented: $isNewUserPresenting, content: {LoginView()})
                    } else {
                        NavigationLink(destination: {UserDetailView(uid: dedeUserID)}, label: {
                            HStack {
                                if userFaceUrl != "" {
                                    CachedAsyncImage(url: URL(string: userFaceUrl + "@60w"))
                                        .frame(width: 60)
                                        .clipShape(Circle())
                                        .matchedGeometryEffect(id: "image", in: imageAnimation)
                                } else {
                                    Image("Placeholder")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .redacted(reason: .placeholder)
                                        .cornerRadius(100)
                                }
                                VStack {
                                    if username != "" {
                                        Text(username)
                                            .font(.system(size: 20))
                                    } else {
                                        Text("UsernamePlaceholder")
                                            .font(.system(size: 20))
                                            .redacted(reason: .placeholder)
                                    }
                                }
                            }
                        })
                        Button(action: {isUserSwitchPresented = true}, label: {
                            HStack {
                                HStack {
                                    Image(systemName: "person.2.badge.key.fill")
                                        .foregroundColor(.accentColor)
                                    Text("User.switch")
                                }
                                .font(.system(size: 16))
                                Spacer()
                            }
                        })
                        .sheet(isPresented: $isNewUserPresenting, content: {LoginView()})
                        .sheet(isPresented: $isUserSwitchPresented, content: {
                            List {
                                if #available(watchOS 10.0, *) {} else {
                                    Button(action: {
                                        isNewUserPresenting = true
                                    }, label: {
                                        Label("User.switch.add", systemImage: "plus")
                                    })
                                }
                                
                                Section(content: {
                                    ForEach(0..<userList1.count, id: \.self) {user in
                                        Button(action: {
                                            dedeUserID = userList1[user] as! String
                                            dedeUserID__ckMd5 = userList2[user] as! String
                                            sessdata = userList3[user] as! String
                                            biliJct = userList4[user] as! String
                                        }, label: {
                                            Text(userList1[user] as! String)
                                        })
                                    }
                                    .onDelete(perform: { user in
                                        userList1.remove(atOffsets: user)
                                        userList2.remove(atOffsets: user)
                                        userList3.remove(atOffsets: user)
                                        userList4.remove(atOffsets: user)
                                        UserDefaults.standard.set(userList1, forKey: "userList1")
                                        UserDefaults.standard.set(userList2, forKey: "userList2")
                                        UserDefaults.standard.set(userList3, forKey: "userList3")
                                        UserDefaults.standard.set(userList4, forKey: "userList4")
                                    })
                                    .onMove(perform: { users, user  in
                                        userList1.move(fromOffsets: users, toOffset: user)
                                        userList2.move(fromOffsets: users, toOffset: user)
                                        userList3.move(fromOffsets: users, toOffset: user)
                                        userList4.move(fromOffsets: users, toOffset: user)
                                        UserDefaults.standard.set(userList1, forKey: "userList1")
                                        UserDefaults.standard.set(userList2, forKey: "userList2")
                                        UserDefaults.standard.set(userList3, forKey: "userList3")
                                        UserDefaults.standard.set(userList4, forKey: "userList4")
                                    })
                                }, footer: {
                                    Text("User.switch.description")
                                    Text("User.switch.description.1")
                                })
                            }
                            .toolbar {
                                if #available(watchOS 10.0, *) {
                                    ToolbarItem(placement: .bottomBar) {
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                isNewUserPresenting = true
                                            }, label: {
                                                Image(systemName: "plus")
                                            })
                                        }
                                    }
                                }
                            }
                        })
                        .onAppear {
                            userList1 = UserDefaults.standard.array(forKey: "userList1") ?? []
                            userList2 = UserDefaults.standard.array(forKey: "userList2") ?? []
                            userList3 = UserDefaults.standard.array(forKey: "userList3") ?? []
                            userList4 = UserDefaults.standard.array(forKey: "userList4") ?? []
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
                            getAccountInfos()
                        }
                        .sheet(isPresented: $isNetworkFixPresented, content: {NetworkFixView()})
                    }
                //}
            }
        }
        func getAccountInfos() {
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
    }
}

struct PersonAccountView_Previews: PreviewProvider {
    static var previews: some View {
        PersonAccountView()
    }
}
