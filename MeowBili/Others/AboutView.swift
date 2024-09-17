//
//
//  AboutView.swift
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

import SwiftUI
import DarockKit

struct AboutView: View {
    var body: some View {
        NavigationStack {
            #if !os(watchOS)
            TabView {
                AboutApp()
                    .navigationTitle("About")
                    .tabItem {
                        Label("About", systemImage: "info.circle.fill")
                    }
                AboutCredits()
                    .navigationTitle("About.credits")
                    .tabItem {
                        Label("About.credits", systemImage: "person.3.sequence.fill")
                    }
            }
            #else
            TabView {
                AboutApp()
                    .navigationTitle("About")
                AboutCredits()
                    .navigationTitle("About.credits")
            }
            .tabViewStyle(.verticalPage)
            #endif
        }
    }
}

#if !os(watchOS)
struct AboutApp: View {
    let appIconLength: CGFloat = 140
    var body: some View {
        VStack(alignment: .center) {
            Image("AppIconImage")
                .resizable()
                .frame(width: appIconLength, height: appIconLength)
                .mask(Circle())
            Text("About.meowbili")
                .bold()
                .font(.title2)
            Group {
                if try! String(contentsOf: Bundle.main.url(forResource: "SemanticVersion", withExtension: "drkdatas")!).split(separator: "\n")[0] != "Unknown" {
                    Text("\(String(try! String(contentsOf: Bundle.main.url(forResource: "SemanticVersion", withExtension: "drkdatas")!).split(separator: "\n")[0]))(\(Bundle.main.infoDictionary?["CFBundleVersion"] as! String))")
                        .font(.system(size: 18))
                } else {
                    Text("v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                        .font(.system(size: 18))
                }
                if !debugBuild {
                    Text("\(String(try! String(contentsOf: Bundle.main.url(forResource: "CurrentChannel", withExtension: "drkdatac")!).split(separator: "\n")[0])) 通道")
                } else {
                    Text("调试构建")
                }
                Group {
                    if debug {
                        Text({ () -> String in
                            let df = DateFormatter()
                            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            return df.string(from: Date(timeIntervalSince1970: TimeInterval(CodingTime.getCodingTimestamp())))
                        }())
                    } else {
                        Text({ () -> String in
                            let df = DateFormatter()
                            df.dateFormat = "yyyy-MM-dd HH:mm"
                            return "构建时间：\(df.string(from: Date(timeIntervalSince1970: TimeInterval(CodingTime.getCodingTimestamp()))))"
                        }())
                    }
                }
                .font(.system(size: 18))
            }
            .font(.caption)
            .monospaced()
            .foregroundStyle(.secondary)
            .onTapGesture(count: 9) {
                debug.toggle()
                if debug {
                    AlertKitAPI.present(title: "Dev On", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                } else {
                    AlertKitAPI.present(title: "Dev Off", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                }
            }
        }
    }
}

struct AboutCredits: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isEasterEgg1Presented = false
    @State var isGenshin = false
    @State var genshinOverlayTextOpacity: CGFloat = 0.0
    var body: some View {
        List {
            Section {
                Text("WindowsMEMZ")
                Text("Lightning-Lion")
                Text("Linecom")
                Text("令枫")
                Text("ThreeManager785")
                Text("Dignite")
                Text("-- And You --")
                    .sheet(isPresented: $isEasterEgg1Presented, content: { EasterEgg1View(isGenshin: $isGenshin) })
                    .onTapGesture(count: 10) {
                        isEasterEgg1Presented = true
                    }
            }
            Section {
                NavigationLink(destination: {
                    OpenSourceView()
                        .navigationTitle("About.open-source")
                }, label: {
                    Text("About.open-source")
                })
            }
        }
        .navigationTitle("About.credits")
        .navigationBarHidden(isGenshin)
        .overlay {
            if isGenshin {
                ZStack(alignment: .center) {
                    Color.white
                    Text("About.genshin")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(.black)
                        .opacity(genshinOverlayTextOpacity)
                }
                .ignoresSafeArea()
                .animation(.smooth(duration: 2.0), value: genshinOverlayTextOpacity)
                .onAppear {
                    genshinOverlayTextOpacity = 1.0
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                        isGenshin = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: Easter Eggs
    struct EasterEgg1View: View {
        @Binding var isGenshin: Bool
        @Environment(\.presentationMode) var presentationMode
        @State var codeInput = ""
        var body: some View {
            VStack {
                TextField("About.mystery-code", text: $codeInput)
                Button(action: {
                    if codeInput == "Genshin" {
                        isGenshin = true
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        codeInput = String(localized: "About.mystery-code.error")
                    }
                }, label: {
                    Text("About.confirm")
                })
            }
            .presentationDetents([.medium])
#if !os(watchOS)
            .padding()
#endif
        }
    }
}
#else
struct AboutApp: View {
    let appIconLength: CGFloat = 70
    var body: some View {
        VStack(alignment: .center) {
            Image("AppIconImage")
                .resizable()
                .frame(width: appIconLength, height: appIconLength)
                .mask(Circle())
            Text("About.meowbili")
                .bold()
                .font(.title3)
            Group {
                if try! String(contentsOf: Bundle.main.url(forResource: "SemanticVersion", withExtension: "drkdatas")!).split(separator: "\n")[0] != "Unknown" {
                    Text("\(String(try! String(contentsOf: Bundle.main.url(forResource: "SemanticVersion", withExtension: "drkdatas")!).split(separator: "\n")[0]))(\(Bundle.main.infoDictionary?["CFBundleVersion"] as! String))")
                } else {
                    Text("v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                }
                if !debugBuild {
                    Text("\(String(try! String(contentsOf: Bundle.main.url(forResource: "CurrentChannel", withExtension: "drkdatac")!).split(separator: "\n")[0])) 通道")
                } else {
                    Text("调试构建")
                }
                if debug {
                    Text({ () -> String in
                        let df = DateFormatter()
                        df.dateFormat = "yy-MM-dd HH:mm:ss"
                        return df.string(from: Date(timeIntervalSince1970: TimeInterval(CodingTime.getCodingTimestamp())))
                    }())
                    .font(.system(size: 10))
                } else {
                    Text({ () -> String in
                        let df = DateFormatter()
                        df.dateFormat = "yy-MM-dd HH:mm"
                        return "构建时间：\(df.string(from: Date(timeIntervalSince1970: TimeInterval(CodingTime.getCodingTimestamp()))))"
                    }())
                    .font(.system(size: 10))
                }
            }
            .font(.caption)
            .monospaced()
            .foregroundStyle(.secondary)
            .onTapGesture(count: 9) {
                debug.toggle()
                if debug {
                    tipWithText("Dev On", symbol: "hammer.fill")
                } else {
                    tipWithText("Dev Off", symbol: "hammer")
                }
            }
        }
    }
}

struct AboutCredits: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isEasterEgg1Presented = false
    @State var isGenshin = false
    @State var genshinOverlayTextOpacity: CGFloat = 0.0
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("WindowsMEMZ")
                    Text("Lightning-Lion")
                    Text("Linecom")
                    Text("令枫")
                    Text("ThreeManager785")
                    Text("Dignite")
                    Text("-- And You --")
                        .sheet(isPresented: $isEasterEgg1Presented, content: { EasterEgg1View(isGenshin: $isGenshin) })
                        .onTapGesture(count: 10) {
                            isEasterEgg1Presented = true
                        }
                }
                Section {
                    NavigationLink(destination: {
                        OpenSourceView()
                            .navigationTitle("About.open-source")
                    }, label: {
                        Text("About.open-source")
                    })
                }
            }
        }
        .navigationBarHidden(isGenshin)
        .overlay {
            if isGenshin {
                ZStack(alignment: .center) {
                    Color.white
                    Text("About.genshin")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(.black)
                        .opacity(genshinOverlayTextOpacity)
                }
                .ignoresSafeArea()
                .animation(.smooth(duration: 2.0), value: genshinOverlayTextOpacity)
                .onAppear {
                    genshinOverlayTextOpacity = 1.0
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                        isGenshin = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: Easter Eggs
    struct EasterEgg1View: View {
        @Binding var isGenshin: Bool
        @Environment(\.presentationMode) var presentationMode
        @State var codeInput = ""
        var body: some View {
            VStack {
                TextField("About.mystery-code", text: $codeInput)
                Button(action: {
                    if codeInput == "Genshin" {
                        isGenshin = true
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        codeInput = String(localized: "About.mystery-code.error")
                    }
                }, label: {
                    Text("About.confirm")
                })
            }
        }
    }
}
#endif

struct OpenSourceView: View {
    let openSourceTexts = """
    --- Alamofire ---
    Licensed under MIT license
    -----------------
    
    --- AlertKit ---
    Licensed under MIT license
    ----------------
    
    --- AlertToast ---
    Licensed under MIT license
    ------------------
    
    --- AZVideoPlayer ---
    No license
    https://github.com/adamzarn/AZVideoPlayer
    ---------------------
    
    --- CepheusKeyboardKit ---
    Licensed under Apache License 2.0
    Code Changes: https://github.com/Serene-Garden/Cepheus/compare/main...WindowsMEMZ:Cepheus:main
    --------------------------
    
    --- Dynamic ---
    Licensed under Apache License 2.0
    ---------------
    
    --- EFQRCode ---
    Licensed under MIT license
    ----------------
    
    --- libwebp ---
    Licensed under BSD-3-Clause license
    ---------------
    
    --- MarqueeText ---
    Licensed under MIT license
    ---------------
    
    --- Mixpanel ---
    Licensed under Apache License 2.0
    ----------------
    
    --- ScreenshotableView ---
    Licensed under MIT license
    --------------------------
    
    --- SDWebImage ---
    Licensed under MIT license
    ------------------
    
    --- SDWebImagePDFCoder ---
    Licensed under MIT license
    --------------------------
    
    --- SDWebImageSVGCoder ---
    Licensed under MIT license
    --------------------------
    
    --- SDWebImageSwiftUI ---
    Licensed under MIT license
    -------------------------
    
    --- SDWebImageWebPCoder ---
    Licensed under MIT license
    ---------------------------
    
    --- SFSymbol ---
    Licensed under MIT license
    ----------------
    
    --- swift_qrcodejs ---
    Licensed under MIT license
    ----------------------
    
    --- SwiftDate ---
    Licensed under MIT license
    -----------------
    
    --- SwiftSoup ---
    Licensed under MIT license
    -----------------
    
    --- SwiftyJSON ---
    Licensed under MIT license
    ------------------
    
    --- ZipArchive ---
    Licensed under MIT license
    ------------------
    """
    var body: some View {
        ScrollView {
            #if !os(watchOS)
            HStack {
                Spacer()
                Text(openSourceTexts)
                Spacer()
            }
            #else
            Text(openSourceTexts)
            #endif
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
