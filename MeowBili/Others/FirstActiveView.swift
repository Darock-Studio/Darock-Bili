//
//
//  FirstActiveView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/20.
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
import SDWebImageSwiftUI

struct FirstActiveView: View {
    @Binding var isActived: Bool
    @AppStorage("IsAllowMixpanel") var isAllowMixpanel = true
    @State var startTextOffset: CGFloat = 0
    @State var isEnterSecondPage = false
    @State var welcomeToMeowbiliTextOffset: CGFloat = 30
    @State var nsButton1Offset: CGFloat = 30
    @State var isLoggedPresented = false
    @State var loginStatus = "false"
    @State var isAboutAppAnalyzeAPrivacyPresented = false
    @State var isAppAnalyzeFinished = false
    var body: some View {
        if !isEnterSecondPage {
            ZStack {
                Color.black
                if !isAppAnalyzeFinished {
                    WebImage(url: Bundle.main.url(forResource: "active-hello-en", withExtension: "gif"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500)
                } else {
                    Text("欢迎使用喵哩喵哩")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 36, weight: .bold))
                }
                VStack {
                    Spacer()
                    Text("向上轻扫以开始")
                        .font(.system(size: 15, weight: .bold))
                        .offset(y: startTextOffset)
                    Spacer()
                        .frame(height: 25)
                }
            }
            .ignoresSafeArea()
            .defersSystemGestures(on: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height < 0 && value.startLocation.y > UIScreen.main.bounds.height - 150 {
                            withAnimation {
                                startTextOffset = value.translation.height / 2
                            }
                        }
                        if startTextOffset < -30 {
                            if isAppAnalyzeFinished {
                                isActived = true
                            } else {
                                isEnterSecondPage = true
                                startTextOffset = 0
                            }
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            startTextOffset = 0
                        }
                    }
            )
        } else {
            NavigationStack {
                VStack {
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        Text("欢迎来到喵哩喵哩")
                            .font(.system(size: 36, weight: .bold))
                            .offset(y: welcomeToMeowbiliTextOffset)
                            .opacity(1 - Double(welcomeToMeowbiliTextOffset) / 30)
                            .animation(.easeOut(duration: 0.8), value: welcomeToMeowbiliTextOffset)
                        Spacer()
                    }
                    Spacer()
                    NavigationLink(destination: {
                        VStack {
                            Image(systemName: "doc.plaintext")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.blue)
                            Text("在使用前，您需要先同意喵哩喵哩的隐私政策")
                            GeometryReader { proxy in
                                ScrollView {
                                    WebView(url: URL(string: "https://cd.darock.top:32767/meowbili/privacy")!)
                                        .frame(width: proxy.size.width, height: proxy.size.height)
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button(action: {
                                    exit(0)
                                }, label: {
                                    Text("不同意")
                                })
                                Spacer()
                                NavigationLink(destination: {
                                    VStack {
                                        Image(systemName: "person.fill.checkmark")
                                            .font(.system(size: 40))
                                            .foregroundStyle(Color.blue)
                                        Text("以及我们的用户须知")
                                        ScrollView {
                                            VStack {
                                                Text("""
                                                · 本 App 由第三方开发者以及部分社区用户贡献，与哔哩哔哩无合作关系，哔哩哔哩是上海宽娱数码科技有限公司的商标。
                                                
                                                · 本 App 并不是哔哩哔哩的替代品，我们建议您在能够使用官方客户端时尽量使用官方客户端。
                                                
                                                · 本 App 均使用来源于网络的公开信息进行开发。
                                                
                                                · 本 App 中和B站相关的功能完全免费
                                                
                                                · 本 App 中所呈现的B站内容来自哔哩哔哩官方。
                                                
                                                · 本 App 的开发者、负责人和实际责任人是\(Text("WindowsMEMZ").foregroundColor(Color.accentColor))
                                                """)
                                            }
                                        }
                                        .padding()
                                    }
                                    .toolbar {
                                        ToolbarItemGroup(placement: .bottomBar) {
                                            Spacer()
                                            NavigationLink(destination: {
                                                VStack {
                                                    Image("PrivacyHandshake")
                                                    Text("数据与隐私")
                                                        .font(.largeTitle)
                                                        .bold()
                                                    Text("Darock 功能请求使用您的个人信息时会出现此图标。")
                                                        .multilineTextAlignment(.center)
                                                        .padding(.vertical, 3)
                                                    Text("并非所有功能都会出现此图标，因为 Darock 仅当需要启用功能，保护服务的安全或个性化您的使用体验时才会收集此信息。")
                                                        .multilineTextAlignment(.center)
                                                        .padding(.vertical, 3)
                                                    Text("Darock 将隐私视作每个人的基本权利，因此所有 Darock 产品旨在收集和使用最少的用户数据，尽可能地使用本机处理，以及赋予用户对信息的知情权和控制权。")
                                                        .multilineTextAlignment(.center)
                                                        .padding(.vertical, 3)
                                                    Spacer()
                                                    NavigationLink(destination: {
                                                        VStack {
                                                            Image(systemName: "person.crop.circle")
                                                                .font(.system(size: 40))
                                                                .foregroundStyle(Color.blue)
                                                            Text("账号")
                                                                .font(.largeTitle)
                                                                .bold()
                                                            Text("通过哔哩哔哩登录")
                                                            LoginView(status: $loginStatus)
                                                                .onChange(of: loginStatus) { value in
                                                                    if value == "true" {
                                                                        isLoggedPresented = true
                                                                    }
                                                                }
                                                            NavigationLink(destination: VStack {
                                                                Image(systemName: "chart.bar.xaxis")
                                                                    .font(.system(size: 40))
                                                                    .foregroundStyle(Color.blue)
                                                                Text("喵哩喵哩 分析")
                                                                    .font(.largeTitle)
                                                                    .bold()
                                                                Text("允许对您喵哩喵哩的使用数据进行分析，以帮助 Darock 改进产品和服务，您可以稍后在喵哩喵哩内的“设置”中更改您的决定。")
                                                                    .multilineTextAlignment(.center)
                                                                    .padding(.vertical, 3)
                                                                Text("所有数据的收集均受隐私保护技术的保护，且不与您或您的账户关联。")
                                                                    .multilineTextAlignment(.center)
                                                                    .padding(.vertical, 5)
                                                                Spacer()
                                                                Button(action: {
                                                                    isAboutAppAnalyzeAPrivacyPresented = true
                                                                }, label: {
                                                                    Text("关于 App 分析与隐私...")
                                                                        .foregroundStyle(Color.blue)
                                                                })
                                                                .sheet(isPresented: $isAboutAppAnalyzeAPrivacyPresented) {
                                                                    NavigationStack {
                                                                        ScrollView {
                                                                            VStack {
                                                                                Text("App 分析与隐私")
                                                                                    .font(.largeTitle)
                                                                                    .bold()
                                                                                Text("分析旨在保护你的信息并可让你选择要共享的内容。")
                                                                                    .multilineTextAlignment(.center)
                                                                                    .padding(.vertical, 10)
                                                                                Text("""
                                                                            喵哩喵哩 App 分析
                                                                            
                                                                            喵哩喵哩分析可能会包括硬件和操作系统规格方面的详细信息、性能统计数据，以及应用程序的使用数据。此类信息用于帮助 Darock 改善和开发其产品和服务。任何被收集的信息都无法用来识别你的身份。个人数据或是根本不会被记录，或是受隐私保护技术的约束，或是在发送给 Darock 前就已从报告中移除。你可以在喵哩喵哩个人页中前往“设置”>“隐私与安全性”>，然后轻点“分析数据”来查看此类信息。
                                                                            
                                                                            你也可以选择完全停用“喵哩喵哩 App 分析”共享。若要停用，请前往“设置”>“隐私与安全性”，然后轻点以关闭“允许收集使用信息”。如果拥有与iPhone配对的Apple Watch，则可在Apple Watch上执行相同操作。
                                                                            
                                                                            使用这些功能即表示你同意和允许 Darock 及代理机构按上述条件传输、收集、维护、处理和使用这些信息。
                                                                            
                                                                            Darock 收集的信息始终会遵照 Darock 的“隐私政策”处理，其内容可参阅https://darock.top/meowbili/privacy
                                                                            """)
                                                                            }
                                                                            .padding()
                                                                        }
                                                                        .navigationTitle("App 分析与隐私")
                                                                        .navigationBarTitleDisplayMode(.inline)
                                                                        .toolbar {
                                                                            ToolbarItem(placement: .topBarTrailing) {
                                                                                Button(action: {
                                                                                    isAboutAppAnalyzeAPrivacyPresented = false
                                                                                }, label: {
                                                                                    Text("完成")
                                                                                })
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                Button(action: {
                                                                    isAppAnalyzeFinished = true
                                                                    isEnterSecondPage = false
                                                                }, label: {
                                                                    VStack {
                                                                        Spacer()
                                                                            .frame(height: 5)
                                                                        HStack {
                                                                            Spacer()
                                                                            Text("与 Darock 共享")
                                                                                .bold()
                                                                            Spacer()
                                                                        }
                                                                        Spacer()
                                                                            .frame(height: 5)
                                                                    }
                                                                })
                                                                .tint(.blue)
                                                                .buttonStyle(.borderedProminent)
                                                                .padding(.vertical, 2)
                                                                Button(action: {
                                                                    isAllowMixpanel = false
                                                                    isAppAnalyzeFinished = true
                                                                    isEnterSecondPage = false
                                                                }, label: {
                                                                    Text("不共享")
                                                                        .bold()
                                                                        .foregroundStyle(Color.blue)
                                                                })
                                                                .padding(.vertical, 2)
                                                            }
                                                            .padding()
                                                            , isActive: $isLoggedPresented, label: {
                                                                Text("稍后登录")
                                                                    .foregroundStyle(Color.blue)
                                                            })
                                                            .padding()
                                                        }
                                                    }, label: {
                                                        VStack {
                                                            Spacer()
                                                                .frame(height: 10)
                                                            HStack {
                                                                Spacer()
                                                                Text("继续")
                                                                    .bold()
                                                                Spacer()
                                                            }
                                                            Spacer()
                                                                .frame(height: 10)
                                                        }
                                                    })
                                                    .tint(.blue)
                                                    .buttonStyle(.borderedProminent)
                                                }
                                                .padding()
                                            }, label: {
                                                Text("我已了解")
                                            })
                                        }
                                    }
                                }, label: {
                                    Text("同意")
                                })
                            }
                        }
                    }, label: {
                        VStack {
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                Spacer()
                                Text("下一步")
                                    .bold()
                                Spacer()
                            }
                            Spacer()
                                .frame(height: 10)
                        }
                    })
                    .tint(.blue)
                    .buttonStyle(.borderedProminent)
                    .offset(y: nsButton1Offset)
                    .opacity(1 - Double(nsButton1Offset) / 30)
                    .animation(.easeOut(duration: 0.5), value: nsButton1Offset)
                    .padding(.horizontal, 10)
                }
                .padding()
                .onAppear {
                    welcomeToMeowbiliTextOffset = 0
                    Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
                        nsButton1Offset = 0
                    }
                }
            }
        }
    }
}
