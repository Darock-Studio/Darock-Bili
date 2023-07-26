//
//  DarockBiliApp.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import Darwin
import SwiftUI
import DarockKit
import SDWebImage
import SDWebImagePDFCoder
import SDWebImageSVGCoder
import SDWebImageWebPCoder

//!!!: Debug Setting, Set false Before Release
let debug = true

var pShowTipText = ""
var pShowTipSymbol = ""
var pTipBoxOffset: CGFloat = 80

@main
struct DarockBili_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isMemoryWarningPresented = false
    @State var showTipText = ""
    @State var showTipSymbol = ""
    @State var tipBoxOffset: CGFloat = 80
    //Debug Controls
    @State var isShowingDebugControls = false
    @State var systemResourceRefreshTimer: Timer?
    @State var memoryUsage: Float = 0.0
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "NewSignalError") ?? "" != "" {
                SignalErrorView()
            } else {
                ZStack {
                    ContentView()
                    VStack {
                        Spacer()
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
                                .shadow(color: .white, radius: 4, x: 1, y: 1)
                                .opacity(0.9)
                        }
                        .offset(y: tipBoxOffset)
                        .animation(.easeIn(duration: 0.4), value: tipBoxOffset)
                    }
                }
                    .sheet(isPresented: $isMemoryWarningPresented, content: {MemoryWarningView()})
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                            showTipText = pShowTipText
                            showTipSymbol = pShowTipSymbol
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                                tipBoxOffset = pTipBoxOffset
                                timer.invalidate()
                            }
                        }
                        
                        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                            if getMemory() > 140.0 {
                                isMemoryWarningPresented = true
                                timer.invalidate()
                            }
                        }
                    }
                    .overlay {
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
                                        HStack {
                                            VStack {
                                                Text("Memory Usage: \(memoryUsage) MB")
                                                
                                            }
                                            .font(.system(size: 10))
                                            Spacer()
                                        }
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
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 20
        SDImageCache.shared.config.shouldCacheImagesInMemory = false
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
