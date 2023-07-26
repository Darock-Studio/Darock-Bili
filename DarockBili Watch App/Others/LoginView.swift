//
//  LoginView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI
import DarockKit
import SwiftyJSON
import Alamofire
import EFQRCode
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
    var body: some View {
        TabView {
            ScrollView {
                if qrImage != nil {
                    ZStack {
                        VStack {
                            Image(uiImage: UIImage(cgImage: qrImage!))
                                .resizable()
                                .frame(width: 140, height: 140)
                                .blur(radius: isScanned ? 8 : 0)
                            Text("扫码登录")
                                .bold()
                        }
                        if isScanned {
                            Text("已扫描")
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
                DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/web/qrcode/generate") { respJson, isSuccess in
                    if isSuccess {
                        let qrUrl = respJson["data"]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                        debugPrint(qrUrl)
                        if let image = EFQRCode.generate(for: qrUrl) {
                            qrImage = image
                        }
                        qrKey = respJson["data"]["qrcode_key"].string!
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                            qrTimer = timer
                            DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=\(qrKey)") { respJson, isSuccess in
                                if respJson["data"]["code"].int == 86090 {
                                    isScanned = true
                                } else if respJson["data"]["code"].int == 0 {
                                    timer.invalidate()
                                    
                                    let respUrl = respJson["data"]["url"].string!
                                    dedeUserID = String(respUrl.split(separator: "DedeUserID=")[1].split(separator: "&")[0])
                                    dedeUserID__ckMd5 = String(respUrl.split(separator: "DedeUserID__ckMd5=")[1].split(separator: "&")[0])
                                    sessdata = String(respUrl.split(separator: "SESSDATA=")[1].split(separator: "&")[0])
                                    biliJct = String(respUrl.split(separator: "bili_jct=")[1].split(separator: "&")[0])
                                    dismiss()
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
            
            //--SMS Login--
            List {
                TextField("国际冠字码", text: $phoneCode)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                TextField("手机号", text: $accountInput)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Button(action: {
                    let session = ASWebAuthenticationSession(url: URL(string: "https://darock.top/geetest?gt=\(gt)&challenge=\(challenge)")!, callbackURLScheme: "captcha") { callbackURL, _ in
                        if callbackURL != nil {
                            if callbackURL!.absoluteString.contains("callback") {
                                let str = callbackURL!.absoluteString.urlDecoded()
                                validate = String(str.split(separator: "?")[1].split(separator: "&")[0])
                                seccode = String(str.split(separator: "&")[1])
                            }
                        }
                    }
                    session.prefersEphemeralWebBrowserSession = true
                    session.start()
                }, label: {
                    Text(validate == "" ? "进行人机验证" : "人机验证已完成")
                        .bold()
                })
                .disabled(validate != "")
                Button(action: {
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
                }, label: {
                    Text("获取验证码")
                })
                .disabled(accountInput == "" || validate == "")
                SecureField("验证码", text: $passwdInput)
                Section {
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
                        Text("登录")
                    })
                    .disabled(accountInput == "" || passwdInput == "" || validate == "")
                }
            }
            .tag(1)
            .onAppear {
                DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/captcha?source=main_web") { respJson, isSuccess in
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
