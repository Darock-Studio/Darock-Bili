//
//
//  MeowBiliApp.swift
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

import Darwin
import SwiftUI
import DarockUI
import RadarKit
import SwiftyJSON
import SDWebImage
import RadarKitCore
import DarockFoundation
import SDWebImagePDFCoder
import SDWebImageSVGCoder
import SDWebImageWebPCoder
@_spi(_internal) import CorvusKit
#if os(watchOS)
import WatchKit
#else
import CoreHaptics
#endif

//!!!: Debug Setting, Set false Before Release
var debug = false
var debugBuild: Bool {
    #if DEBUG
    true
    #else
    false
    #endif
}

var isShowMemoryInScreen = false

var isInOfflineMode = false

#if os(watchOS)
var isInLowBatteryMode = false
#endif

// BUVID
var globalBuvid3 = ""
var globalBuvid4 = ""

// swiftlint:disable no_c_style_comment
/*
 ::::::::::::::-:=**=========+===++++++++++*%+*%%%%#%%%%%*++#@%%%@@@%%@@@%%%%%%%*+*#****#%%@@@@@@@@@%
 ::::::::::::::::===========+===++++++++++#@*+%%%%%%%%%%@%*++#@%%@@@@%%@@%%%%%%@%*+********#%@@@@@@@%
 :::::::::::::::::-========+==+++++=++++*%@#+%%%%%#%%%%%%%@%*+#@%%%%%@%%@%%%%%%%@%++***##%@@@@@@@@%%*
 ::::::::::::::::=========+==+++====+++*%%%+#%%%%#%%%%%%%%%@%*+%@%%%%%@%%@%%%%%%%%*+**#@@@@@@@@@@@@#:
 :::::::::::::::============++=====+++#%%%#*@%%%##@%%%%%%%%%%@*+%%%%%%%@%%@%%%%%%@*+***%@@@@@@@@@@#:-
 ::::::::::::::============++=====+++#%%%%*%%%%%#%%#%%%%%%%%%%@**@%@%%%%@%%%%%%%%@#****#%%@@@@@@@@%*-
 :::::::::::::============++======++*%%#%%#%%%%#%%%#@%%%%%%%%%%@*%@%%@%%%%%%%%%%%%%%#+*#%@@@@@@@%%*=-
 ::::::::::::=-==========++===+==++*%%##%%%%%%%%%%*%%%%%%%%%%#%%%####%@%%%%%%%%%%%%@%+***#%@@@@*--::-
 :::::::::::=-===========+======+++%%%*%%%%%%%%%@*+%%%%%%%%%%%%%%%**%#%@%%%%%%%%%%%%%*+*****#%@#-----
 ::::::::::=:-==========+======+++*%%#*%%%%%%#%%*+*%%%%%%%%%%%#%%%#++%#%@%%%%%%%%%%%%*****#++*##=----
 :::::::::=::==================+++#%%*#%%%%%%%@#+*+%%%%%%%%%%%%%%%%%++%#%@%%%%%%%%%%%#@%#%@%+%@%=:---
 ::::::::--:=========+==+====+=+++%%%*%%%%%%%%***#+#%%%%%%%%%%%#%%%%%*+#%#@%%%%%%%%%%#%%@%%@*%%@*-::-
 :::::::--:-=========+========+++*%%##%%%#%@%+*%*#**%%%%%%%%%%%#%%%%%%#+#%#%%%%%%%%%%#%%%%%@##@%%#*=:
 ::::::--::=========+=-+====+====*%%#*%%#%%*+*%####+%%%%%%#%%%%##%%%%#@#+#%#%@%%%###%%%%%%%@%#@%@*-**
 ::::::-::-=========+======+*+=++*%%**#%%#++#@##%#%+*@%%%%%%%%%%#%%%%*%@%+*%#%%##%%%%%%@%%%%@#%@%%-:=
 :::::-:::==========+======##+=+++%%###*+=*%%%##%%%%+%%%%%##%%*#*%%%@#*@%%+#%%#%%%@%%%%@%%%%@%%@%##-:
 ::::-:::-==========+-==+=***#++++###*=+*#%%%%%#%@%@#+%%%%#%%%*#**%%%%+#%%%##%#%@%%%%%%@%%%@%%%%@*%#-
 ::::::::===========+----::..:::-=+###*%%%%%%%@##%@%@#*@%%#%%#%#%*#%%%+#%**+**%#%%%%%%%@%%%@%%%%%%+%%
 ::::::::=========+++=-- :==+-.::::=*@#%%%%#%%@%##@@%@##@%%%#%@#@%*%%*#***%*#%*%#%%%%%#@%%%%%%%%%%*+%
 :::::::-=========*#+==#-=@@@=-===--+#%#%%%##%@@@##@@@@%##%##%##@@%#%%+=*@@*#@#+##%@%%#%%#%%%@%%@%#++
 :::::::-========+%%+==##+%@@---=--+#*#%##%%*%@@@@%#%@@@#*+=-----======++%@*#%%#+##%%%#%%*%%%%%%%%%#=
 :::::::=========#%%#=-*%%%@@==*+-=+-*@%@##%%%@@@@@@%%@%**#-:-----::-.:--+%*%%%@#*##%%#%#*@%%%%%%%%@#
 :::::::=======++#%%%+=+#%@%@%*%%###+%@@@@%%%#%@@@@@@@@%@@%-==+*==*%@%*:.-#*%%%%%%%%%%#%+*@%%%%%%%%%%
 .-::::-========+%%%%+++#%@@@@%#%%%#%@@@@@@@@%%%@@@@@@@@@@*-==##===+@@%+*##*%%%%%%%%%%%++#%%%%%%%%%%%
 .--::--====-===+#%%%*#=*#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%+#####+-#@%%%%#+#%%%%%%%%%%%++#%%%%%%%#%%%
 .--:----========*@%%##*+*%@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@##%%%#*#@@@@%##+%%%%%%%%%%%%*+%%%%%#%@#*%%
 .-=:-=--==-=-==++%%%#**#*#%@@@@@@@@@@@@@@%%%@@@@@@@@@@@@@@@@@@@%@@@@@%#%**@%%%%%%%%%%%#+%%%%%#%%#+#%
 ::=-=--===-======+%%%%==+#%@@@@@@@@@@@@@@%%%@@@@@@@@@@@@@@@@@@@@@@@@@%##=%%%%%%%%%%%%%%*%%%%**%%*=*%
 -===-====--=====+=*%%%*=-*#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##**%%%%%%%%%%%#%%%%%%%+#%%*:+#
 -=======--:======+=*%%=+==##%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%###%%%%%%%%%%%%*#%%%%%#+%%%+:-*
 =======-:::=========*%*-==+##%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#*#*#%%%%%%%%%%%%+*%#%%%+*%%#-:-=
 ======---==-=========+%+-==+*#%@@@@@@@@@@@%%%%@@@@@@@@@@@@@@@@@@@%+-=++%%#%%%%%%%%%*+*%%#%*=#%%*-:-=
 =====--====-===========#+====++#%@@@@@@@@@%%%%@@@@@@@@@@@@@@@@@%*--+==#%#%%%%%%%%%#+++%%##%#%%*=:-==
 ===-:-====---===========+++===+++*%@@@@@@@@@@@@@@@@@@@@@@@@@%*=:::+==+%#*%%%%%%%%%+*++%%%#%%%*+--=+=
 ==-::===-:----=========+=-+-::-=+++=*%@@@@@@@@@@@@@@@@@%%#+==-==+**++%%+#%%%%%%%%#+*++%%%%#%*+-:-==+
 =-:::==-..-----=========#+-::-++=++: :*#%@@@@@@@@%%%###****#%%%%%#+=#%++%%%%%%%%%=*+++%%#%#++=:--=+%
 -::::=-:-------=========+#-::+%#*==:.:-+++*##########%%%%%%##*++=-:+%+=*%%%%%%%%*-*+++%%*#%#-::::-==
 -----=--------++=========+#--*##%#+:--:*+++**##%%%%##**+==---------%*-=#%%%%%%%#++==++%%++#%*:::::::
 --------------++++========+*=+%###%*--+*#%%%%##*++=------==+**##+=*#*+=#%%%%%%%+*+=+=*%#+++#@#=:::::
 ------:-------++++==========*+#####%#+*%##*+=-----=++*###%%%%%%#==###+=*%##%%%#+*+++=*%*+++==#%*=:::
 ----::...:---:=++++*++=:-====++*######+=----=+**##%%%%%########*=+*##*++%##%%%*+++++-%#=+++::-+**+++
 --:....::..-:::=++#%#+:::======++######+-+*#%##################*=+####++*%*%%#+++++=*#++++=+++==+###
 :.....-+=..-::.-++#*=:-+#***++-::-+***###++**###################=+#####++*##%#+++==+*++++++==+*#%###
 .....:++- -=::.:-+=::=*########*-:-*######+==++**###############*=%#####+=++%#++=++=+=+====+#%%#####
 ..:..+++..+-.:.::::-+############=::=*#####*+++++++*############%**%%#%%%#+=+%++++=====-=*#%######%%
  :+::++: -+---:::::###############*=::=*######***#*#**#***********+=***++=-::=*===+++++*########%#*+
 :+*-=+=.:---::.::::=################*=::-+*#####*=-:-:::::----------------=-::+++++++**######%#*+-::
 ++--++=-:::::.::::::=+*###############*+=--==+=-:::-+:--====================-:=+++++**+#**#%#+-:::::
 ++:+++=:.:::..:::::-*==+**###############*+=:::---+%--=======================--+++++#++++**+-:::::::
 +++++=::::..--:::::-##*++=++***##***++=+*===+*****%=-=========================-++++**++**+--------::
 
 
 
 
 Xcode哥😭，求你了🙏别把fatal往main抛，闭包，精确到闭包就行求你了🙏我在也不跑了哥，我真的太痒了，求你了，我听话，我以后再也不闹了🤐，求你了哥，给我定位到闭包吧，我现在身体痒的要死😫，求求你了🙏，哥，你就最后再给我一次吧我求求你了🙏哥，你要什么我都给你，你再给我一集🤌就好，我现在身体里像是有蚂蚁在爬😫，太痒了 哥，给我一集吧，最后一次，我发誓✋，真的是最后一次了
   |  main
   |
  \/
*/
// swiftlint:enable no_c_style_comment
@main
struct DarockBiliApp: App {
    #if os(watchOS)
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #else
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.isLuminanceReduced) private var isLuminanceReduced
    // Screen Time
    @AppStorage("isSleepNotificationOn") private var isSleepNotificationOn = false
    @AppStorage("notifyHour") private var notifyHour = 0
    @AppStorage("notifyMinute") private var notifyMinute = 0
    @AppStorage("IsScreenTimeEnabled") private var isScreenTimeEnabled = true
    @AppStorage("BlurWhenScreenSleep") private var blurWhenScreenSleep = false
    @AppStorage("IsReduceBrightness") private var isReduceBrightness = false
    @AppStorage("ReduceBrightnessPercent") private var reduceBrightnessPercent = 0.1
    @State private var screenTimeCaculateTimer: Timer?
    @State private var isLowBatteryMode = false
    // Debug Controls
    @State private var isShowingDebugControls = false
    @State private var systemResourceRefreshTimer: Timer?
    @State private var memoryUsage: Float = 0.0
    @State private var isShowMemoryUsage = false
    @State private var currentHour = 0
    @State private var currentMinute = 0
    // Handoff
    @State private var handoffVideoDetails = [String: String]()
    @State private var shouldPushVideoView = false
    // FileLocker
    @State private var fileLockerPwd = UserDefaults.standard.string(forKey: "FileLockerPassword") ?? ""
    @State private var fileLockerRecoverCode = UserDefaults.standard.string(forKey: "FileLockerRecoverCode") ?? ""
    @State private var fileLockerRetryCount = 0
    @State private var fileLockerInput = ""
    @State private var recoveryCodeInput = ""
    // Navigators
    @State private var urlOpenVideoDetails: [String: String]?
    var body: some SwiftUI.Scene {
        WindowGroup {
            if fileLockerPwd != "" {
                NavigationStack {
                    List {
                        Section {
                            Text(fileLockerRetryCount == 0 ? "文件保险箱已启用" : "输入错误")
                                .font(.title3)
                                .bold()
                                .listRowBackground(Color.clear)
                        }
                        Section {
                            TextField("密码", text: $fileLockerInput) {
                                if fileLockerInput == fileLockerPwd {
                                    fileLockerPwd = ""
                                } else {
                                    fileLockerInput = ""
                                    fileLockerRetryCount++
                                }
                            }
                            .submitLabel(.continue)
                        }
                        if fileLockerRetryCount >= 3 {
                            Section {
                                TextField("使用恢复密钥", text: $recoveryCodeInput) {
                                    if recoveryCodeInput == fileLockerRecoverCode {
                                        fileLockerPwd = ""
                                    } else {
                                        recoveryCodeInput = ""
                                        fileLockerRetryCount++
                                    }
                                }
                                .submitLabel(.continue)
                            }
                        }
                    }
                }
            } else {
                ZStack {
                    NavigationStack {
                        ContentView()
                            .navigationDestination(item: $urlOpenVideoDetails) { detail in
                                VideoDetailView(videoDetails: detail)
                            }
                    }
                    if isReduceBrightness {
                        Rectangle()
                            .fill(Color.black)
                            .ignoresSafeArea()
                            .opacity(reduceBrightnessPercent)
                            .allowsHitTesting(false)
                    }
                }
                .blur(radius: isLuminanceReduced && blurWhenScreenSleep ? 12 : 0)
                .onAppear {
                    #if os(watchOS)
                    isInLowBatteryMode = UserDefaults.standard.bool(forKey: "IsInLowBatteryMode")
                    #endif
                    
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                        UserDefaults.standard.set(isLowBatteryMode, forKey: "IsInLowBatteryMode")
                    }
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if isShowMemoryInScreen {
                            isShowMemoryUsage = true
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                memoryUsage = getMemory()
                            }
                            timer.invalidate()
                        }
                    }
                    let timer = Timer(timeInterval: 1, repeats: true) { _ in
                        currentHour = getCurrentTime().hour
                        currentMinute = getCurrentTime().minute
                    }
                    let sleepTimeCheck = Timer(timeInterval: 60, repeats: true) { _ in
                        if currentHour == notifyHour && currentMinute == notifyMinute && isSleepNotificationOn {
                            tipWithText(String(localized: "Sleep.notification"), symbol: "bed.double.fill")
                        }
                    }
                    RunLoop.current.add(timer, forMode: .default)
                    timer.fire()
                    RunLoop.current.add(sleepTimeCheck, forMode: .default)
                    sleepTimeCheck.fire()
                }
                .overlay {
                    VStack {
                        HStack {
                            if isLowBatteryMode {
                                Image(systemName: "circle")
                                    .font(.system(size: 17, weight: .heavy))
                                    .foregroundColor(.accentColor)
                                    .offset(y: 10)
                            }
                        }
                        Spacer()
                    }
                    .ignoresSafeArea()
                    if isShowMemoryUsage {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Memory.indicator.\(String(format: "%.2f", memoryUsage))")
                                    .font(.system(size: 10, weight: .medium))
                                    .offset(y: 26)
                            }
                            Spacer()
                        }
                        .ignoresSafeArea()
                    }
                    if debug {
                        HStack {
                            VStack {
                                Button(action: {
                                    isShowingDebugControls.toggle()
                                }, label: {
                                    Text(isShowingDebugControls ? "Close Debug Controls" : "Show Debug Controls")
                                        .font(.system(size: 12))
                                        .foregroundColor(.blue)
                                })
                                .buttonStyle(.plain)
                                .offset(x: 15, y: 5)
                                if isShowingDebugControls {
                                    VStack {
                                        HStack {
                                            Text("Memory Usage: \(memoryUsage) MB")
                                            Spacer()
                                        }
                                        .allowsHitTesting(false)
                                    }
                                    .font(.system(size: 10))
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                                            systemResourceRefreshTimer = timer
                                            memoryUsage = getMemory()
                                        }
                                    }
                                    .onDisappear {
                                        systemResourceRefreshTimer?.invalidate()
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 3)
                            .padding(.vertical, 1)
                            Spacer()
                        }
                        .ignoresSafeArea()
                    }
                }
                .onContinueUserActivity("com.darock.DarockBili.video-play") { activity in
                    if let videoDetails = activity.userInfo as? [String: String] {
                        handoffVideoDetails = videoDetails
                        shouldPushVideoView = true
                    }
                }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
                    if let url = activity.webpageURL, let bvid = url.absoluteString.split(separator: "darock.top/meowbili/video/", maxSplits: 1)[from: 1] {
                        urlOpenVideoDetails = ["Pic": "", "Title": "Loading...", "BV": String(bvid), "UP": "Loading...", "View": "1", "Danmaku": "1"]
                    }
                }
                #if os(iOS)
                .onOpenURL { url in
                    let dec = url.absoluteString.urlDecoded()
                    let spd = dec.split(separator: "/").dropFirst()
                    debugPrint(spd)
                    switch spd[1] {
                    case "withvideodetail":
                        let kvs = dec.split(separator: "/", maxSplits: 2)[2].split(separator: "&") // e.g.: ["BV=xxx", "Title=xxx"]
                        var details = [String: String]()
                        for kv in kvs {
                            let kav = kv.split(separator: "=")
                            details.updateValue(String(kav[1]), forKey: String(kav[0]))
                        }
                        urlOpenVideoDetails = details
                    case "openbvid":
                        let bvid = spd[2]
                        urlOpenVideoDetails = ["Pic": "", "Title": "Loading...", "BV": String(bvid), "UP": "Loading...", "View": "1", "Danmaku": "1"]
                    default:
                        break
                    }
                }
                #endif
            }
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .background:
                break
            case .inactive:
                break
            case .active:
                SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
                SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
                SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
                SDImageCache.shared.config.shouldCacheImagesInMemory = false
                SDImageCache.shared.config.shouldUseWeakMemoryCache = true
                SDImageCache.shared.clearMemory()
                
                updateBuvid()
                
                #if os(watchOS)
                WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
                #else
                initHapticEngine()
                #endif
                
                if isScreenTimeEnabled {
                    if screenTimeCaculateTimer == nil {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            screenTimeCaculateTimer = timer
                            let df = DateFormatter()
                            df.dateFormat = "yyyy-MM-dd"
                            let dateStr = df.string(from: Date.now)
                            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "ScreenTime\(dateStr)") + 1, forKey: "ScreenTime\(dateStr)")
                        }
                    }
                }
                
                UserDefaults(suiteName: "group.darockst")?.set(true, forKey: "DCIsMeowBiliInstalled")
                
                #if os(watchOS)
                radarPrepareForRemoteAppdiagnose()
                #endif
            @unknown default:
                break
            }
        }
    }
}

#if !os(watchOS)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Task {
            do {
                try await COKChecker(caller: .darock).appStartupAutoCheck()
                let manager = RKCFeedbackManager(projectName: "喵哩喵哩")
                let feedbackIds = UserDefaults.standard.stringArray(forKey: "RadarFBIDs") ?? [String]()
                for id in feedbackIds {
                    if let feedback = await manager.getFeedback(byId: id) {
                        let formatter = RKCFileFormatter(for: feedback)
                        if let lastReply = formatter.replies().last {
                            if _slowPath(lastReply.isInternalHidden),
                               let state = lastReply.UpdateCorvusState,
                               state == "true" {
                                try await COKUpdater(caller: .darock).updateCOStatus(true)
                                COKChecker(caller: .darock)._applyWatermarkNow()
                                COKChecker(caller: .darock).cachedCheckStatus = true
                                break
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGrand, _ in
            DispatchQueue.main.async {
                if isGrand {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        requestAPI("/analyze/add/MLStatsiOSAppStartupCount") { _, _ in }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.hexEncodedString()
        UserDefaults.standard.set(tokenString, forKey: "UserNotificationToken")
        if !UserDefaults.standard.bool(forKey: "IsNotificationRegistered") {
            requestAPI("/apns/devtoken/add/MeowBili_iOS_Promotion/0/\(tokenString)") { _, _ in }
            UserDefaults.standard.set(true, forKey: "IsNotificationRegistered")
        }
    }
}
#else
class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
        SDImageCache.shared.config.shouldCacheImagesInMemory = false
        SDImageCache.shared.config.shouldUseWeakMemoryCache = true
        SDImageCache.shared.clearMemory()
        
        Task {
            do {
                try await COKChecker(caller: .darock).appStartupAutoCheck()
                let manager = RKCFeedbackManager(projectName: "喵哩喵哩")
                let feedbackIds = UserDefaults.standard.stringArray(forKey: "RadarFBIDs") ?? [String]()
                for id in feedbackIds {
                    if let feedback = await manager.getFeedback(byId: id) {
                        let formatter = RKCFileFormatter(for: feedback)
                        if let lastReply = formatter.replies().last {
                            if _slowPath(lastReply.isInternalHidden),
                               let state = lastReply.UpdateCorvusState,
                               state == "true" {
                                try await COKUpdater(caller: .darock).updateCOStatus(true)
                                COKChecker(caller: .darock)._applyWatermarkNow()
                                COKChecker(caller: .darock).cachedCheckStatus = true
                                break
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGrand, _ in
            DispatchQueue.main.async {
                if isGrand {
                    WKApplication.shared().registerForRemoteNotifications()
                }
            }
        }
        
        requestAPI("/analyze/add/MLStatswatchOSAppStartupCount") { _, _ in }
    }
    
    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.hexEncodedString()
        UserDefaults.standard.set(tokenString, forKey: "UserNotificationToken")
        if !UserDefaults.standard.bool(forKey: "IsNotificationRegistered") {
            requestAPI("/apns/devtoken/add/MeowBili_Watch_Promotion/0/\(tokenString)") { _, _ in }
            UserDefaults.standard.set(true, forKey: "IsNotificationRegistered")
        }
    }
}
#endif

public func updateBuvid() {
    requestJSON("https://api.bilibili.com/x/frontend/finger/spi") { respJson, isSuccess in
        if isSuccess {
            globalBuvid3 = respJson["data"]["b_3"].string ?? globalBuvid3
            globalBuvid4 = respJson["data"]["b_4"].string ?? globalBuvid4
        }
    }
}


func _currentGlobalSystemTime() -> String {
  let currentDate = Date()
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "HH:mm:ss"
  let formattedDate = dateFormatter.string(from: currentDate)
  return formattedDate
}
