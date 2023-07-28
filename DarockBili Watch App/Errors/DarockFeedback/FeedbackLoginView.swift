//
//  FeedbackLoginView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/13.
//

import SwiftUI
import DarockKit

struct FeedbackLoginView: View {
    @AppStorage("DarockIDAccount") var darockIdAccount = ""
    @State var accountCache = ""
    @State var passwdCache = ""
    @State var tipText = ""
    @State var isLoading = false
    @State var isRegisterPresented = false
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Text("登录 Darock 通行证")
                        .font(.system(size: 18, weight: .bold))
                    TextField("账号", text: $accountCache)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("密码", text: $passwdCache)
                    Button(action: {
                        isLoading = true
                        DarockKit.Network.shared.requestString("https://api.darock.top/user/login/\(accountCache)/\(passwdCache)") { respStr, isSuccess in
                            if isSuccess {
                                debugPrint(respStr)
                                if respStr.apiFixed() == "Success" {
                                    darockIdAccount = accountCache
                                } else {
                                    tipText = "账号或密码错误"
                                }
                            } else {
                                tipText = "错误：无法连接到 Darock"
                            }
                            isLoading = false
                        }
                    }, label: {
                        if !isLoading {
                            Text("登录")
                        } else {
                            ProgressView()
                        }
                    })
                    .disabled(isLoading)
                    Button(action: {
                        isRegisterPresented = true
                    }, label: {
                        Text("注册")
                    })
                    .sheet(isPresented: $isRegisterPresented, content: {RegisterView()})
                    Text(tipText)
                }
                Group {
                    Spacer()
                        .frame(height: 20)
                    NavigationLink(destination: {FeedbackView()}, label: {
                        Text("不想登录？直接反馈 ->")
                    })
                }
            }
        }
    }
    
    struct RegisterView: View {
        @State var mailCache = ""
        @State var mailCodeCache = ""
        @State var serverMailCode = ""
        @State var passwdCache = ""
        @State var passwd2Cache = ""
        @State var tipText = ""
        var body: some View {
            ScrollView {
                VStack {
                    Text("注册 Darock 通行证")
                        .font(.system(size: 18, weight: .bold))
                    TextField("邮箱", text: $mailCache)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            serverMailCode = ""
                        }
                    Button(action: {
                        DarockKit.Network.shared.requestString("https://api.darock.top/user/mail/send/\(mailCache)") { respStr, isSuccess in
                            if isSuccess {
                                serverMailCode = respStr
                            }
                        }
                    }, label: {
                        Text("发送验证码")
                    })
                    .disabled(mailCache == "")
                    TextField("验证码", text: $mailCodeCache)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("密码", text: $passwdCache)
                    SecureField("确认密码", text: $passwdCache)
                    Button(action: {
                        if mailCodeCache == serverMailCode {
                            if passwdCache == passwd2Cache {
                                DarockKit.Network.shared.requestString("https://api.darock.top/user/reg/\(mailCache)/\(passwdCache)") { respStr, isSuccess in
                                    if isSuccess {
                                        if respStr.apiFixed() == "Success" {
                                            tipText = "注册成功！"
                                        }
                                    }
                                }
                            } else {
                                tipText = "两次密码不匹配"
                            }
                        } else {
                            tipText = "验证码错误"
                        }
                    }, label: {
                        Text("注册")
                    })
                    Text(tipText)
                }
            }
        }
    }
}

struct FeedbackLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackLoginView()
    }
}

