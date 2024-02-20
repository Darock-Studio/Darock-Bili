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
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Darwin
import SwiftUI
import Mixpanel
import DarockKit
import SwiftyJSON
import CoreHaptics
#if !os(visionOS)
import SDWebImage
import SDWebImagePDFCoder
import SDWebImageSVGCoder
import SDWebImageWebPCoder
#else
import RealityKit
#endif
#if os(watchOS)
import WatchKit
#endif

//!!!: Debug Setting, Set false Before Release
var debug = false

var debugControlStdout = "stdo\n"

var pShowTipText = ""
var pShowTipSymbol = ""
var pTipBoxOffset: CGFloat = 80

var isShowMemoryInScreen = false

var isInOfflineMode = false

#if os(watchOS)
var isInLowBatteryMode = false
#endif

// BUVID
var globalBuvid3 = ""
var globalBuvid4 = ""

var globalHapticEngine: CHHapticEngine?

#if os(visionOS)
var globalWindowSize = Size3D()
#endif

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
@main
struct DarockBili_Watch_AppApp: App {
    #if os(watchOS)
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #else
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("IsActived") var isActived = false
    // Screen Time
    @AppStorage("isSleepNotificationOn") var isSleepNotificationOn = false
    @AppStorage("notifyHour") var notifyHour = 0
    @AppStorage("notifyMinute") var notifyMinute = 0
    @AppStorage("IsScreenTimeEnabled") var isScreenTimeEnabled = true
    @State var screenTimeCaculateTimer: Timer? = nil
    @State var showTipText = ""
    @State var showTipSymbol = ""
    @State var tipBoxOffset: CGFloat = 80
    @State var isOfflineMode = false
    @State var isLowBatteryMode = false
    // Debug Controls
    @State var isShowingDebugControls = false
    @State var systemResourceRefreshTimer: Timer?
    @State var memoryUsage: Float = 0.0
    @State var isShowMemoryUsage = false
    @State var currentHour = 0
    @State var currentMinute = 0
    // Handoff
    @State var handoffVideoDetails = [String: String]()
    @State var shouldPushVideoView = false
    #if os(watchOS)
    @State var isMemoryWarningPresented = false
    #else
    @State var shouldShowAppName = false
    #endif
    var body: some SwiftUI.Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "NewSignalError") ?? "" != "" {
                SignalErrorView()
            } else {
                ZStack {
                    #if !os(visionOS)
                    #if os(watchOS)
                    if isOfflineMode {
                        OfflineMainView()
                    } else {
                        ContentView()
                    }
                    VStack {
                        Spacer()
                        if #available(watchOS 10, *) {
                            HStack {
                                Image(systemName: showTipSymbol)
                                Text(showTipText)
                            }
                            .font(.system(size: 14, weight: .bold))
                            .frame(width: 110, height: 40)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .offset(y: tipBoxOffset)
                            .animation(.easeOut(duration: 0.4), value: tipBoxOffset)
                        } else {
                            HStack {
                                Image(systemName: showTipSymbol)
                                Text(showTipText)
                            }
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 110, height: 40)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .background {
                                Color.white
                                    .ignoresSafeArea()
                                    .frame(width: 120, height: 40)
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: 0xF5F5F5))
                                    .opacity(0.95)
                            }
                            .offset(y: tipBoxOffset)
                            .animation(.easeOut(duration: 0.4), value: tipBoxOffset)
                        }
                    }
                    #else
                    if isActived {
                        ContentView()
                    } else {
                        FirstActiveView(isActived: $isActived)
                    }
                    if shouldShowAppName {
                        VStack {
                            Spacer()
                                .frame(height: 5)
                            ZStack {
                                Capsule()
                                    .fill(Color.accentColor)
                                    .frame(width: 100, height: 25)
                                Text("喵哩喵哩")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            Spacer()
                        }
                        .ignoresSafeArea()
                    }
                    #endif
                    #else
                    GeometryReader3D { proxy3D in
                        ContentView()
                            .onAppear {
                                Task {
                                    // Delay first - rdar://so?77970699
                                    // rdar://so?76698516
                                    try await Task.sleep(nanoseconds: 1_000_000_000)
                                    globalWindowSize = proxy3D.size
                                }
                            }
                    }
                    #endif
                }
                #if os(watchOS)
                .sheet(isPresented: $isMemoryWarningPresented, content: {MemoryWarningView()})
                #endif
                .onAppear {
                    #if os(watchOS)
                    isInLowBatteryMode = UserDefaults.standard.bool(forKey: "IsInLowBatteryMode")
                    #endif
                    
                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                        showTipText = pShowTipText
                        showTipSymbol = pShowTipSymbol
                        UserDefaults.standard.set(isLowBatteryMode, forKey: "IsInLowBatteryMode")
                        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                            tipBoxOffset = pTipBoxOffset
                            timer.invalidate()
                        }
                    }
                    
                    #if os(watchOS)
                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                        if getMemory() > 240.0 {
                            isMemoryWarningPresented = true
                            timer.invalidate()
                        }
                    }
                    #endif
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if isShowMemoryInScreen {
                            isShowMemoryUsage = true
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                memoryUsage = getMemory()
                            }
                            timer.invalidate()
                        }
                    }
                    let timer = Timer(timeInterval: 1, repeats: true) { timer in
                        currentHour = getCurrentTime().hour
                        currentMinute = getCurrentTime().minute
                    }
                    let sleepTimeCheck = Timer(timeInterval: 60, repeats: true) { timer in
                        if currentHour == notifyHour && currentMinute == notifyMinute && isSleepNotificationOn {
                            #if !os(visionOS)
                            AlertKitAPI.present(title: String(localized: "Sleep.notification"), icon: .heart, style: .iOS17AppleMusic, haptic: .warning)
                            #endif
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
            }
        }
        .onChange(of: scenePhase) { value in
            switch value {
            case .background:
                break
            case .inactive:
                shouldShowAppName = false
            case .active:
                #if !os(visionOS)
                SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
                SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
                SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
                SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 10
                SDImageCache.shared.config.shouldCacheImagesInMemory = false
                SDImageCache.shared.config.shouldUseWeakMemoryCache = true
                SDImageCache.shared.clearMemory()
                #endif
                
                updateBuvid()
                
                #if os(watchOS)
                WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
                #else
                if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
                    do {
                        globalHapticEngine = try CHHapticEngine()
                        try globalHapticEngine?.start()
                    } catch {
                        print("创建引擎时出现错误： \(error.localizedDescription)")
                    }
                }
                
                shouldShowAppName = true
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
            @unknown default:
                break
            }
        }
    }
}

#if os(watchOS)
public func tipWithText(_ text: String, symbol: String = "", time: Double = 3.0) {
    pShowTipText = text
    pShowTipSymbol = symbol
    pTipBoxOffset = 7
    Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
        pTipBoxOffset = 80
        timer.invalidate()
    }
}
#endif

#if !os(watchOS)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Mixpanel.initialize(token: "37d4aaecc64cae16353c2fe7dbb0513c", trackAutomaticEvents: false)
        //                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //  Wow you see a token there, I'm not forget to hide it because you are no able to
        //  do anything important by this token >_-
        if (UserDefaults.standard.object(forKey: "IsAllowMixpanel") as? Bool) ?? true {
            Mixpanel.mainInstance().track(event: "Open App")
            if let uid = UserDefaults.standard.string(forKey: "DedeUserId") {
                Mixpanel.mainInstance().registerSuperPropertiesOnce(["DedeUserId": uid])
            }
        }
            
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        //AlertKitAPI.present(title: "低内存警告", subtitle: "喵哩喵哩收到了低内存警告", icon: .error, style: .iOS17AppleMusic, haptic: .warning)
    }
}

func signalErrorRecord(_ errorNum: Int32, _ errorSignal: String) {
    var symbols = ""
    for symbol in Thread.callStackSymbols {
        symbols += symbol + "\n"
    }
    let dateN = Date.now
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS Z"
    let dateStr = df.string(from: dateN)
    let fullString = """
    -------------------------------------
    Translated Report (Full Report Below)
    -------------------------------------
    
    Date/Time:  \(dateStr)
    Version:  \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)
    OS Version:  \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)
    
    Exception Type:  \(errorSignal)
    Termination Reason:  \(errorSignal) \(errorNum)
    
    Main Symbols
    
    \(backtraceMainThread())
    
    
    Current Thread Symbols:
    
    \(backtraceCurrentThread())
    
    Swift Thread Symbols:
    
    \(symbols)
    
    EOF
    """
    let manager = FileManager.default
    let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
    try! fullString.write(to: URL(string: (urlForDocument[0] as URL).absoluteString + "\(dateStr.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "__")).ddf")!, atomically: true, encoding: .utf8)
    UserDefaults.standard.set("\(dateStr).ddf", forKey: "NewSignalError")
}
#else
class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        Mixpanel.initialize(token: "37d4aaecc64cae16353c2fe7dbb0513c")
        //                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //  Wow you see a token there, I'm not forget to hide it because you are no able to
        //  do anything important by this token >_-
        if (UserDefaults.standard.object(forKey: "IsAllowMixpanel") as? Bool) ?? true {
            Mixpanel.mainInstance().track(event: "Open App")
            if let uid = UserDefaults.standard.string(forKey: "DedeUserId") {
                Mixpanel.mainInstance().registerSuperPropertiesOnce(["DedeUserId": uid])
            }
        }
        
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 10
        SDImageCache.shared.config.shouldCacheImagesInMemory = false
        SDImageCache.shared.config.shouldUseWeakMemoryCache = true
        SDImageCache.shared.clearMemory()
    }
}
#endif

public func updateBuvid() {
    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/frontend/finger/spi") { respJson, isSuccess in
        if isSuccess {
            globalBuvid3 = respJson["data"]["b_3"].string ?? globalBuvid3
            globalBuvid4 = respJson["data"]["b_4"].string ?? globalBuvid4
        }
    }
}
