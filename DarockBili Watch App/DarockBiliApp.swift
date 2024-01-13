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
import DarockKit
import SwiftyJSON
import SDWebImage
import SDWebImagePDFCoder
import SDWebImageSVGCoder
import SDWebImageWebPCoder

//!!!: Debug Setting, Set false Before Release
var debug = true

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

@main
struct DarockBili_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    // Screen Time
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
                                    Text("内存占用: \(String(format: "%.2f", memoryUsage)) MB / 300 MB")
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
                                            ScrollView {
                                                Text(debugControlStdout)
                                            }
                                            .frame(height: 180)
                                            .border(Color.blue, width: 2)
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
                //screenTimeCaculateTimer?.invalidate()
                break
            case .inactive:
                break
            case .active:
                updateBuvid()
                
                WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
                if screenTimeCaculateTimer == nil {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        screenTimeCaculateTimer = timer
                        let df = DateFormatter()
                        df.dateFormat = "yyyy-MM-dd"
                        let dateStr = df.string(from: Date.now)
                        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "ScreenTime\(dateStr)") + 1, forKey: "ScreenTime\(dateStr)")
                    }
                } else {
                    //screenTimeCaculateTimer!.fire()
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
//        signal(SIGABRT, {error in
//            signalErrorRecord(error, "SIGABRT")
//        })
//        signal(SIGTRAP, {error in
//            signalErrorRecord(error, "SIGTRAP")
//        })
//        signal(SIGILL, {error in
//            signalErrorRecord(error, "SIGILL")
//        })
//        signal(SIGKILL, {error in
//            signalErrorRecord(error, "SIGKILL")
//        })
        
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

public func getBuvid(url: String, callback: (String, String, String) -> Void) {
    let _uuid = UuidInfoc.gen()
    let postParams: [String: Any] = [
        "3064":1, // ptype, mobile => 2, others => 1
        "5062":Date.now.milliStamp, // timestamp
        "03bf":url, // url accessed
        "39c8":"333.1007.fp.risk", // spm_id,
        "34f1":"", // target_url, default empty now
        "d402":"", // screenx, default empty
        "654a":"", // screeny, default empty
        "6e7c":"3440x1440", // browser_resolution, window.innerWidth || document.body && document.body.clientWidth + "x" + window.innerHeight || document.body && document.body.clientHeight
        "3c43":[ // 3c43 => msg
            "2673":1, // hasLiedResolution, window.screen.width < window.screen.availWidth || window.screen.height < window.screen.availHeight
            "5766":24, // colorDepth, window.screen.colorDepth
            "6527":0, // addBehavior, !!window.HTMLElement.prototype.addBehavior, html5 api
            "7003":1, // indexedDb, !!window.indexedDB, html5 api
            "807e":1, // cookieEnabled, navigator.cookieEnabled
            "b8ce":"Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebK…KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", // ua
            "641c":0, // webdriver, navigator.webdriver, like Selenium
            "07a4":"zh-CN", // language
            "1c57":4, // deviceMemory in GB, navigator.deviceMemory
            "0bd0":4, // hardwareConcurrency, navigator.hardwareConcurrency
            "748e":[
                3440, // window.screen.width
                1440  // window.screen.height
            ], // screenResolution
            "d61f":[
                3440, // window.screen.availWidth
                1440  // window.screen.availHeight
            ], // availableScreenResolution
            "fc9d":-480, // timezoneOffset, (new Date).getTimezoneOffset()
            "6aa9":"Asia/Shanghai", // timezone, (new window.Intl.DateTimeFormat).resolvedOptions().timeZone
            "75b8":1, // sessionStorage, window.sessionStorage, html5 api
            "3b21":1, // localStorage, window.localStorage, html5 api
            "8a1c":0, // openDatabase, window.openDatabase, html5 api
            "d52f":"not available", // cpuClass, navigator.cpuClass
            "adca":"Win32", // platform, navigator.platform
            "80c9":[
                [
                    "PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "Chrome PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "Chromium PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "Microsoft Edge PDF Viewer",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ],
                [
                    "WebKit built-in PDF",
                    "Portable Document Format",
                    [
                        [
                            "application/pdf",
                            "pdf"
                        ],
                        [
                            "text/pdf",
                            "pdf"
                        ]
                    ]
                ]
            ], // plugins
            "13ab":"mTUAAAAASUVORK5CYII=", // canvas fingerprint
            "bfe9":"aTot0S1jJ7Ws0JC6QkvAL/A4H1PbV+/QA3AAAAAElFTkSuQmCC", // webgl_str
            "a3c1":[], // webgl_params, cab be set to [] if webgl is not supported
            "6bc5":"Broadcom~V3D 4.2", // webglVendorAndRenderer
            "ed31":0, // hasLiedLanguages
            "72bd":0, // hasLiedOs
            "097b":0, // hasLiedBrowser
            "52cd":[
                0, // void 0 !== navigator.maxTouchPoints ? t = navigator.maxTouchPoints : void 0 !== navigator.msMaxTouchPoints && (t = navigator.msMaxTouchPoints);
                0, // document.createEvent("TouchEvent"), if succeed 1 else 0
                0 // "ontouchstart" in window ? 1 : 0
            ], // touch support
            "a658":[
                "Arial",
                "Courier",
                "Courier New",
                "Helvetica",
                "Times",
                "Times New Roman"
            ], // font details. see https://github.com/fingerprintjs/fingerprintjs for implementation details
            "d02f":"124.04347527516074" // audio fingerprint. see https://github.com/fingerprintjs/fingerprintjs for implementation details
        ],
        "54ef":"{\"b_ut\":\"7\",\"home_version\":\"V8\",\"i-wanna-go-back\":\"-1\",\"in_new_ab\":true,\"ab_version\":{\"for_ai_home_version\":\"V8\",\"tianma_banner_inline\":\"CONTROL\",\"enable_web_push\":\"DISABLE\"},\"ab_split_num\":{\"for_ai_home_version\":54,\"tianma_banner_inline\":54,\"enable_web_push\":10}}", // abtest info, embedded in html
        "8b94":"", // refer_url, document.referrer ? encodeURIComponent(document.referrer).substr(0, 1e3) : ""
        "df35":_uuid, // _uuid, set from cookie, generated by client side(algorithm remains unknown)
        "07a4":"zh-CN", // language
        "5f45":0, // laboratory, set from cookie, null if empty, source remains unknown
        "db46":0 // is_selfdef, default 0
    ]
    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/frontend/finger/spi") { respJson, isSuccess in
        if isSuccess {
            let buvid3 = respJson["data"]["b_3"].string ?? ""
            let buvid4 = respJson["data"]["b_4"].string ?? ""
            let postHeaders: HTTPHeaders = [
                "cookie": "innersign=0; buvid3=\(buvid3); b_nut=\(Date.now.timestamp); i-wanna-go-back=-1; b_ut=7; b_lsid=9910433CB_18CF260AB89; _uuid=\(_uuid); enable_web_push=DISABLE; header_theme_version=undefined; home_feed_column=4; browser_resolution=3440-1440; buvid4=\(buvid4); buvid_fp=e651c1a382430ea93631e09474e0b395"
            ]
            AF.request("https://api.bilibili.com/x/internal/gaia-gateway/ExClimbWuzhi", method: .post, parameters: postParams, headers: postHeaders).response {
                callback(buvid3, buvid4, response.debugDescription)
            }
        }
    } 
}

