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
    @State var phoneCode = "86"
    //---QR Login---
    @State var qrImage: CGImage?
    @State var qrKey = ""
    @State var isScanned = false
    @State var qrTimer: Timer?
    
    @State var smsLoginToken = ""
    
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
                            HStack {
                                /* Picker("+\(phoneCode)", selection: $phoneCode) {
                                 ForEach(callNations.indices) { codeIndex in
                                 Text(callNations[codeIndex]).tag(callCodes[codeIndex])
                                 }
                                 } */
                                Text("+86")
                                TextField("Login.step1.phone-number", text: $accountInput)
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
                                    if accountInput.count == 11 && !accountInput.contains(" ") {
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
                                            AF.request("https://passport.bilibili.com/x/passport-login/web/sms/send", method: .post, parameters: BiliSmsCodePost(cid: Int(phoneCode)!, tel: Int(accountInput)!, token: loginToken, challenge: challenge, validate: validate, seccode: seccode), headers: headers).response { response in
                                                debugPrint(response)
                                                let json = try! JSON(data: response.data!)
                                                smsLoginToken = json["data"]["captcha_key"].string!
                                            }
                                        }
                                    } else {
                                        #if os(iOS)
                                        AlertKitAPI.present(title: "手机号错误", subtitle: "请输入正确的11位手机号", icon: .error, style: .iOS17AppleMusic, haptic: .error)
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
                        AF.request("https://passport.bilibili.com/x/passport-login/web/login/sms", method: .post, parameters: BiliLoginPost(cid: Int(phoneCode)!, tel: Int(accountInput)!, code: Int(passwdInput)!, captcha_key: smsLoginToken)).response { response in
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

public let callNations = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cabo Verde (Cape Verde)",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Central African Republic",
    "Chad",
    "Chile",
    "China mainland",
    "Colombia",
    "Comoros",
    "Congo, Democratic Republic of the",
    "Congo, Republic of the",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor (Timor-Leste)",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini (Swaziland)",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, North (North Korea)",
    "Korea, South (South Korea)",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Macedonia (formerly Macedonia)",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine State",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States of America",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City"
]

public let callCodes = [
    "93",
    "355",
    "213",
    "376",
    "244",
    "1-268",
    "54",
    "374",
    "61",
    "43",
    "994",
    "1-242",
    "973",
    "880",
    "1-246",
    "375",
    "32",
    "501",
    "229",
    "975",
    "591",
    "387",
    "267",
    "55",
    "673",
    "359",
    "226",
    "257",
    "238",
    "855",
    "237",
    "1",
    "236",
    "235",
    "56",
    "86",
    "57",
    "269",
    "243",
    "242",
    "506",
    "385",
    "53",
    "357",
    "420",
    "45",
    "253",
    "1",
    "670",
    "593",
    "20",
    "503",
    "240",
    "291",
    "372",
    "268",
    "251",
    "679",
    "358",
    "33",
    "241",
    "220",
    "995",
    "49",
    "233",
    "30",
    "1",
    "502",
    "224",
    "245",
    "592",
    "509",
    "504",
    "36",
    "354",
    "91",
    "62",
    "98",
    "964",
    "353",
    "972",
    "39",
    "81",
    "962",
    "7",
    "254",
    "686",
    "850",
    "82",
    "383",
    "965",
    "996",
    "856",
    "371",
    "961",
    "266",
    "231",
    "218",
    "423",
    "370",
    "352",
    "261",
    "265",
    "60",
    "960",
    "223",
    "356",
    "692",
    "222",
    "230",
    "52",
    "691",
    "373",
    "377",
    "976",
    "382",
    "212",
    "258",
    "95",
    "264",
    "674",
    "977",
    "31",
    "64",
    "505",
    "227",
    "234",
    "389",
    "47",
    "968",
    "92",
    "680",
    "970",
    "507",
    "675",
    "595",
    "51",
    "63",
    "48",
    "351",
    "974",
    "40",
    "7",
    "250",
    "378",
    "239",
    "966",
    "221",
    "381",
    "248",
    "232",
    "65",
    "421",
    "386",
    "677",
    "252",
    "27",
    "211",
    "34",
    "94",
    "249",
    "597",
    "46",
    "41",
    "963",
    "886",
    "992",
    "255",
    "66",
    "228",
    "676",
    "1-868",
    "216",
    "90",
    "993",
    "688",
    "256",
    "380",
    "971",
    "44",
    "598",
    "998",
    "678",
    "379",
    "58",
    "84",
    "967",
    "260",
    "263"
]
