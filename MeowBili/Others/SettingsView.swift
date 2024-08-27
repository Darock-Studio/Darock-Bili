//
//
//  SettingsView.swift
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

import Charts
import SwiftUI
import SwiftDate
import DarockKit
import SDWebImageSwiftUI
import AuthenticationServices
#if os(watchOS)
import WatchKit
#else
import UserNotifications
#endif

struct SettingsView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("IsLargeSuggestionStyle") var isLargeSuggestionStyle = false
    @State var isLogoutAlertPresented = false
    var body: some View {
        List {
            #if !os(watchOS)
            Section {
                NavigationLink(destination: { NetworkSettingsView().navigationTitle("Settings.internet") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "network")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Settings.internet")
                    }
                })
            }
            Section {
                if debug {
                    NavigationLink(destination: { SoundAHapticSettingsView().navigationTitle("通知") }, label: {
                        HStack {
                            ZStack {
                                Color.red
                                    .frame(width: 26, height: 26)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "bell.badge.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            Text("通知")
                        }
                    })
                }
                NavigationLink(destination: { SoundAHapticSettingsView().navigationTitle("声音与触感") }, label: {
                    HStack {
                        ZStack {
                            Color.red
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("声音与触感")
                    }
                })
                NavigationLink(destination: { ScreenTimeSettingsView().navigationTitle("Settings.screen-time") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "hourglass")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Settings.screen-time")
                    }
                })
            }
            Section {
                NavigationLink(destination: { PlayerSettingsView().navigationTitle("Settings.player") }, label: {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "play.square")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Settings.player")
                    }
                })
                
                NavigationLink(destination: { SleepTimeView().navigationTitle("Settings.sleep") }, label: {
                    HStack {
                        ZStack {
                            Color.cyan
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "bed.double.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        Text("Settings.sleep")
                    }
                })
                NavigationLink(destination: { PrivacySettingsView().navigationTitle("隐私与安全性") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "hand.raised.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("隐私与安全性")
                    }
                })
            }
            Section {
                NavigationLink(destination: { AboutView() }, label: {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "info")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Settings.about")
                    }
                })
                if debug {
                    Section {
                        NavigationLink(destination: { DebugMenuView().navigationTitle("Settings.debug") }, label: {
                            HStack {
                                ZStack {
                                    Color.blue
                                        .frame(width: 26, height: 26)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    Image(systemName: "hammer.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                                Text("Settings.developer")
                            }
                        })
                    }
                }
            }
            Section {
                if !sessdata.isEmpty {
                    NavigationLink(destination: { SwitchAccountView() }, label: {
                        HStack {
                            ZStack {
                                Color.gray
                                    .frame(width: 26, height: 26)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            Text("切换账号")
                        }
                    })
                    Button(role: .destructive, action: {
                        isLogoutAlertPresented = true
                    }, label: {
                        HStack {
                            ZStack {
                                Color.gray
                                    .frame(width: 26, height: 26)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            Text("退出登录")
                        }
                    })
                    .buttonBorderShape(.roundedRectangle(radius: 13))
                    .alert("Settings.log-out", isPresented: $isLogoutAlertPresented, actions: {
                        Button(role: .destructive, action: {
                            dedeUserID = ""
                            dedeUserID__ckMd5 = ""
                            sessdata = ""
                            biliJct = ""
                        }, label: {
                            HStack {
                                Text("Settings.log-out.confirm")
                                Spacer()
                            }
                        })
                    }, message: {
                        Text("Settings.log-out.message")
                    })
                }
            }
            #else
            Section {
                NavigationLink(destination: { PlayerSettingsView().navigationTitle("Settings.player") }, label: {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "play.circle")
                                .font(.system(size: 12))
                        }
                        Text("Settings.player")
                    }
                })
                NavigationLink(destination: { KeyboardSettingsView().navigationTitle("键盘") }, label: {
                    HStack {
                        ZStack {
                            Color.secondary
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "keyboard")
                                .font(.system(size: 12))
                        }
                        Text("键盘")
                    }
                })
                NavigationLink(destination: { SuggestionViewSettingsView().navigationTitle("推荐视图") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: isLargeSuggestionStyle ? "text.below.photo" : "rectangle.grid.1x2")
                                .font(.system(size: isLargeSuggestionStyle ? 10 : 12))
                        }
                        Text("推荐视图")
                    }
                })
                NavigationLink(destination: { NetworkSettingsView().navigationTitle("Settings.internet") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "network")
                                .font(.system(size: 12))
                        }
                        Text("Settings.internet")
                    }
                })
                NavigationLink(destination: { GestureSettingsView().navigationTitle("Settings.gesture") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(privateSystemName: "hand.side.pinch.fill")
                                .scaleEffect(0.7)
                        }
                        Text("Settings.gesture")
                    }
                })
                NavigationLink(destination: { ScreenTimeSettingsView().navigationTitle("Settings.screen-time") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "hourglass")
                                .font(.system(size: 12))
                        }
                        Text("Settings.screen-time")
                    }
                })
                NavigationLink(destination: { AccessibilitySettingsView().navigationTitle("辅助功能") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "accessibility")
                                .font(.system(size: 18))
                        }
                        Text("辅助功能")
                    }
                })
                NavigationLink(destination: { StorageSettingsView().navigationTitle("储存空间") }, label: {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "externaldrive.fill")
                                .font(.system(size: 12))
                        }
                        Text("储存空间")
                    }
                })
                NavigationLink(destination: { BatterySettingsView().navigationTitle("Settings.battery") }, label: {
                    HStack {
                        ZStack {
                            Color.green
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 12))
                        }
                        Text("Settings.battery")
                    }
                })
                NavigationLink(destination: { SleepTimeView().navigationTitle("Settings.sleep") }, label: {
                    HStack {
                        ZStack {
                            Color.cyan
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "bed.double.fill")
                                .font(.system(size: 11))
                        }
                        Text("Settings.sleep")
                    }
                })
                NavigationLink(destination: { PrivacySettingsView().navigationTitle("隐私与安全性") }, label: {
                    HStack {
                        ZStack {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "hand.raised.fill")
                                .font(.system(size: 12))
                        }
                        Text("隐私与安全性")
                    }
                })
            }
            Section {
                NavigationLink(destination: { AboutView() }, label: {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "info")
                                .font(.system(size: 12))
                        }
                        Text("Settings.about")
                    }
                })
                if (Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String) == "com.darock.DarockBili.watchkitapp" {
                    NavigationLink(destination: { SoftwareUpdateView().navigationTitle("Settings.update") }, label: {
                        HStack {
                            ZStack {
                                Color.gray
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 12))
                            }
                            Text("Settings.update")
                        }
                    })
                }
                if debug {
                    Section {
                        NavigationLink(destination: { DebugMenuView().navigationTitle("Settings.debug") }, label: {
                            HStack {
                                ZStack {
                                    Color.blue
                                        .frame(width: 20, height: 20)
                                        .clipShape(Circle())
                                    Image(systemName: "hammer.fill")
                                        .font(.system(size: 12))
                                }
                                Text("Settings.developer")
                            }
                        })
                    }
                }
                if !sessdata.isEmpty {
                    Button(role: .destructive, action: {
                        isLogoutAlertPresented = true
                    }, label: {
                        HStack {
                            Text("Settings.log-out")
                        }
                    })
                    .buttonBorderShape(.roundedRectangle(radius: 13))
                    .alert("Settings.log-out", isPresented: $isLogoutAlertPresented, actions: {
                        Button(role: .destructive, action: {
                            dedeUserID = ""
                            dedeUserID__ckMd5 = ""
                            sessdata = ""
                            biliJct = ""
                        }, label: {
                            HStack {
                                Text("Settings.log-out.confirm")
                                Spacer()
                            }
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("Settings.log-out.cancel")
                        })
                    }, message: {
                        Text("Settings.log-out.message")
                    })
                }
            }
            #endif
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct PlayerSettingsView: View {
    @AppStorage("VideoGetterSource") var videoGetterSource = "official"
    @AppStorage("IsShowNormalDanmaku") var isShowNormalDanmaku = true
    @AppStorage("IsShowTopDanmaku") var isShowTopDanmaku = true
    @AppStorage("IsShowBottomDanmaku") var isShowBottomDanmaku = true
    #if os(watchOS)
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("ExternalSound") var ExternalSound = false
    #else
    @AppStorage("IsRecordHistory") var isRecordHistory = true
    #endif
    var body: some View {
        List {
            Section {
                #if !os(watchOS)
                Toggle("记录历史记录", isOn: $isRecordHistory)
                #else
                Picker("Player.record-history", selection: $recordHistoryTime) {
                    Text("Player.record-history.when-entering-page").tag("into")
                    Text("Player.record-history.when-video-plays").tag("play")
                    Text("Player.record-history.never").tag("never")
                }
                #endif
            }
            Section(footer: Text("Player.analyzying-source.description")) {
                Picker("Player.analyzying-source", selection: $videoGetterSource) {
                    Text("Player.analyzying-source.offical").tag("official")
                    Text("Player.analyzying-source.third-party").tag("injahow")
                }
            }
            Section {
                Toggle("显示普通弹幕", isOn: $isShowNormalDanmaku)
                Toggle("显示顶部弹幕", isOn: $isShowTopDanmaku)
                Toggle("显示底部弹幕", isOn: $isShowBottomDanmaku)
            } header: {
                Text("弹幕")
            }
            #if !os(watchOS)
            Section {
                Toggle("声音外放", isOn: $ExternalSound)
            } header: {
                Text("声音")
            }
            #endif
        }
    }
}

struct KeyboardSettingsView: View {
    @AppStorage("IsUseExtKeyboard") var isUseExtKeyboard = false
    var body: some View {
        List {
            Section {
                Toggle("使用第三方全键盘", isOn: $isUseExtKeyboard)
            } footer: {
                VStack(alignment: .leading) {
                    Text("不支持全键盘的 Apple Watch 可通过打开此开关以使用第三方的全键盘")
                    Text("Powered by Cepheus")
                }
            }
        }
    }
}

struct SuggestionViewSettingsView: View {
    @AppStorage("IsLargeSuggestionStyle") var isLargeSuggestionStyle = false
    var body: some View {
        List {
            Picker("推荐视图样式", selection: $isLargeSuggestionStyle) {
                Label("列表视图", systemImage: "rectangle.grid.1x2").tag(false)
                Label("大图视图", systemImage: "text.below.photo").tag(true)
            }
            .pickerStyle(.inline)
        }
    }
}

struct NetworkSettingsView: View {
    @AppStorage("IsShowVideoSuggestionsFromDarock") var isShowVideoSuggestionsFromDarock = true
    @AppStorage("IsShowHotsInSearch") var isShowHotsInSearch = true
    @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
    var body: some View {
        List {
            Section {
                Toggle("在搜索页显示热搜", isOn: $isShowHotsInSearch)
                Toggle("显示来自 Darock 的推荐", isOn: $isShowVideoSuggestionsFromDarock)
            }
            Section {
                NavigationLink(destination: { NetworkFixView() }, label: {
                    Text("Troubleshoot")
                })
                Toggle("Troubleshoot.auto-pop-up", isOn: $isShowNetworkFixing)
            }
        }
    }
}

#if !os(watchOS)
struct NotificationSettingsView: View {
    @AppStorage("IsNotificationEnabled") var isNotificationEnabled = false
    var body: some View {
        List {
            Section {
                Toggle("启用通知", isOn: $isNotificationEnabled)
                    .onChange(of: isNotificationEnabled) { value in
                        if value {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGrand, _ in
                                DispatchQueue.main.async {
                                    if !isGrand {
                                        isNotificationEnabled = false
                                    }
                                }
                            }
                        }
                    }
            }
            if isNotificationEnabled {
                
            }
        }
    }
}
#endif

struct SoundAHapticSettingsView: View {
    @AppStorage("IsUseExtHaptic") var isUseExtHaptic = true
    var body: some View {
        List {
            Section {
                Toggle("扩展的触感反馈", isOn: $isUseExtHaptic)
            } header: {
                Text("触感")
            }
        }
    }
}

struct ScreenTimeSettingsView: View {
    @AppStorage("IsScreenTimeEnabled") var isScreenTimeEnabled = true
    @State var screenTimes = [Int]()
    @State var mainBarData = [SingleTimeBarMarkData]()
    @State var dayAverageTime = 0 // Minutes
    var body: some View {
        List {
            if isScreenTimeEnabled {
                Section {
                    VStack {
                        HStack {
                            Text("Screen-time.daily-average")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        HStack {
                            Text("Screen-time.minutes.\(dayAverageTime)")
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
                                AxisValueLabel("Screen-time.minutes.\(value.index)")
                            }
                        }
                    }
                }
                Section {
                    Button(role: .destructive, action: {
                        isScreenTimeEnabled = false
                    }, label: {
                        Text("Screen-time.off")
                    })
                } footer: {
                    Text("Screen-time.description")
                }
            } else {
                Section {
                    Button(action: {
                        isScreenTimeEnabled = true
                    }, label: {
                        Text("Screen-time.on")
                    })
                } footer: {
                    Text("Screen-time.usage")
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
        var id: String { name }
    }
}

struct AccessibilitySettingsView: View {
    @AppStorage("IsReduceBrightness") var isReduceBrightness = false
    @AppStorage("ReduceBrightnessPercent") var reduceBrightnessPercent = 0.1
    var body: some View {
        List {
            Section {
                Toggle("降低亮度", isOn: $isReduceBrightness)
                if isReduceBrightness {
                    Slider(value: $reduceBrightnessPercent, in: 0.0...0.8, step: 0.05)
                }
            }
        }
    }
}

struct StorageSettingsView: View {
    @State var isLoading = true
    @State var docSize: UInt64 = 0
    @State var tmpSize: UInt64 = 0
    @State var bundleSize: UInt64 = 0
    @State var isClearingCache = false
    @State var videoMetadatas = [[String: String]]()
    @State var vRootPath = ""
    var body: some View {
        Form {
            List {
                if !isLoading {
                    Section {
                        VStack {
                            HStack {
                                Text("已使用 \(bytesToMegabytes(bytes: docSize + tmpSize + bundleSize) ~ 2) MB")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            Chart {
                                BarMark(x: .value("", bundleSize))
                                    .foregroundStyle(by: .value("", "Gray"))
                                BarMark(x: .value("", docSize))
                                    .foregroundStyle(by: .value("", "Purple"))
                                BarMark(x: .value("", tmpSize))
                                    .foregroundStyle(by: .value("", "Primary"))
                            }
                            .chartForegroundStyleScale(["Gray": .gray, "Purple": .purple, "Primary": .primary, "Secondary": Color(hex: 0x333333)])
                            .chartXAxis(.hidden)
                            .chartLegend(.hidden)
                            .cornerRadius(2)
                            .frame(height: 15)
                            .padding(.vertical, 2)
                            Group {
                                HStack {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 10, height: 10)
                                    Text("喵哩喵哩")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                HStack {
                                    Circle()
                                        .fill(Color.purple)
                                        .frame(width: 10, height: 10)
                                    Text("媒体")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                HStack {
                                    Circle()
                                        .fill(Color.primary)
                                        .frame(width: 10, height: 10)
                                    Text("缓存数据")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                            .padding(.vertical, -1)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    if !videoMetadatas.isEmpty {
                        Section {
                            ForEach(0..<videoMetadatas.count, id: \.self) { i in
                                if videoMetadatas[i]["notGet"] == nil {
                                    HStack {
                                        WebImage(url: URL(string: videoMetadatas[i]["Pic"]! + "@100w")!, options: [.progressiveLoad])
                                            .placeholder {
                                                RoundedRectangle(cornerRadius: 7)
                                                    .frame(width: 50, height: 30)
                                                    .foregroundColor(Color(hex: 0x3D3D3D))
                                                    .redacted(reason: .placeholder)
                                            }
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .cornerRadius(5)
                                        Spacer()
                                            .frame(width: 5)
                                        VStack {
                                            HStack {
                                                Text(videoMetadatas[i]["Title"]!)
                                                    .font(.system(size: 13, weight: .bold))
                                                    .lineLimit(2)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("\(bytesToMegabytes(bytes: UInt64(videoMetadatas[i]["Size"] ?? "0") ?? 0) ~ 2) MB")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                        }
                                    }
                                    .swipeActions {
                                        Button(role: .destructive, action: {
                                            try! FileManager.default.removeItem(atPath: vRootPath + videoMetadatas[i]["Path"]!)
                                        }, label: {
                                            Image(systemName: "xmark.bin.fill")
                                        })
                                    }
                                }
                            }
                        } header: {
                            Text("媒体")
                        }
                    }
                    Section {
                        NavigationLink(destination: {
                            List {
                                Section {
                                    HStack {
                                        Image("AppIconImage")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .clipShape(Circle())
                                        Spacer()
                                            .frame(width: 5)
                                        VStack {
                                            HStack {
                                                Text("喵哩喵哩 (\(String(try! String(contentsOf: Bundle.main.url(forResource: "SemanticVersion", withExtension: "drkdatas")!).split(separator: "\n")[0])))")
                                                Spacer()
                                            }
                                            HStack {
                                                Text("\(bytesToMegabytes(bytes: bundleSize) ~ 2) MB")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                            HStack {
                                                Text("Darock Studio")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }, label: {
                            HStack {
                                Image("AppIconImage")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                Spacer()
                                    .frame(width: 5)
                                VStack {
                                    HStack {
                                        Text("喵哩喵哩 (\(String(try! String(contentsOf: Bundle.main.url(forResource: "SemanticVersion", withExtension: "drkdatas")!).split(separator: "\n")[0])))")
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(bytesToMegabytes(bytes: bundleSize) ~ 2) MB")
                                            .font(.system(size: 15))
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                }
                            }
                        })
                        if bytesToMegabytes(bytes: tmpSize) > 0.2 {
                            NavigationLink(destination: {
                                List {
                                    Section {
                                        HStack {
                                            ZStack {
                                                Color.gray
                                                    .frame(width: 20, height: 20)
                                                    .clipShape(Circle())
                                                Image(systemName: "ellipsis.circle")
                                                    .font(.system(size: 12))
                                            }
                                            Spacer()
                                                .frame(width: 5)
                                            VStack {
                                                HStack {
                                                    Text("缓存数据")
                                                    Spacer()
                                                }
                                                HStack {
                                                    Text("\(bytesToMegabytes(bytes: tmpSize) ~ 2) MB")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(.gray)
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                    Section {
                                        if !isClearingCache {
                                            Button(action: {
                                                DispatchQueue(label: "com.darock.DarockBili.storage-clear-cache", qos: .userInitiated).async {
                                                    do {
                                                        isClearingCache = true
                                                        let filePaths = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
                                                        for filePath in filePaths {
                                                            let fullPath = (NSTemporaryDirectory() as NSString).appendingPathComponent(filePath)
                                                            try FileManager.default.removeItem(atPath: fullPath)
                                                        }
                                                        isClearingCache = false
                                                    } catch {
                                                        print(error)
                                                    }
                                                }
                                            }, label: {
                                                Text("清除缓存")
                                            })
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                }
                            }, label: {
                                HStack {
                                    ZStack {
                                        Color.gray
                                            .frame(width: 20, height: 20)
                                            .clipShape(Circle())
                                        Image(systemName: "ellipsis.circle")
                                            .font(.system(size: 12))
                                    }
                                    Spacer()
                                        .frame(width: 5)
                                    VStack {
                                        HStack {
                                            Text("缓存数据")
                                            Spacer()
                                        }
                                        HStack {
                                            Text("\(bytesToMegabytes(bytes: tmpSize) ~ 2) MB")
                                                .font(.system(size: 15))
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
                                    }
                                }
                            })
                        }
                    }
                } else {
                    HStack {
                        Text("正在载入")
                        Spacer()
                        ProgressView()
                    }
                    .listRowBackground(Color.clear)
                }
            }
        }
        .onAppear {
            if isLoading {
                DispatchQueue(label: "com.darock.DarockBili.storage-load", qos: .userInitiated).async {
                    // Size counting
                    docSize = folderSize(atPath: NSHomeDirectory() + "/Documents") ?? 0
                    tmpSize = folderSize(atPath: NSTemporaryDirectory()) ?? 0
                    bundleSize = folderSize(atPath: Bundle.main.bundlePath) ?? 0
                    // Video sizes
                    vRootPath = String(AppFileManager(path: "dlds").GetPath("").path)
                    let files = AppFileManager(path: "dlds").GetRoot() ?? [[String: String]]()
                    for file in files {
                        debugPrint(file)
                        if !Bool(file["isDirectory"]!)! {
                            let name = file["name"]!
                            let nameWithOutSuffix = String(name.split(separator: ".")[0])
                            if UserDefaults.standard.dictionary(forKey: nameWithOutSuffix) != nil {
                                var dicV = UserDefaults.standard.dictionary(forKey: nameWithOutSuffix)! as! [String: String]
                                if let p = dicV["Path"] {
                                    if p.contains("/") {
                                        dicV.updateValue(String(p.split(separator: "/").last!), forKey: "Path")
                                        do {
                                            let attributes = try FileManager.default.attributesOfItem(atPath: "\(vRootPath)\(String(p.split(separator: "/").last!))")
                                            if let fileSize = attributes[.size] as? UInt64 {
                                                dicV.updateValue(String(fileSize), forKey: "Size")
                                            }
                                        } catch {
                                            print("Error: \(error)")
                                        }
                                    }
                                }
                                videoMetadatas.append(dicV)
                            } else {
                                videoMetadatas.append(["notGet": "true"])
                            }
                        }
                    }
                    videoMetadatas.sort { UInt64($0["Size"] ?? "0")! > UInt64($1["Size"] ?? "0")! }
                    
                    isLoading = false
                }
            }
        }
    }
    
    func folderSize(atPath path: String) -> UInt64? {
        let fileManager = FileManager.default
        guard let files = fileManager.enumerator(atPath: path) else {
            return nil
        }
        
        var totalSize: UInt64 = 0
        
        for case let file as String in files {
            let filePath = "\(path)/\(file)"
            do {
                let attributes = try fileManager.attributesOfItem(atPath: filePath)
                if let fileSize = attributes[.size] as? UInt64 {
                    totalSize += fileSize
                }
            } catch {
                print("Error: \(error)")
            }
        }
        
        return totalSize
    }
    func bytesToMegabytes(bytes: UInt64) -> Double {
        let megabytes = Double(bytes) / (1024 * 1024)
        return megabytes
    }
}

struct SleepTimeView: View {
    @AppStorage("isSleepNotificationOn") var isSleepNotificationOn = false
    @AppStorage("notifyHour") var notifyHour = 0
    @AppStorage("notifyMinute") var notifyMinute = 0
    @State var currentHour = 0
    @State var currentMinute = 0
    @State var currentSecond = 0
    @State var isEditingTime = false
    var body: some View {
        List {
            Section(content: {
                Toggle(isOn: $isSleepNotificationOn, label: {
                    Text("Sleep")
                })
                if isSleepNotificationOn {
                    Button(action: {
                        isEditingTime = true
                    }, label: {
                        Text("Sleep.edit.\(notifyHour<10 ? "0\(notifyHour)" : "\(notifyHour)").\(notifyMinute<10 ? "0\(notifyMinute)" : "\(notifyMinute)")")
                    })
                }
            }, footer: {
                Text("Sleep.discription")
            })
            Section {
                Text("Sleep.current.\(currentHour<10 ? "0\(currentHour)" : "\(currentHour)").\(currentMinute<10 ? "0\(currentMinute)" : "\(currentMinute)").\(currentSecond<10 ? "0\(currentSecond)" : "\(currentSecond)")")
            }
        }
        .navigationTitle("Sleep")
        .onAppear {
            let timer = Timer(timeInterval: 0.5, repeats: true) { _ in
                currentHour = getCurrentTime().hour
                currentMinute = getCurrentTime().minute
                currentSecond = getCurrentTime().second
            }
            RunLoop.current.add(timer, forMode: .default)
            timer.fire()
        }
        .sheet(isPresented: $isEditingTime, content: {
            VStack {
                Text("Sleep.edit.title")
                    .bold()
                HStack {
                    Picker("Sleep.edit.hour", selection: $notifyHour) {
                        ForEach(0..<24) { index in
                            Text("\(index<10 ? "0\(index)" : "\(index)")").tag(index)
                        }
                    }
                    Text(":")
                    Picker("Sleep.edit.minute", selection: $notifyMinute) {
                        ForEach(0..<60) { index in
                            Text("\(index<10 ? "0\(index)" : "\(index)")").tag(index)
                        }
                    }
                }
            }
        })
    }
}

struct Time {
    var hour: Int
    var minute: Int
    var second: Int
}

func getCurrentTime() -> Time {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
    let currentTime = Time(hour: components.hour ?? 0, minute: components.minute ?? 0, second: components.second ?? 0)
    return currentTime
}

struct DebugMenuView: View {
    var body: some View {
        List {
            NavigationLink(destination: { UserDetailView(uid: "3546572635768935") }, label: {
                Text("LongUIDUserTest")
            })
            NavigationLink(destination: { BuvidFpDebug() }, label: {
                Text("buvid_fpTest")
            })
            NavigationLink(destination: { UuidDebug() }, label: {
                Text("_uuid_Gen")
            })
            NavigationLink(destination: { Buvid34Debug() }, label: {
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

struct PrivacySettingsView: View {
    @AppStorage("BlurWhenScreenSleep") var blurWhenScreenSleep = false
    var body: some View {
        List {
            #if os(watchOS)
            Toggle("垂下手腕时隐藏内容", isOn: $blurWhenScreenSleep)
            #endif
            Section {
                NavigationLink(destination: { FileLocker() }, label: {
                    Text("文件保险箱")
                })
            }
        }
    }
    
    struct FileLocker: View {
        @State var isFileLockerEnabled = false
        @State var isSetPasswdPresented = false
        @State var passwdInput = ""
        @State var gendRecCode = ""
        @State var encryptProgress = 0.0
        @State var isFinishedEncrypt = false
        var body: some View {
            List {
                Section {
                    Toggle("文件保险箱", isOn: $isFileLockerEnabled)
                        .onChange(of: isFileLockerEnabled) { value in
                            if value && UserDefaults.standard.string(forKey: "FileLockerPassword") == nil {
                                isSetPasswdPresented = true
                            } else if !value {
                                isFileLockerEnabled = false
                                UserDefaults.standard.removeObject(forKey: "FileLockerPassword")
                                UserDefaults.standard.removeObject(forKey: "FileLockerRecoverCode")
                            }
                        }
                }
                if encryptProgress > 0.0 && !isFinishedEncrypt {
                    Section {
                        VStack {
                            Text("正在加密...")
                                .bold()
                            ProgressView(value: encryptProgress)
                                .tint(Color.blue)
                                .frame(height: 15)
                        }
                    }
                }
                Section {
                    Text("""
                    文件保险箱通过对喵哩喵哩进行加密来保护 App 内的数据。
                    
                    警告：你将需要密码或恢复密钥才能访问数据。在此设置过程中，会自动生成恢复密钥。如果同时忘记了密码和恢复密钥，数据将会丢失。
                    
                    已\(isFileLockerEnabled ? "启用" : "停用")喵哩喵哩的文件保险箱。\(isFileLockerEnabled ? "\n恢复密钥已设置。" : "")
                    """)
                    .font(.system(size: 12))
                }
            }
            .onAppear {
                if UserDefaults.standard.string(forKey: "FileLockerPassword") != nil {
                    isFileLockerEnabled = true
                }
            }
            .sheet(isPresented: $isSetPasswdPresented, onDismiss: {
                if UserDefaults.standard.string(forKey: "FileLockerPassword") != nil {
                    encryptProgress += 0.01
                    isFileLockerEnabled = true
                    Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { timer in
                        encryptProgress += Double.random(in: 0.1...0.3)
                        if encryptProgress >= 1.0 {
                            isFinishedEncrypt = true
                            timer.invalidate()
                        }
                    }
                } else {
                    isFileLockerEnabled = false
                }
            }, content: {
                NavigationStack {
                    List {
                        Section {
                            SecureField("密码", text: $passwdInput)
                        }
                        Section {
                            NavigationLink(destination: {
                                ScrollView {
                                    VStack {
                                        Text("恢复密钥")
                                            .font(.title3)
                                        Text(gendRecCode)
                                            .font(.system(size: 14, weight: .bold).monospaced())
                                        Text("请将恢复密钥保存到安全的位置")
                                            .font(.system(size: 12))
                                        Button(action: {
                                            UserDefaults.standard.set(passwdInput, forKey: "FileLockerPassword")
                                            UserDefaults.standard.set(gendRecCode, forKey: "FileLockerRecoverCode")
                                            isSetPasswdPresented = false
                                        }, label: {
                                            Label("完成", systemImage: "checkmark")
                                        })
                                    }
                                }
                                .onAppear {
                                    gendRecCode = String(UuidInfoc.gen().dropLast(5))
                                }
                            }, label: {
                                Text("下一步")
                            })
                        }
                    }
                }
            })
        }
    }
}

#if os(watchOS)
struct SoftwareUpdateView: View {
    @State var shouldUpdate = false
    @State var isLoading = true
    @State var isFailed = false
    @State var latestVer = ""
    @State var latestBuild = ""
    @State var releaseNote = ""
    var body: some View {
        ScrollView {
            VStack {
                if !isLoading {
                    if shouldUpdate {
                        HStack {
                            Spacer()
                                .frame(width: 10)
                            Image("AppIconImage")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                            Spacer()
                                .frame(width: 10)
                            VStack {
                                Text("v\(latestVer) Build \(latestBuild)")
                                    .font(.system(size: 14, weight: .medium))
                                HStack {
                                    Text("Darock-studio")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                        }
                        Divider()
                        Text(releaseNote)
                        Button(action: {
                            let session = ASWebAuthenticationSession(url: URL(string: "https://cd.darock.top:32767/meowbili/install.html")!, callbackURLScheme: "mlhd") { _, _ in
                                return
                            }
                            session.prefersEphemeralWebBrowserSession = true
                            session.start()
                        }, label: {
                            Text("Update.download-and-install")
                        })
                    } else if isFailed {
                        Text("Update.error")
                    } else {
                        Text("Update.latest")
                    }
                } else {
                    HStack {
                        Text("Update.checking")
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .frame(width: 130)
                        Spacer()
                            .frame(maxWidth: .infinity)
                        ProgressView()
                    }
                }
            }
        }
        .onAppear {
            DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/bili/newver") { respStr, isSuccess in
                if isSuccess && respStr.apiFixed().contains("|") {
                    latestVer = String(respStr.apiFixed().split(separator: "|")[0])
                    latestBuild = String(respStr.apiFixed().split(separator: "|")[1])
                    let nowMajorVer = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                    let nowBuildVer = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
                    if nowMajorVer != latestVer || Int(nowBuildVer)! < Int(latestBuild)! {
                        shouldUpdate = true
                    }
                    DarockKit.Network.shared.requestString("https://fapi.darock.top:65535/bili/newver/note") { respStr, isSuccess in
                        if isSuccess {
                            releaseNote = respStr.apiFixed()
                            isLoading = false
                        } else {
                            isFailed = true
                        }
                    }
                } else {
                    isFailed = true
                }
            }
        }
    }
}

struct GestureSettingsView: View {
    @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
    @AppStorage("VideoPlayerGestureBehavior") var videoPlayerGestureBehavior = "Play/Pause"
    var body: some View {
        List {
            Section {
                Toggle("Gesture.double-tap", isOn: $isVideoPlayerGestureEnabled)
            } footer: {
                Text("Gesture.double-tap.description")
            }
            if isVideoPlayerGestureEnabled {
                Section {
                    Picker("行为", selection: $videoPlayerGestureBehavior) {
                        Text("播放/暂停").tag("Play/Pause")
                        Text("暂停->退出").tag("Pause/Exit")
                        Text("退出播放").tag("Exit")
                        Text("退出 App").tag("Exit App")
                    }
                }
            }
        }
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
            Toggle("Battery.low-power-mode", isOn: $isLowBatteryMode)
                .onChange(of: isLowBatteryMode) { value in
                    isInLowBatteryMode = value
                }
        }
        .onAppear {
            batteryLevel = Double(WKInterfaceDevice.current().batteryLevel * 100.0)
            batteryState = WKInterfaceDevice.current().batteryState
            debugPrint(batteryLevel)
        }
    }
}
#endif

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
