//
//
//  LoginView.swift
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
import EFQRCode
import Alamofire
import DarockKit
import SwiftyJSON
import AuthenticationServices

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    //Captcha
    @State var loginToken = ""
    @State var challenge = ""
    @State var gt = ""
    @State var validate = ""
    @State var seccode = ""
    //Bili Returns
    @State var salt = ""
    @State var publicKey = ""
    //User Input
    @State var accountInput = ""
    @State var passwdInput = ""
    //---QR Login---
    @State var qrImage: CGImage?
    @State var qrKey = ""
    @State var isScanned = false
    @State var qrTimer: Timer?
    
    @State var smsLoginToken = ""
    
    @State var countryCode = "86"
    @State var PhoneFormat = ""
    @State var displayCC = ""
    
    @State var userList1: [Any] = []
    @State var userList2: [Any] = []
    @State var userList3: [Any] = []
    @State var userList4: [Any] = []
    @State var currentStep = 1
    var body: some View {
        TabView {
            //--QR Login--
            #if os(watchOS)
            ScrollView {
                if qrImage != nil {
                    ZStack {
                        VStack {
                            Image(uiImage: UIImage(cgImage: qrImage!))
                                .resizable()
                                .frame(width: 140, height: 140)
                                .blur(radius: isScanned ? 8 : 0)
                            Text("Login.scan")
                                .bold()
                        }
                        if isScanned {
                            Text("Login.scanned")
                                .font(.title2)
                            //.foregroundColor(.white)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .tag(0)
            .onAppear {
                userList1 = UserDefaults.standard.array(forKey: "userList1") ?? []
                userList2 = UserDefaults.standard.array(forKey: "userList2") ?? []
                userList3 = UserDefaults.standard.array(forKey: "userList3") ?? []
                userList4 = UserDefaults.standard.array(forKey: "userList4") ?? []
                let headers: HTTPHeaders = [
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/web/qrcode/generate", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        let qrUrl = respJson["data"]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                        debugPrint(qrUrl)
                        if let image = EFQRCode.generate(for: qrUrl) {
                            qrImage = image
                        }
                        qrKey = respJson["data"]["qrcode_key"].string!
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                            qrTimer = timer
                            DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=\(qrKey)", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    if respJson["data"]["code"].int == 86090 {
                                        isScanned = true
                                    } else if respJson["data"]["code"].int == 0 {
                                        timer.invalidate()
                                        debugPrint(respJson)
                                        let respUrl = respJson["data"]["url"].string!
                                        dedeUserID = String(respUrl.split(separator: "DedeUserID=")[1].split(separator: "&")[0])
                                        dedeUserID__ckMd5 = String(respUrl.split(separator: "DedeUserID__ckMd5=")[1].split(separator: "&")[0])
                                        sessdata = String(respUrl.split(separator: "SESSDATA=")[1].split(separator: "&")[0])
                                        biliJct = String(respUrl.split(separator: "bili_jct=")[1].split(separator: "&")[0])
                                        userList1.append(dedeUserID)
                                        userList2.append(dedeUserID__ckMd5)
                                        userList3.append(sessdata)
                                        userList4.append(biliJct)
                                        UserDefaults.standard.set(userList1, forKey: "userList1")
                                        UserDefaults.standard.set(userList2, forKey: "userList2")
                                        UserDefaults.standard.set(userList3, forKey: "userList3")
                                        UserDefaults.standard.set(userList4, forKey: "userList4")
                                        dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onDisappear {
                if qrTimer != nil {
                    qrTimer!.invalidate()
                }
            }
            #endif
            //--SMS Login--
            ScrollView {
                VStack {
                    SupportedGroupBox {
                        VStack(alignment: .leading) {
                            Label("Login.step1.title", systemImage: "1.circle")
                                .bold()
                            //  .foregroundStyle(currentStep == 1 ? Color.accentColor : Color.primary)
                                Picker("", selection: $countryCode) {
                                    Text("🇨🇳 中国大陆 86").tag("86")
                                    Text("🇭🇰 中国香港 852").tag("852")
                                    Text("🇲🇴 中国澳门 853").tag("853")
                                    Text("🇹🇼 中国台湾 886").tag("886")
                                    Text("🇺🇸 美国 1").tag("us")
                                    Text("🇧🇪 比利时 32").tag("32")
                                    Text("🇦🇺 澳大利亚 61").tag("61")
                                    Text("🇫🇷 法国 33").tag("33")
                                    Text("🇨🇦 加拿大 1").tag("ca")
                                    Text("🇯🇵 日本 81").tag("81")
                                    Text("🇸🇬 新加坡 65").tag("65")
                                    Text("🇰🇷 韩国 82").tag("82")
                                    Text("🇲🇾 马来西亚 60").tag("60")
                                    Text("🇬🇧 英国 44").tag("44")
                                    Text("🇮🇹 意大利 39").tag("39")
                                    Text("🇩🇪 德国 49").tag("49")
                                    Text("🇷🇺 俄罗斯 7").tag("7")
                                    Text("🇳🇿 新西兰 64").tag("64")
                                    Text("🇼🇫 瓦利斯群岛和富图纳群岛 1681").tag("1681")
                                    Text("🇵🇹 葡萄牙 351").tag("351")
                                    Text("🇵🇼 帕劳 680").tag("680")
                                    Text("🇳🇫 诺福克岛 672").tag("672")
                                    Text("🇳🇴 挪威 47").tag("47")
                                    Text("🇳🇺 纽埃岛 683").tag("683")
                                    Text("🇳🇬 尼日利亚 234").tag("234")
                                    Text("🇳🇪 尼日尔 227").tag("227")
                                    Text("🇳🇮 尼加拉瓜 505").tag("505")
                                    Text("🇳🇵 尼泊尔 977").tag("977")
                                    Text("🇳🇷 瑙鲁 674").tag("674")
                                    Text("🇬🇪 格鲁吉亚 995").tag("995")
                                    Text("🇸🇪 瑞典 46").tag("46")
                                    Text("🇸🇦 沙特阿拉伯 966").tag("966")
                                    Text("🇹🇿 桑给巴尔岛 259").tag("259")
                                    Text("🇸🇨 塞舌尔共和国 248").tag("248")
                                    Text("🇨🇾 塞浦路斯 357").tag("357")
                                    Text("🇸🇳 塞内加尔 221").tag("221")
                                    Text("🇸🇱 塞拉利昂 232").tag("232")
                                    Text("🇼🇸 萨摩亚，东部 684").tag("684")
                                    Text("🇼🇸 萨摩亚，西部 685").tag("685")
                                    Text("🇸🇻 萨尔瓦多 503").tag("503")
                                    Text("🇨🇭 瑞士 41").tag("41")
                                    Text("🇸🇹 圣多美和普林西比 239").tag("239")
                                    Text("🇷🇸 塞尔维亚 381").tag("381")
                                    Text("🇿🇦 南非 27").tag("27")
                                    Text("🇲🇷 毛里塔尼亚 222").tag("222")
                                    Text("🇲🇺 毛里求斯 230").tag("230")
                                    Text("🇲🇭 马歇尔岛 692").tag("692")
                                    Text("🇲🇶 马提尼克岛 596").tag("596")
                                    Text("🇲🇰 马其顿 389").tag("389")
                                    Text("🇲🇵 马里亚纳岛 1670").tag("1670")
                                    Text("🇲🇱 马里 223").tag("223")
                                    Text("🇲🇼 马拉维 265").tag("265")
                                    Text("🇲🇹 马耳他 356").tag("356")
                                    Text("🇲🇻 马尔代夫 960").tag("960")
                                    Text("🇲🇳 蒙古 976").tag("976")
                                    Text("🇲🇸 蒙特塞拉特岛 1664").tag("1664")
                                    Text("🇳🇦 纳米比亚 264").tag("264")
                                    Text("🇲🇽 墨西哥 52").tag("52")
                                    Text("🇲🇿 莫桑比克 258").tag("258")
                                    Text("🇲🇨 摩纳哥 377").tag("377")
                                    Text("🇲🇦 摩洛哥 212").tag("212")
                                    Text("🇲🇩 摩尔多瓦 373").tag("373")
                                    Text("🇲🇲 缅甸 95").tag("95")
                                    Text("🇫🇲 密克罗尼西亚 691").tag("691")
                                    Text("🇵🇪 秘鲁 51").tag("51")
                                    Text("🇧🇩 孟加拉国 880").tag("880")
                                    Text("🇲🇬 马达加斯加 261").tag("261")
                                    Text("🇱🇨 圣卢西亚 1784").tag("1784")
                                    Text("🇨🇱 智利 56").tag("56")
                                    Text("🇯🇲 牙买加 1876").tag("1876")
                                    Text("🇸🇾 叙利亚 963").tag("963")
                                    Text("🇭🇺 匈牙利 36").tag("36")
                                    Text("🇨🇮 科特迪瓦 225").tag("225")
                                    Text("🇬🇷 希腊 30").tag("30")
                                    Text("🇪🇸 西班牙 34").tag("34")
                                    Text("🇺🇿 乌兹别克斯坦 998").tag("998")
                                    Text("🇺🇾 乌拉圭 598").tag("598")
                                    Text("🇺🇦 乌克兰 380").tag("380")
                                    Text("🇺🇬 乌干达 256").tag("256")
                                    Text("🇦🇲 亚美尼亚 374").tag("374")
                                    Text("🇾🇪 也门 967").tag("967")
                                    Text("🇬🇮 直布罗陀 350").tag("350")
                                    Text("🇹🇩 乍得 235").tag("235")
                                    Text("🇿🇲 赞比亚 260").tag("260")
                                    Text("🇻🇳 越南 84").tag("84")
                                    Text("🇯🇴 约旦 962").tag("962")
                                    Text("🇮🇩 印尼 62").tag("62")
                                    Text("🇮🇳 印度 91").tag("91")
                                    Text("🇮🇱 以色列 972").tag("972")
                                    Text("🇮🇷 伊朗 98").tag("98")
                                    Text("🇮🇶 伊拉克 964").tag("964")
                                    Text("🇧🇳 文莱 673").tag("673")
                                    Text("🇻🇪 委内瑞拉 58").tag("58")
                                    Text("🇻🇬 维珍群岛(英属) 1284").tag("1284")
                                    Text("🇹🇭 泰国 66").tag("66")
                                    Text("🇸🇴 索马里 252").tag("252")
                                    Text("🇸🇧 所罗门群岛 677").tag("677")
                                    Text("🇸🇷 苏里南 597").tag("597")
                                    Text("🇸🇩 苏丹 249").tag("249")
                                    Text("🇸🇿 斯威士兰 268").tag("268")
                                    Text("🇸🇮 斯洛文尼亚 386").tag("386")
                                    Text("🇸🇰 斯洛伐克 421").tag("421")
                                    Text("🇱🇰 斯里兰卡 94").tag("94")
                                    Text("🇵🇲 圣皮埃尔和密克隆群岛 508").tag("508")
                                    Text("🇹🇿 坦桑尼亚 255").tag("255")
                                    Text("🇹🇴 汤加 676").tag("676")
                                    Text("🇻🇮 维珍群岛(美属) 1340").tag("1340")
                                    Text("🇻🇺 瓦努阿图 678").tag("678")
                                    Text("🇹🇰 托克劳岛 690").tag("690")
                                    Text("🇹🇲 土库曼斯坦 993").tag("993")
                                    Text("🇹🇷 土耳其 90").tag("90")
                                    Text("🇹🇻 图瓦卢 688").tag("688")
                                    Text("🇹🇳 突尼斯 216").tag("216")
                                    Text("🇦🇨 阿森松岛 247").tag("247")
                                    Text("🇹🇹 特立尼达和多巴哥 1868").tag("1868")
                                    Text("🇹🇨 特克斯和凯科斯 1649").tag("1649")
                                    Text("🇸🇲 圣马力诺 378").tag("378")
                                    Text("🇬🇫 法属圭亚那 594").tag("594")
                                    Text("🇧🇹 不丹 975").tag("975")
                                    Text("🇧🇼 博茨瓦纳 267").tag("267")
                                    Text("🇧🇿 伯利兹 501").tag("501")
                                    Text("🇧🇴 玻利维亚 591").tag("591")
                                    Text("🇵🇱 波兰 48").tag("48")
                                    Text("🇧🇦 波黑 387").tag("387")
                                    Text("🇵🇷 波多黎各 1787").tag("1787")
                                    Text("🇮🇸 冰岛 354").tag("354")
                                    Text("🇧🇯 贝宁 229").tag("229")
                                    Text("🇧🇬 保加利亚 359").tag("359")
                                    Text("🇧🇫 布基纳法索 226").tag("226")
                                    Text("🇧🇮 布隆迪 257").tag("257")
                                    Text("🇵🇫 法属波利尼西亚 689").tag("689")
                                    Text("🇫🇴 法罗岛 298").tag("298")
                                    Text("🇪🇷 厄立特里亚 291").tag("291")
                                    Text("🇪🇨 厄瓜多尔 593").tag("593")
                                    Text("🇩🇲 多米尼加代表 1809").tag("1809")
                                    Text("🇩🇲 多米尼加 1767").tag("1767")
                                    Text("🇹🇬 多哥 228").tag("228")
                                    Text("🇩🇬 迪戈加西亚岛 246").tag("246")
                                    Text("🇩🇰 丹麦 45").tag("45")
                                    Text("🇬🇶 赤道几内亚 240").tag("240")
                                }
                            }
                            HStack {
//                                Picker("\(phoneCode)", selection: $phoneCode) {
//                                    ForEach(callNations.indices) { codeIndex in
//                                        Text(callNations[codeIndex]).tag(callCodes[codeIndex])
//                                    }
//                                }
                                //Text("86")
                                #if !os(watchOS)
                                TextField("", text: $displayCC).frame(width: 40)
                                #endif
                                    TextField("\(PhoneFormat)", text: $accountInput)
                                #if !os(watchOS)
                                    .keyboardType(.phonePad)
                                #endif
                                    .onChange(of: accountInput, perform: { _ in
                                        if !passwdInput.isEmpty {
                                            currentStep = 3
                                        } else if !accountInput.isEmpty {
                                            currentStep = 2
                                        } else {
                                            currentStep = 1
                                        }
                                    })
                                    .onChange(of: countryCode, perform: { _ in
                                        PhoneFormat = phoneFormatter(region: countryCode)
                                        if countryCode == "us" || countryCode == "ca" {
                                            displayCC = "1"
                                        } else {
                                            displayCC = countryCode
                                        }
                                    })
                                    .onChange(of: displayCC, perform: { _ in
                                        if displayCC == "1" {
                                            countryCode = "us"
                                        } else {
                                            countryCode = displayCC
                                        }
                                    })
                            }
                        }
                    }
                    SupportedGroupBox {
                        VStack(alignment: .leading) {
                            Label("Login.step2.title", systemImage: "2.circle")
                                .bold()
                            //  .foregroundStyle(currentStep == 2 ? Color.accentColor : Color.primary)
                            HStack {
                                TextField(validate.isEmpty ? "Login.step2.captcha-first" : "Login.step2.code", text: $passwdInput)
                                    .disabled(validate.isEmpty)
                                #if !os(watchOS)
                                    .keyboardType(.numberPad)
                                #endif
                                    .onChange(of: passwdInput, perform: { _ in
                                        if !passwdInput.isEmpty {
                                            currentStep = 3
                                        } else if !accountInput.isEmpty {
                                            currentStep = 2
                                        } else {
                                            currentStep = 1
                                        }
                                        print(currentStep)
                                    })
                                Button(action: {
                                    let isValidPhone = validatePhoneNumber(num: accountInput, cc: displayCC)
                                    if !accountInput.contains(" ") && isValidPhone {
                                        if validate.isEmpty {
                                            #if !os(watchOS)
                                            UIApplication.shared.open(URL(string: "https://darock.top/geetest?gt=\(gt)&challenge=\(challenge)")!)
                                            #else
                                            let session = ASWebAuthenticationSession(url: URL(string: "https://darock.top/geetest?gt=\(gt)&challenge=\(challenge)")!, callbackURLScheme: "drkbili") { url, _ in
                                                if let url {
                                                    let surl = url.absoluteString.urlDecoded()
                                                    let ds = surl.components(separatedBy: "?")
                                                    if ds[0].contains("logincap") {
                                                        debugPrint(ds)
                                                        let spdF = ds[1].split(separator: "&")
                                                        validate = String(spdF[0])
                                                        seccode = String(spdF[1])
                                                    }
                                                }
                                            }
                                            session.prefersEphemeralWebBrowserSession = true
                                            session.start()
                                            #endif
                                        } else {
                                            let headers: HTTPHeaders = [
                                                "Host": "passport.bilibili.com",
                                                "Origin": "https://www.bilibili.com",
                                                "Referer": "https://www.bilibili.com/",
                                                "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
                                                "Cookie": "browser_resolution=1580-497; FEED_LIVE_VERSION=V8; buvid4=818BA302-8EAC-0630-67AB-BB978A5797AF60982-023042618-ho21%2BqF6LZokzAShrGptM4EHZm2TE4%2FTXmfZyPpzfCnLuUmUckb8wg%3D%3D; buvid_fp=5a716236853dd1e737d439882c685594; header_theme_version=CLOSE; home_feed_column=5; _uuid=15B5A2103-BBC2-9109A-7458-6410C3CF101028B94909infoc; b_lsid=CCF71993_18991563B31; b_ut=7; i-wanna-go-back=-1; innersign=0; b_nut=1690360493; buvid3=6481EDF5-10C43-9593-251E-89210B4A1C10A193894infoc"
                                            ]
                                            AF.request("https://passport.bilibili.com/x/passport-login/web/sms/send", method: .post, parameters: BiliSmsCodePost(cid: Int(phoneIdList[countryCode]!)!, tel: Int(accountInput)!, token: loginToken, challenge: challenge, validate: validate, seccode: seccode), headers: headers).response { response in
                                                debugPrint(response)
                                                let json = try! JSON(data: response.data!)
                                                smsLoginToken = json["data"]["captcha_key"].string!
                                            }
                                        }
                                    } else {
                                        #if os(iOS)
                                        AlertKitAPI.present(title: "手机号错误", subtitle: "请输入正确的手机号", icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                        #else
                                        tipWithText("手机号错误", symbol: "xmark.circle.fill")
                                        #endif
                                    }
                                }, label: {
                                    if validate.isEmpty {
                                        Text("Login.step2.CAPTCHA")
                                            .foregroundStyle(!validate.isEmpty && accountInput.isEmpty ? Color.secondary : Color.accentColor)
                                    } else if smsLoginToken.isEmpty {
                                        if accountInput.isEmpty {
                                            Text("Login.step2.code.empty")
                                                .foregroundStyle(.secondary)
                                        } else {
                                            Text("Login.step2.code.get")
                                                .foregroundStyle(Color.accentColor)
                                        }
                                    } else {
                                        Text("Login.step2.code.sent")
                                            .foregroundStyle(.secondary)
                                    }
                                })
                                .disabled(!validate.isEmpty && accountInput.isEmpty)
                                
                            }
                            
                        }
                    }
                    .disabled(currentStep < 2)
                    .foregroundStyle(currentStep >= 2 ? Color.primary : Color.secondary)
                    Button(action: {
                        AF.request("https://passport.bilibili.com/x/passport-login/web/login/sms", method: .post, parameters: BiliLoginPost(cid: Int(phoneIdList[countryCode]!)!, tel: Int(accountInput)!, code: Int(passwdInput)!, captcha_key: smsLoginToken)).response { response in
                            let data = response.data
                            if data != nil {
                                let json = try! JSON(data: data!)
                                debugPrint(json)
                                if json["code"].int == 0 {
                                    if json["data"]["status"].int == 0 {
                                        debugPrint(response.response!.headers)
                                        let setCookie = response.response!.headers["Set-Cookie"]!
                                        dedeUserID = String(setCookie.split(separator: "DedeUserID=")[1].split(separator: ";")[0])
                                        dedeUserID__ckMd5 = String(setCookie.split(separator: "DedeUserID__ckMd5=")[1].split(separator: ";")[0])
                                        if setCookie.hasPrefix("SESSDATA") {
                                            sessdata = String(setCookie.split(separator: "SESSDATA=")[0].split(separator: ";")[0])
                                        } else {
                                            sessdata = String(setCookie.split(separator: "SESSDATA=")[1].split(separator: ";")[0])
                                        }
                                        biliJct = String(setCookie.split(separator: "bili_jct=")[1].split(separator: ";")[0])
                                        dismiss()
                                    } else if json["data"]["status"].int == 1006 {
                                        
                                    } else if json["data"]["status"].int == 1007 {
                                        
                                    }
                                }
                            }
                        }
                    }, label: {
                        SupportedGroupBox {
                            HStack {
                                Label("Login.step3.title", systemImage: "3.circle")
                                    .bold()
                                    //.foregroundStyle(currentStep == 3 ? Color.accentColor : Color.primary)
                                Spacer()
                                Image(systemName: "arrow.up.right.square")
                            }
                        }
                    })
                    .disabled(currentStep < 3)
                    .foregroundStyle(currentStep >= 3 ? Color.primary : Color.secondary)
                }
            }
            .navigationTitle("Login")
            .padding()
            .tag(1)
            .onOpenURL { url in
                let surl = url.absoluteString.urlDecoded()
                let ds = surl.components(separatedBy: "?")
                if ds[0].contains("logincap") {
                    debugPrint(ds)
                    let spdF = ds[1].split(separator: "&")
                    validate = String(spdF[0])
                    seccode = String(spdF[1])
                }
            }
            .onAppear {
                let headers: HTTPHeaders = [
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/captcha?source=main_web", headers: headers) { respJson, isSuccess in
                    if isSuccess {
                        challenge = respJson["data"]["geetest"]["challenge"].string!
                        gt = respJson["data"]["geetest"]["gt"].string!
                        loginToken = respJson["data"]["token"].string!
                    }
                }
                PhoneFormat = phoneFormatter(region: countryCode)
                if countryCode == "us" || countryCode == "ca" {
                    displayCC = "1"
                } else {
                    displayCC = countryCode
                }
                if displayCC == "1" {
                    countryCode = "us"
                } else {
                    countryCode = displayCC
                }
            }
        }
    }
    
    struct BiliLoginPost: Codable {
        let cid: Int
        let tel: Int
        let code: Int
        var source: String = "main_web"
        let captcha_key: String
        var keep: Bool = true
    }
    struct BiliSmsCodePost: Codable {
        let cid: Int
        let tel: Int
        var source: String = "main_web"
        let token: String
        let challenge: String
        let validate: String
        let seccode: String
    }
    
    @ViewBuilder
    func SupportedGroupBox(_ content: () -> some View) -> some View {
        #if !os(watchOS)
        GroupBox {
            content()
        }
        #else
        content()
        #endif
    }
}

#Preview {
    LoginView()
}
