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
import DarockKit
import SwiftyJSON
import SDWebImage
import SDWebImagePDFCoder
import SDWebImageSVGCoder
import SDWebImageWebPCoder

//!!!: Debug Setting, Set false Before Release
var debug = false

var debugControlStdout = "stdo\n"

var pShowTipText = ""
var pShowTipSymbol = ""
var pTipBoxOffset: CGFloat = 80

var isShowMemoryInScreen = false

var isInOfflineMode = false

// BUVID
var globalBuvid3 = ""
var globalBuvid4 = ""

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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
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
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "NewSignalError") ?? "" != "" {
                SignalErrorView()
            } else {
                ContentView()
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                            showTipText = pShowTipText
                            showTipSymbol = pShowTipSymbol
                            UserDefaults.standard.set(isLowBatteryMode, forKey: "IsInLowBatteryMode")
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                                tipBoxOffset = pTipBoxOffset
                                timer.invalidate()
                            }
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
                        let timer = Timer(timeInterval: 1, repeats: true) { timer in
                            currentHour = getCurrentTime().hour
                            currentMinute = getCurrentTime().minute
                        }
                        let sleepTimeCheck = Timer(timeInterval: 60, repeats: true) { timer in
                            if currentHour == notifyHour && currentMinute == notifyMinute && isSleepNotificationOn {
                                AlertKitAPI.present(title: String(localized: "Sleep.notification"), icon: .heart, style: .iOS17AppleMusic, haptic: .warning)
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
            }
        }
        .onChange(of: scenePhase) { value in
            switch value {
            case .background:
                break
            case .inactive:
                break
            case .active:
                SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
                SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
                SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
                SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 10
                SDImageCache.shared.config.shouldCacheImagesInMemory = false
                SDImageCache.shared.config.shouldUseWeakMemoryCache = true
                SDImageCache.shared.clearMemory()
                
                updateBuvid()
                
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true, options: [])
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        AlertKitAPI.present(title: "低内存警告", subtitle: "喵哩喵哩收到了低内存警告", icon: .error, style: .iOS17AppleMusic, haptic: .warning)
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

public func updateBuvid() {
    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/frontend/finger/spi") { respJson, isSuccess in
        if isSuccess {
            globalBuvid3 = respJson["data"]["b_3"].string ?? globalBuvid3
            globalBuvid4 = respJson["data"]["b_4"].string ?? globalBuvid4
        }
    }
}
