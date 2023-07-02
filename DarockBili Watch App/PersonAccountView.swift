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

struct PersonAccountView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLoginPresented = false
    @State var username = ""
    @State var userSign = ""
    @State var userFaceUrl = ""
    @State var isLogoutAlertPresented = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if sessdata == "" {
                        Button(action: {
                            isLoginPresented = true
                        }, label: {
                            Text("点击登录")
                        })
                        .sheet(isPresented: $isLoginPresented, content: {LoginView()})
                    } else {
                        VStack {
                            HStack {
                                if userFaceUrl != "" {
                                    WebImage(url: URL(string: userFaceUrl + "@60w"), options: [.progressiveLoad])
                                        .cornerRadius(100)
                                }
                                VStack {
                                    Text(username)
                                        .font(.system(size: 15, weight: .bold))
                                }
                            }
                            VStack {
                                NavigationLink(destination: {FollowListView(viewUserId: dedeUserID)}, label: {
                                    Label("关注列表", systemImage: "person.badge.plus")
                                        .font(.system(size: 18))
                                        .bold()
                                })
                                NavigationLink(destination: {}, label: {
                                    Label("离线缓存", systemImage: "arrow.down.doc")
                                        .font(.system(size: 18))
                                        .bold()
                                })
                                NavigationLink(destination: {}, label: {
                                    Label("历史记录", systemImage: "clock.arrow.circlepath")
                                        .font(.system(size: 18))
                                        .bold()
                                })
                                NavigationLink(destination: {}, label: {
                                    Label("我的收藏", systemImage: "star")
                                        .font(.system(size: 18))
                                        .bold()
                                })
                                Spacer()
                                    .frame(height: 20)
                                NavigationLink(destination: {AboutView()}, label: {
                                    Label("关于", systemImage: "")
                                        .font(.system(size: 18))
                                        .bold()
                                })
                                Spacer()
                                    .frame(height: 20)
                                Button(role: .destructive, action: {
                                    isLogoutAlertPresented = true
                                }, label: {
                                    Label("退出登录", systemImage: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 18))
                                        .bold()
                                })
                                .alert("退出登录", isPresented: $isLogoutAlertPresented, actions: {
                                    Button(role: .destructive, action: {
                                        dedeUserID = ""
                                        dedeUserID__ckMd5 = ""
                                        sessdata = ""
                                        biliJct = ""
                                    }, label: {
                                        Text("确定")
                                    })
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("取消")
                                    })
                                }, message: {
                                    Text("确定吗？")
                                })
                            }
                            
                        }
                        .onAppear {
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata);"
                            ]
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/member/web/account", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    username = respJson["data"]["uname"].string!
                                    userSign = respJson["data"]["sign"].string!
                                }
                            }
                            DarockKit.Network.shared.requestString("https://api.darock.top/bili/wbi/sign/\("mid=\(dedeUserID)".base64Encoded())") { respStr, isSuccess in
                                if isSuccess {
                                    debugPrint(respStr.apiFixed())
                                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/acc/info?\(respStr.apiFixed())", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            debugPrint(respJson)
                                            userFaceUrl = respJson["data"]["face"].string!
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PersonAccountView()
}
