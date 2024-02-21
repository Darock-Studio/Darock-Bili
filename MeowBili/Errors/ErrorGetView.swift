//
//
//  ErrorGetView.swift
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

import SwiftUI
import DarockKit

struct ErrorGetView: View {
    var error: GetableError
    @Environment(\.dismiss) var dismiss
    @State var doing = ""
    @State var isClosePresented = false
    @State var isSendPresented = false
    @State var isSent = false
    @State var sentCode = ""
    @State var isError = false
    @State var isNetworkFixPresented = false
    var body: some View {
        ScrollView {
            Group {
                Text("Error.ran-into-a-problem")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                    .frame(height: 15)
                Text(String(localized: "Error.sorry.\(error.when)") + "\(error.ignoreable ? "" : String(localized: "Error.fatal"))")
                if error.area == "网络请求" {
                    Spacer()
                        .frame(height: 15)
                    Button(action: {
                        isNetworkFixPresented = true
                    }, label: {
                        Text("Error.network-troubleshoot")
                    })
                    .sheet(isPresented: $isNetworkFixPresented, content: { NetworkFixView() })
                }
                Spacer()
                    .frame(height: 10)
                Text("Error.information")
                Text("Error.area.\(error.area)")
                Text("Error.place.\(error.inAppArea)")
                Text("Error.details.\(error.errDetail)")
                Spacer()
                    .frame(height: 15)
            }
            Group {
                if error.sendable {
                    Text("Error.send-to-Darock-advice")
                    Spacer()
                        .frame(height: 10)
                    Text("Error")
                    TextField("Error.before-ranning-into-problem", text: $doing)
                    Spacer()
                        .frame(height: 15)
                    Button(action: {
                        isSendPresented = true
                    }, label: {
                        Text("Error.send")
                            .bold()
                    })
                    .sheet(isPresented: $isSendPresented, content: {
                        VStack {
                            if !isSent {
                                ProgressView()
                                Text("Error.sending")
                                    .bold()
                                Text("Error.appriciate")
                                    .bold()
                            } else {
                                Text("Error.sent")
                                    .bold()
                                Text("Error.number.\(Text(sentCode))")
                                    .font(.system(size: 18, weight: .bold))
                                if error.ignoreable {
                                    Button(action: {
                                        dismiss()
                                    }, label: {
                                        Text("Error.leave")
                                            .bold()
                                    })
                                } else {
                                    Button(action: {
                                        exit(114514)
                                    }, label: {
                                        Text("Error.exit")
                                            .bold()
                                    })
                                }
                            }
                        }
                        .onAppear {
                            DarockKit.Network.shared.requestString("https://api.darock.top/bili/feedback/\(("范围：\(error.area)\n位置：\(error.inAppArea)\n详细信息：\(error.errDetail)\n用户描述：\(doing)").base64Encoded())") { respStr, isSuccess in
                                if isSuccess {
                                    sentCode = respStr
                                    isSent = true
                                }
                            }
                        }
                    })
                    Button(action: {
                        if error.ignoreable {
                            dismiss()
                        } else {
                            isClosePresented = true
                        }
                    }, label: {
                        Text("Error.do-not-send")
                    })
                    .sheet(isPresented: $isClosePresented, content: {
                        Text("Error.exiting")
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                                    timer.invalidate()
                                    exit(114514)
                                }
                            }
                    })
                } else {
                    Text("Error.no-need-to-send")
                }
            }
        }
    }
}

struct GetableError {
    let when: String
    let area: String
    let inAppArea: String
    let errDetail: String
    var ignoreable: Bool = true
    var sendable: Bool = true
}

struct ErrorGetView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorGetView(error: GetableError(when: "Test", area: "Test", inAppArea: "Test", errDetail: "Test"))
    }
}
