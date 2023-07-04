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
    
    //---QR Login---
    @State var qrImage: CGImage?
    @State var qrKey = ""
    @State var isScanned = false
    @State var qrTimer: Timer?
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
            
            
            List {
                Section {
                    TextField("账号", text: $accountInput)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("密码", text: $passwdInput)
                }
                Section {
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
                }
                Section {
                    Button(action: {
                        DarockKit.Network.shared.requestJSON("https://passport.bilibili.com/x/passport-login/web/key") { respJson, isSuccess in
                            if isSuccess {
                                salt = respJson["data"]["hash"].string!
                                publicKey = respJson["data"]["key"].string!
                                DarockKit.Network.shared.requestString("https://api.darock.top/bili/passwd/encrypt/\(passwdInput)/\(salt)/\(publicKey.base64Encoded())") { respStr, isSuccess in
                                    if isSuccess {
                                        let encedPwd = respStr.apiFixed()
                                        debugPrint(encedPwd)
                                        let headers: HTTPHeaders = [
                                            "Accept": "application/json, text/plain, */*",
                                            "Accept-Encoding": "gzip, deflate, br",
                                            "Accept-Language": "zh-CN,zh-Hans;q=0.9",
                                            "cookie": "browser_resolution=1589-508; FEED_LIVE_VERSION=V_NO_BANNER_3; buvid4=818BA302-8EAC-0630-67AB-BB978A5797AF60982-023042618-ho21%2BqF6LZokzAShrGptM4EHZm2TE4%2FTXmfZyPpzfCnLuUmUckb8wg%3D%3D; buvid_fp=087ddcc55a832e51e27f6d86c4c6d949; header_theme_version=CLOSE; home_feed_column=5; innersign=0; sid=52zgqw2f; buvid_fp_plain=undefined; b_lsid=49F4B85E_1890FC90708; fingerprint=087ddcc55a832e51e27f6d86c4c6d949; CURRENT_FNVAL=4048; bp_t_offset_356891781=812530614670458945; PVID=1; i-wanna-go-back=-1; nostalgia_conf=-1; b_ut=5; CURRENT_QUALITY=80; CURRENT_PID=1c964fe0-e421-11ed-a53e-71daf528d4ad; rpdid=|(J~R~|ulJRu0J'uY)kl|YYJ); _uuid=D4AEF18F-AE6A-846A-2185-11010F1836510E1060766infoc; b_nut=1682504360; buvid3=5C956D5D-918E-680C-0E37-EC4A879CE7D260508infoc",
                                            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
                                            "sec-fetch-dest": "empty",
                                            "sec-fetch-mode": "cors",
                                            "sec-fetch-site": "same-site",
                                            "Host": "passport.bilibili.com",
                                            "Origin": "https://www.bilibili.com",
                                            "referer": "https://www.bilibili.com/"
                                        ]
                                        AF.request("https://passport.bilibili.com/x/passport-login/web/login", method: .post, parameters: BiliLoginPost(username: accountInput, password: encedPwd, token: loginToken, challenge: challenge, validate: validate, seccode: seccode), headers: headers).response { response in
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
                                                    } else if json["data"]["status"].int == 2 {
                                                        
                                                    }
                                                }
                                            }
                                        }
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
        let username: String
        let password: String
        var keep: Int = 0
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
