//
//  PersonAccountView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI
import CachedAsyncImage

struct PersonAccountView: View {
    
    var body: some View {
        NavigationStack {
            if #available(watchOS 10, *) {
                MainView()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            NavigationLink(destination: {SettingsView()}, label: {
                                Image(systemName: "gear")
                                    .foregroundColor(.accentColor)
                            })
                        }
                    }
            } else {
                MainView(isShowSettingsButton: true)
            }
        }
    }
    
    struct MainView: View {
        var isShowSettingsButton: Bool = false
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
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
                            Text("点击登录")
                        })
                        .sheet(isPresented: $isLoginPresented, content: {LoginView()})
                    } else {
                        VStack {
                            NavigationLink("", isActive: $isUserDetailSelfPresented, destination: {UserDetailView(uid: dedeUserID)})
                                .frame(width: 0, height: 0)
                            HStack {
                                if userFaceUrl != "" {
                                    CachedAsyncImage(url: URL(string: userFaceUrl + "@28w"))
                                        .cornerRadius(.infinity)
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
                                        Text("Jst Placeholder")
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
                                                Text("我的好友")
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
                                                Text("离线缓存")
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
                                                Text("历史记录")
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
                                                Text("我的收藏")
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
                                                Text("稍后再看")
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
                                                    Text("设置")
                                                }
                                                .font(.system(size: 16))
                                                Spacer()
                                            }
                                        })
                                    }
                                }
                            }
                            .navigationTitle("我的")
                            .navigationBarTitleDisplayMode(.large)
                        .onAppear {
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata);"
                            ]
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/member/web/account", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    username = respJson["data"]["uname"].string ?? ""
                                    userSign = respJson["data"]["sign"].string ?? ""
                                } else {
                                    isNetworkFixPresented = true
                                }
                            }
                            DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(dedeUserID)".base64Encoded())") { respStr, isSuccess in
                                if isSuccess {
                                    debugPrint(respStr.apiFixed())
                                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            debugPrint(respJson)
                                            userFaceUrl = respJson["data"]["face"].string!
                                        } else {
                                            isNetworkFixPresented = true
                                        }
                                    }
                                } else {
                                    isNetworkFixPresented = true
                                }
                            }
                            
                            recordUserStep("Enter PersonAccountView")
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
