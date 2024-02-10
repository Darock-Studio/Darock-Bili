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
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
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
            TabView {
                AboutApp()
                    .navigationTitle("About")
                AboutCredits()
                    .navigationTitle("About.credits")
//                    OpenSourceView()
//                        .navigationTitle("开源组件许可")
            }
        }
    }
}

struct AboutApp: View {
    let AppIconLength: CGFloat = 70
    var body: some View {
        VStack(alignment: .center) {
            Image("AppIconImage")
                .resizable()
                .frame(width: AppIconLength, height: AppIconLength)
                .mask(Circle())
            Text("About.meowbili")
                .bold()
                .font(.title3)
            Group {
                Text("v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String) Build \(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)")
                if debug {
                    Text(CodingTime.getCodingTime())
                } else {
                    Text("\(CodingTime.getCodingTime().components(separatedBy: " ")[0] + " " + CodingTime.getCodingTime().components(separatedBy: " ")[1] + " " +  CodingTime.getCodingTime().components(separatedBy: " ")[2])")
                }
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
    @Environment(\.dismiss) var dismiss
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
                        .sheet(isPresented: $isEasterEgg1Presented, content: {EasterEgg1View(isGenshin: $isGenshin)})
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
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: Easter Eggs
    struct EasterEgg1View: View {
        @Binding var isGenshin: Bool
        @Environment(\.dismiss) var dismiss
        @State var codeInput = ""
        var body: some View {
            VStack {
                TextField("About.mystery-code", text: $codeInput)
                Button(action: {
                    if codeInput == "Genshin" {
                        isGenshin = true
                        dismiss()
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


struct OpenSourceView: View {
    let openSourceTexts = """
            --- Alamofire ---
            Licensed under MIT license
            -----------------
            
            --- Dynamic ---
            Licensed under Apache License 2.0
            ---------------
            
            --- EFQRCode ---
            Licensed under MIT license
            ----------------
            
            --- libwebp ---
            Licensed under BSD-3-Clause license
            ---------------
            
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
            
            --- SwiftyJSON ---
            Licensed under MIT license
            ------------------
            """
    var body: some View {
        ScrollView {
            Text(openSourceTexts)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
