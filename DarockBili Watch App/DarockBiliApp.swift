//
//  DarockBiliApp.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

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
            if UserDefaults.standard.bool(forKey: "isNewSignalError") {
                SignalErrorView()
            } else {
                ContentView()
            }
        }
    }
}

class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        signal(SIGABRT, {error in
            signalErrorRecord(error, "SIGABRT")
        })
        signal(SIGTRAP, {error in
            signalErrorRecord(error, "SIGTRAP")
        })
        signal(SIGILL, {error in
            signalErrorRecord(error, "SIGILL")
        })
        
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        SDImageCodersManager.shared.addCoder(SDImagePDFCoder.shared)
        
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
    var logNum = UserDefaults.standard.integer(forKey: "signalErrorLogNum")
    logNum += 1
    UserDefaults.standard.set(dateStr, forKey: "signalErrorTitle\(logNum)")
    UserDefaults.standard.set(fullString, forKey: "signalError\(logNum)")
    UserDefaults.standard.set(logNum, forKey: "signalErrorLogNum")
    UserDefaults.standard.set(true, forKey: "isNewSignalError")
}
