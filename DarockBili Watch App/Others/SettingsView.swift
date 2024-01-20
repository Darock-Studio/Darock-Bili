//
//  SettingsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/5.
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

import Charts
import SwiftUI
import WatchKit
import SwiftDate
import DarockKit

struct SettingsView: View {
    var body: some View {
        AppBehaviorSettingsView()
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.large)
    }
    
    struct AppBehaviorSettingsView: View {
        var body: some View {
            List {
                Section {
                    NavigationLink(destination: {GeneralSettingsView()}, label: {
                        HStack {
                            ZStack {
                                Color.gray
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Image(systemName: "gear")
                                    .font(.system(size: 12))
                            }
                            Text("通用")
                        }
                    })
                    NavigationLink(destination: {NetworkSettingsView()}, label: {
                        HStack {
                            ZStack {
                                Color.blue
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.system(size: 12))
                            }
                            Text("以太网")
                        }
                    })
                    NavigationLink(destination: {ScreenTimeSettingsView()}, label: {
                        HStack {
                            ZStack {
                                Color.blue
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Image(systemName: "hourglass")
                                    .font(.system(size: 12))
                            }
                            Text("屏幕使用时间")
                        }
                    })
                    NavigationLink(destination: {GestureSettingsView()}, label: {
                        HStack {
                            ZStack {
                                Color.blue
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Image(systemName: "hand.wave.fill")
                                    .font(.system(size: 12))
                            }
                            Text("手势")
                        }
                    })
                    NavigationLink(destination: {BatterySettingsView()}, label: {
                        HStack {
                            ZStack {
                                Color.green
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 12))
                            }
                            Text("电池")
                        }
                    })
                    
                }
                if debug {
                    Section {
                        NavigationLink(destination: {DebugMenuView()}, label: {
                            HStack {
                                ZStack {
                                    Color.blue
                                        .frame(width: 20, height: 20)
                                        .clipShape(Circle())
                                    Image(systemName: "hammer.fill")
                                        .font(.system(size: 12))
                                }
                                Text("开发者")
                            }
                        })
                    }
                }
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.large)
        }
        
        struct GeneralSettingsView: View {
            @AppStorage("DedeUserID") var dedeUserID = ""
            @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
            @AppStorage("SESSDATA") var sessdata = ""
            @AppStorage("bili_jct") var biliJct = ""
            @State var isLogoutAlertPresented = false
            var body: some View {
                List {
                    NavigationLink(destination: {AboutView()}, label: {
                        Text("关于")
                    })
                    NavigationLink(destination: {SoftwareUpdateView()}, label: {
                        Text("软件更新")
                    })
                    NavigationLink(destination: {PlayerSettingsView()}, label: {
                        Text("播放设置")
                    })
                    NavigationLink(destination: {FeedbackView()}, label: {
                        Text("反馈问题")
                    })
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
                .navigationTitle("通用")
            }

            struct SoftwareUpdateView: View {
                @State var shouldUpdate = false
                @State var isLoading = true
                @State var latestVer = ""
                @State var latestBuild = ""
                @State var releaseNote = ""
                var body: some View {
                    ScrollView {
                        VStack {
                            if !isLoading {
                                if shouldUpdate {
                                    HStack {
                                        Image("AppIcon")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        Spacer()
                                            .frame(width: 20)
                                        VStack {
                                            Text("喵哩喵哩 v\(latestVer) Build \(latestBuild)")
                                            Text("Darock Studio")
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Text(releaseNote)
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("下载并安装")
                                    })
                                } else {
                                    Text("喵哩喵哩已是最新版本")
                                }
                            } else {
                                HStack {
                                    Text("正在检查更新...")
                                    Spacer()
                                        .frame(width: 75)
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .onAppear {
                        DarockKit.Network.shared.requestString("https://api.darock.top/bili/newver") { respStr, isSuccess in
                            if isSuccess && respStr.apiFixed().contains("|") {
                                latestVer = String(respStr.apiFixed().split(separator: "|")[0])
                                latestBuild = String(respStr.apiFixed().split(separator: "|")[1])
                                let nowMajorVer = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                                let nowBuildVer = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
                                if nowMajorVer != latestVer || Int(nowBuildVer)! < Int(latestBuild)! {
                                    shouldUpdate = true
                                }
                                isLoading = false
                            }
                        }
                    }
                }
            }
            struct PlayerSettingsView: View {
                @AppStorage("IsPlayerAutoRotating") var isPlayerAutoRotating = true
                @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
                @AppStorage("VideoGetterSource") var videoGetterSource = "official"
                var body: some View {
                    List {
                        Section {
                            Toggle("自动旋转（仅竖向）", isOn: $isPlayerAutoRotating)
                        }
                        Section {
                            Picker("记录历史记录", selection: $recordHistoryTime) {
                                Text("进入详情页时").tag("into")
                                Text("开始播放时").tag("play")
                                Text("关闭").tag("never")
                            }
                        }
                        Section(footer: Text("解析失败或无法播放视频时可尝试更换")) {
                            Picker("解析源", selection: $videoGetterSource) {
                                Text("官方").tag("official")
                                Text("第三方").tag("injahow")
                            }
                        }
                    }
                }
            }
        }
        struct NetworkSettingsView: View {
            @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
            var body: some View {
                List {
                    Section {
                        NavigationLink(destination: {NetworkFixView()}, label: {
                            Text("网络检查")
                        })
                        Toggle("自动显示网络检查", isOn: $isShowNetworkFixing)
                    }
                }
                .navigationTitle("以太网")
            }
        }
        struct ScreenTimeSettingsView: View {
            @State var screenTimes = [Int]()
            @State var mainBarData = [SingleTimeBarMarkData]()
            @State var dayAverageTime = 0 // Minutes
            var body: some View {
                List {
                    Section {
                        VStack {
                            HStack {
                                Text("日均")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            HStack {
                                Text("\(dayAverageTime)分钟")
                                    .font(.system(size: 20))
                                Spacer()
                            }
                            Chart(mainBarData) {
                                BarMark(
                                    x: .value("name", $0.name),
                                    y: .value("time", $0.time)
                                )
//                                RuleMark(
//                                    y: .value("Highlight", dayAverageTime)
//                                )
//                                .foregroundStyle(.green)
                            }
                            .chartYAxis {
                                AxisMarks(preset: .aligned, position: .trailing) { value in
                                    AxisValueLabel("\(value.index)分钟")
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd"
                    for i in 0...6 {
                        let dateStr = df.string(from: Date.now - i.days)
                        screenTimes.append(UserDefaults.standard.integer(forKey: "ScreenTime\(dateStr)"))
                        let wdf = DateFormatter()
                        wdf.dateFormat = "EEEE"
                        mainBarData.append(SingleTimeBarMarkData(name: String(wdf.string(from: Date.now - i.days).last!), time: UserDefaults.standard.integer(forKey: "ScreenTime\(dateStr)") / 60))
                    }
                    screenTimes.reverse()
                    mainBarData.reverse()
                    var totalTime = 0
                    for time in screenTimes {
                        totalTime += time / 60
                    }
                    dayAverageTime = totalTime / 7
                }
            }
            
            struct SingleTimeBarMarkData: Identifiable {
                let name: String
                let time: Int
                var id: String{ name }
            }
        }
        struct GestureSettingsView: View {
            @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
            var body: some View {
                List {
                    Section {
                        Toggle("互点两下播放/暂停视频", isOn: $isVideoPlayerGestureEnabled)
                    } footer: {
                        Text("在视频播放器使用互点两下手势(Apple Watch Series 9 及以上)或快速操作(其他机型)暂停或播放视频")
                    }
                }
                .navigationTitle("手势")
            }
        }
        struct BatterySettingsView: View {
            @State var batteryLevel = 0.0
            @State var batteryState = WKInterfaceDeviceBatteryState.unknown
            @State var isLowBatteryMode = isInLowBatteryMode
            var body: some View {
                List {
                    HStack {
                        Gauge(value: batteryLevel, in: -1...100) {
                            EmptyView()
                        }
                        .gaugeStyle(.accessoryCircularCapacity)
                        Text("\(Int(batteryLevel))%")
                            .font(.system(size: 30))
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    Toggle("低电量模式", isOn: $isLowBatteryMode)
                        .onChange(of: isLowBatteryMode) { value in
                            isInLowBatteryMode = value
                        }
                }
                .navigationTitle("电池")
                .onAppear {
                    batteryLevel = Double(WKInterfaceDevice.current().batteryLevel * 100.0)
                    batteryState = WKInterfaceDevice.current().batteryState
                    debugPrint(batteryLevel)
                }
            }
        }
        struct DebugMenuView: View {
            var body: some View {
                List {
                    NavigationLink(destination: {UserDetailView(uid: "3546572635768935")}, label: {
                        Text("LongUIDUserTest")
                    })
                    NavigationLink(destination: {BuvidFpDebug()}, label: {
                        Text("buvid_fpTest")
                    })
                    NavigationLink(destination: {UuidDebug()}, label: {
                        Text("_uuid_Gen")
                    })
                    NavigationLink(destination: {Buvid34Debug()}, label: {
                        Text("buvid3_4_actived")
                    })
                }
            }

            struct BuvidFpDebug: View {
                @State var fp = ""
                @State var resu = ""
                var body: some View {
                    List {
                        TextField("fp", text: $fp)
                        Button(action: {
                            do {
                                resu = try BuvidFp.gen(key: fp, seed: 31)
                            } catch {
                                resu = "Failed: \(error)"
                            }
                        }, label: {
                            Text("Gen")
                        })
                        Text(resu)
                    }
                }
            }
            struct UuidDebug: View {
                @State var uuid = ""
                var body: some View {
                    List {
                        Button(action: {
                            uuid = UuidInfoc.gen()
                        }, label: {
                            Text("Gen")
                        })
                        Text(uuid)
                    }
                }
            }
            struct Buvid34Debug: View {
                @State var activeBdUrl = "https://www.bilibili.com/"
                @State var locBuvid3 = ""
                @State var locBuvid4 = ""
                @State var locUplResp = ""
                var body: some View {
                    List {
                        Section {
                            Text("Current Global Buvid3: \(globalBuvid3)")
                            Text("Current Global Buvid4: \(globalBuvid4)")
                        }
                        Section {
                            TextField("activeBdUrl", text: $activeBdUrl)
                            Button(action: {
                                getBuvid(url: activeBdUrl.urlEncoded()) { buvid3, buvid4, _, resp in
                                    locBuvid3 = buvid3
                                    locBuvid4 = buvid4
                                    locUplResp = resp
                                }
                            }, label: {
                                Text("Get new & active")
                            })
                            Text(locBuvid3)
                            Text(locBuvid4)
                            Text(locUplResp)
                        }
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
