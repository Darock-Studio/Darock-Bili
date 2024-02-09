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
                    Text("DarockID.login.title")
                        .font(.system(size: 18, weight: .bold))
                    TextField("DarockID.account", text: $accountCache)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("DarockID.password", text: $passwdCache)
                    Button(action: {
                        isLoading = true
                        DarockKit.Network.shared.requestString("https://api.darock.top/user/login/\(accountCache)/\(passwdCache)") { respStr, isSuccess in
                            if isSuccess {
                                debugPrint(respStr)
                                if respStr.apiFixed() == "Success" {
                                    darockIdAccount = accountCache
                                } else {
                                    tipText = String(localized: "DarockID.incorrect")
                                }
                            } else {
                                tipText = String(localized: "DarockID.unable-to-connect")
                            }
                            isLoading = false
                        }
                    }, label: {
                        if !isLoading {
                            Text("DarockID.login")
                        } else {
                            ProgressView()
                        }
                    })
                    .disabled(isLoading)
                    Button(action: {
                        isRegisterPresented = true
                    }, label: {
                        Text("DarockID.register")
                    })
                    .sheet(isPresented: $isRegisterPresented, content: {RegisterView()})
                    Text(tipText)
                }
                Group {
                    Spacer()
                        .frame(height: 20)
                    NavigationLink(destination: {FeedbackView()}, label: {
                        Text("DarockID.feedback-without-logging-in")
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
                    Text("DarockID.register.title")
                        .font(.system(size: 18, weight: .bold))
                    TextField("DarockID.email", text: $mailCache)
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
                        Text("DarockID.verification-code.send")
                    })
                    .disabled(mailCache.isEmpty)
                    TextField("DarockID.verification-code", text: $mailCodeCache)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("DarockID.password", text: $passwdCache)
                    SecureField("DarockID.password.confirm", text: $passwdCache)
                    Button(action: {
                        if mailCodeCache == serverMailCode {
                            if passwdCache == passwd2Cache {
                                DarockKit.Network.shared.requestString("https://api.darock.top/user/reg/\(mailCache)/\(passwdCache)") { respStr, isSuccess in
                                    if isSuccess {
                                        if respStr.apiFixed() == "Success" {
                                            tipText = String(localized: "DarockID.register.success")
                                        }
                                    }
                                }
                            } else {
                                tipText = String(localized: "DarockID.password.unmatch")
                            }
                        } else {
                            tipText = String(localized: "DarockID.code.unmatch")
                        }
                    }, label: {
                        Text("DarockID.register")
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

