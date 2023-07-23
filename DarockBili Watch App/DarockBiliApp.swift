//
//  DarockBiliApp.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import Darwin
import SwiftUI
import SDWebImage
import SDWebImageWebPCoder
import SDWebImageSVGCoder
import SDWebImagePDFCoder

@main
struct DarockBili_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "NewSignalError") ?? "" != "" {
                SignalErrorView()
            } else {
                ContentView()
            }
        }
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
        signal(SIGKILL, {error in
            signalErrorRecord(error, "SIGKILL")
        })
        
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 20
        SDImageCache.shared.config.shouldCacheImagesInMemory = false
        
//        let nsd = biliEmojiDictionary as NSDictionary
//        let manager = FileManager.default
//        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
//        try! nsd.write(to: URL(string: (urlForDocument[0] as URL).absoluteString + "biliEmoji.plist")!)
//        debugPrint((urlForDocument[0] as URL).absoluteString + "biliEmoji.plist")
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
