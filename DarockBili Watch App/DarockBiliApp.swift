//
//  DarockBiliApp.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
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
import WatchKit
import Mixpanel
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

var isInLowBatteryMode = false

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
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    // Screen Time
    @AppStorage("isSleepNotificationOn") var isSleepNotificationOn = false
    @AppStorage("notifyHour") var notifyHour = 0
    @AppStorage("notifyMinute") var notifyMinute = 0
    @AppStorage("IsScreenTimeEnabled") var isScreenTimeEnabled = true
    @State var screenTimeCaculateTimer: Timer? = nil
    @State var isMemoryWarningPresented = false
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
                ZStack {
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
                }
                    .sheet(isPresented: $isMemoryWarningPresented, content: {MemoryWarningView()})
                    .onAppear {
                        isInLowBatteryMode = UserDefaults.standard.bool(forKey: "IsInLowBatteryMode")
                        
                        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                            showTipText = pShowTipText
                            showTipSymbol = pShowTipSymbol
                            isLowBatteryMode = isInLowBatteryMode
                            UserDefaults.standard.set(isLowBatteryMode, forKey: "IsInLowBatteryMode")
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                                tipBoxOffset = pTipBoxOffset
                                timer.invalidate()
                            }
                            
                            isOfflineMode = isInOfflineMode
                        }
                        
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                            if getMemory() > 240.0 {
                                isMemoryWarningPresented = true
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
            }
        }
        .onChange(of: scenePhase) { value in
            switch value {
            case .background:
                break
            case .inactive:
                break
            case .active:
                updateBuvid()
                
                WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
                
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

public func tipWithText(_ text: String, symbol: String = "", time: Double = 3.0) {
    pShowTipText = text
    pShowTipSymbol = symbol
    pTipBoxOffset = 7
    Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
        pTipBoxOffset = 80
        timer.invalidate()
    }
}

class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        Mixpanel.initialize(token: "37d4aaecc64cae16353c2fe7dbb0513c")
        //                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //  Wow you see a token there, I'm not forget to hide it because you are no able to
        //  do anything important by this token >_-
        if (UserDefaults.standard.object(forKey: "IsAllowMixpanel") as? Bool) ?? true {
            Mixpanel.mainInstance().track(event: "Open App", properties: [
                "System": "watchOS"
            ])
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
    OS Version:  \(WKInterfaceDevice.current().systemName) \(WKInterfaceDevice.current().systemVersion)
    
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



