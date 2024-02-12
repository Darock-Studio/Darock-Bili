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
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Charts
import SwiftUI
import SwiftDate
import DarockKit
import AuthenticationServices

struct SettingsView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var isLogoutAlertPresented = false
    var body: some View {
        List {
            Section {
                NavigationLink(destination: {PlayerSettingsView().navigationTitle("Settings.player")}, label: {
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
                NavigationLink(destination: {NetworkSettingsView().navigationTitle("Settings.internet")}, label: {
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
                NavigationLink(destination: {ScreenTimeSettingsView().navigationTitle("Settings.screen-time")}, label: {
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
                NavigationLink(destination: {SleepTimeView().navigationTitle("Settings.sleep")}, label: {
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
                NavigationLink(destination: {FeedbackView().navigationTitle("Settings.feedback")}, label: {
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
            }
            Section {
                NavigationLink(destination: {AboutView()}, label: {
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
                        NavigationLink(destination: {DebugMenuView().navigationTitle("Settings.debug")}, label: {
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
//                            ZStack {
//                                Color.red
//                                    .frame(width: 20, height: 20)
//                                    .clipShape(Circle())
//                                Image(systemName: "person.slash")
//                                    .font(.system(size: 12))
//                            }
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
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct PlayerSettingsView: View {
    @AppStorage("IsRecordHistory") var isRecordHistory = true
    @AppStorage("VideoGetterSource") var videoGetterSource = "official"
    var body: some View {
        List {
            Section {
                Toggle("记录历史记录", isOn: $isRecordHistory)
            }
            Section(footer: Text("Player.analyzying-source.description")) {
                Picker("Player.analyzying-source", selection: $videoGetterSource) {
                    Text("Player.analyzying-source.offical").tag("official")
                    Text("Player.analyzying-source.third-party").tag("injahow")
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
                    Text("Troubleshoot")
                })
                Toggle("Troubleshoot.auto-pop-up", isOn: $isShowNetworkFixing)
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
        var id: String{ name }
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
            let timer = Timer(timeInterval: 0.5, repeats: true) { timer in
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


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
