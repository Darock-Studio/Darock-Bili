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
import Alamofire
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
                NavigationLink(destination: { FeedbackView().navigationTitle("Settings.feedback") }, label: {
                    HStack {
                        ZStack {
                            Color.purple
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "exclamationmark")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Settings.feedback")
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
                NavigationLink(destination: { SoftwareUpdateView() }, label: {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 26, height: 26)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        Text("Settings.update")
                    }
                })
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
                            Image(systemName: "hand.wave.fill")
                                .font(.system(size: 12))
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
                                .font(.system(size: 12))
                        }
                        Text("Settings.sleep")
                    }
                })
                NavigationLink(destination: { FeedbackView().navigationTitle("Settings.feedback") }, label: {
                    HStack {
                        ZStack {
                            Color.purple
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Image(systemName: "exclamationmark")
                                .font(.system(size: 12))
                        }
                        Text("Settings.feedback")
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
        }
    }
}

struct NetworkSettingsView: View {
    @AppStorage("IsShowNetworkFixing") var isShowNetworkFixing = true
    var body: some View {
        List {
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
    var body: some View {
        List {
            Section {
                NavigationLink(destination: { AnalyzeAImprove() }, label: {
                    Text("分析与改进")
                })
            }
            Section {
                NavigationLink(destination: { FileLocker() }, label: {
                    Text("文件保险箱")
                })
            }
        }
    }
    
    struct AnalyzeAImprove: View {
        @AppStorage("IsAllowMixpanel") var isAllowMixpanel = true
        var body: some View {
            List {
                Section {
                    Toggle("允许收集使用信息", isOn: $isAllowMixpanel)
                } footer: {
                    Text("喵哩喵哩收集使用信息仅用以帮助改进质量，不会用于广告、个人画像之类，收集的信息不会关联到个人。此更改立即生效，不会影响哔哩哔哩官方对您的数据收集。")
                }
                Section {
                    Link("喵哩喵哩开源页", destination: URL(string: "https://github.com/Darock-Studio/Darock-Bili")!)
                } footer: {
                    Text("喵哩喵哩为完整开源项目，欢迎检查代码以确认无隐私问题")
                }
            }
            .navigationTitle("分析与改进")
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

struct SoftwareUpdateView: View {
    @State var shouldUpdate = false
    @State var shouldUpdateLib = false
    @State var isLoading = true
    @State var isFailed = false
    @State var latestVer = ""
    @State var latestBuild = ""
    @State var releaseNote = ""
    @State var latestLibVer = ""
    @State var libReleaseNote = ""
    @State var isDownloadingRes = false
    @State var downloadProgress = 0.0
    @State var downloadedSize: Int64 = 0
    @State var totalSize: Int64 = 0
    @State var isCanInstall = {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("mainnew.dylib")
        return FileManager.default.fileExists(atPath: fileURL.path())
    }()
    @State var isFinishedInstall = false
    var body: some View {
        List {
            if !isLoading {
                Section {
                    if shouldUpdateLib {
                        HStack {
                            Image("AppIconImage")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                            VStack {
                                Text("资源包 v\(latestLibVer)")
                                    .font(.system(size: 14, weight: .medium))
                                HStack {
                                    Text("Darock-studio")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                        }
                        Group {
                            Divider()
                            Text(libReleaseNote)
                        }
                        .listRowBackground(Color.clear)
                        if !isCanInstall {
                            if !isDownloadingRes {
                                Button(action: {
                                    isDownloadingRes = true
                                    let destination: DownloadRequest.Destination = { _, _ in
                                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                        let fileURL = documentsURL.appendingPathComponent("mainnew.dylib")
                                        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                                    }
#if targetEnvironment(simulator)
#if os(watchOS)
                                    let link = "https://cd.darock.top:32767/meowbili/res/dylib/watchsimulator.dylib"
#elseif os(iOS)
                                    let link = "https://cd.darock.top:32767/meowbili/res/dylib/iphonesimulator.dylib"
#endif
#else
#if os(watchOS)
                                    let link = "https://cd.darock.top:32767/meowbili/res/dylib/watchos.dylib"
#elseif os(iOS)
                                    let link = "https://cd.darock.top:32767/meowbili/res/dylib/iphoneos.dylib"
#endif
#endif
                                    AF.download(link, to: destination)
                                        .downloadProgress { p in
                                            downloadProgress = p.fractionCompleted
                                            downloadedSize = p.completedUnitCount
                                            totalSize = p.totalUnitCount
                                        }
                                        .response { r in
                                            if r.error == nil, let filePath = r.fileURL?.path {
                                                debugPrint(filePath)
                                                isCanInstall = true
                                            } else {
                                                debugPrint(r.error as Any)
                                            }
                                        }
                                }, label: {
                                    Text("下载并安装")
                                })
                            } else {
                                VStack {
                                    ProgressView(value: downloadProgress)
                                    HStack {
                                        Spacer()
                                        Text("\(String(format: "%.2f", downloadProgress * 100) + " %")")
                                        Spacer()
                                    }
                                    HStack {
                                        Spacer()
                                        Text("\(String(format: "%.2f", Double(downloadedSize) / 1024 / 1024))MB / \(String(format: "%.2f", Double(totalSize) / 1024 / 1024))MB")
                                            .font(.system(size: 16))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                        Spacer()
                                    }
                                }
                                .listRowBackground(Color.clear)
                            }
                        } else {
                            NavigationLink(destination: {
                                if !isFinishedInstall {
                                    ZStack {
                                        Color.black
                                            .ignoresSafeArea()
                                        VStack {
                                            Image("AppIconImage")
                                                .resizable()
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                            ProgressView()
                                                .padding(3)
                                        }
                                    }
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden()
                                    .onAppear {
                                        let fileManager = FileManager.default
                                        let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                        let mainDylibPath = documentsDirectory.appendingPathComponent("main.dylib")
                                        let mainNewDylibPath = documentsDirectory.appendingPathComponent("mainnew.dylib")
                                        do {
                                            try fileManager.removeItem(at: mainDylibPath)
                                            try fileManager.moveItem(at: mainNewDylibPath, to: mainDylibPath)
                                            sleep(2)
                                            isFinishedInstall = true
                                        } catch {
                                            print("错误：\(error)")
                                        }
                                    }
                                } else {
                                    List {
                                        Section {
                                            Text("已完成更新")
                                            Text("需要重启喵哩喵哩以应用")
                                        }
                                        Section {
                                            Button(action: {
                                                exit(0)
                                            }, label: {
                                                Text("退出")
                                            })
                                        }
                                    }
                                }
                            }, label: {
                                Text("安装")
                            })
                        }
                    } else if !isFailed {
                        Text("喵哩喵哩资源包已是最新版本")
                    }
                }
                Section {
                    if shouldUpdate {
                        VStack {
                            HStack {
                                Image("AppIconImage")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(8)
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
                            Text("Update.install-by-testflight")
                                .bold()
                        }
                    } else if isFailed {
                        Text("Update.error")
                    } else {
                        Text("喵哩喵哩 App 已是最新版本")
                    }
                }
            } else {
                HStack {
                    Text("Update.checking")
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    ProgressView()
                }
                .listRowBackground(Color.clear)
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
                    DarockKit.Network.shared.requestString("https://api.darock.top/bili/newver/note") { respStr, isSuccess in
                        if isSuccess {
                            releaseNote = respStr.apiFixed()
                        } else {
                            isFailed = true
                        }
                    }
                } else {
                    isFailed = true
                }
            }
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/libnewver") { respStr, isSuccess in
                if isSuccess {
                    latestLibVer = respStr.apiFixed()
                    if DKDynamic().GetDylibVersion() != latestLibVer {
                        shouldUpdateLib = true
                    }
                    DarockKit.Network.shared.requestString("https://api.darock.top/bili/libnewver/note") { respStr, isSuccess in
                        if isSuccess {
                            libReleaseNote = respStr.apiFixed()
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

#if os(watchOS)
struct GestureSettingsView: View {
    @AppStorage("IsVideoPlayerGestureEnabled") var isVideoPlayerGestureEnabled = true
    var body: some View {
        List {
            Section {
                Toggle("Gesture.double-tap", isOn: $isVideoPlayerGestureEnabled)
            } footer: {
                Text("Gesture.double-tap.description") //在视频播放器使用互点两下手势(Apple Watch Series 9 及以上)或快速操作(其他机型)暂停或播放视频
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
