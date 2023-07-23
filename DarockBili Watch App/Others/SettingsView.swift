//
//  SettingsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/5.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLogoutAlertPresented = false
    var body: some View {
        List {
            Section {
                NavigationLink(destination: {PlayerSettingsView()}, label: {
                    Text("播放设置")
                })
            }
            Section {
                NavigationLink(destination: {FeedbackView()}, label: {
                    Text("反馈问题")
                })
                NavigationLink(destination: {AboutView()}, label: {
                    Text("关于")
                })
            }
            if sessdata != "" {
                Section {
                    Button(role: .destructive, action: {
                        isLogoutAlertPresented = true
                    }, label: {
                        HStack {
                            Text("退出登录")
                                .font(.system(size: 16))
                            Spacer()
                        }
                    })
                    .buttonBorderShape(.roundedRectangle(radius: 13))
                    .alert("退出登录", isPresented: $isLogoutAlertPresented, actions: {
                        Button(role: .destructive, action: {
                            dedeUserID = ""
                            dedeUserID__ckMd5 = ""
                            sessdata = ""
                            biliJct = ""
                        }, label: {
                            HStack {
                                Text("确定")
                                Spacer()
                            }
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
        }
        .navigationTitle("设置")
        .navigationBarTitleDisplayMode(.large)
    }
    
    struct PlayerSettingsView: View {
        @AppStorage("IsPlayerAutoRotating") var isPlayerAutoRotating = true
        var body: some View {
            List {
                Toggle("自动旋转（仅竖向）", isOn: $isPlayerAutoRotating)
            }
        }
    }
}

#Preview {
    SettingsView()
}
