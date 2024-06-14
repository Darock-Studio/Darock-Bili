//
//
//  SelfQrCardView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/14.
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

#if !os(watchOS)
import UIKit
import SwiftUI
import EFQRCode
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI
import ScreenshotableView

struct SelfQrCardView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var shotting = false
    @State var username = ""
    @State var userFaceUrl = ""
    @State var qrcodeImg: CGImage?
    var body: some View {
        VStack {
            ScreenshotableView(shotting: $shotting) { image in
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                AlertKitAPI.present(title: "已保存", subtitle: "二维码名片已保存到相册", icon: .done, style: .iOS17AppleMusic, haptic: .success)
            } content: { _ in
                VStack {
                    HStack {
                        WebImage(url: URL(string: userFaceUrl))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        VStack {
                            Text(username)
                                .foregroundColor(.black)
                            Text("UID: \(dedeUserID)")
                                .foregroundColor(.black)
                        }
                        .padding()
                        Spacer()
                    }
                    ZStack {
                        Image("QRCard")
                        if let img = qrcodeImg {
                            Image(uiImage: UIImage(cgImage: img))
                                .resizable()
                                .frame(width: 150, height: 150)
                                .offset(y: -45)
                        }
                    }
                }
                .background(Color(hex: 0xFAFAFD))
                .padding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    shotting.toggle()
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                })
            }
        }
        .onAppear {
            qrcodeImg = EFQRCode.generate(for: "https://space.bilibili.com/\(dedeUserID)", foregroundColor: Color(hex: 0x2b4785).cgColor!)
            
            getBuvid(url: "https://api.bilibili.com/x/space/wbi/acc/info".urlEncoded()) { buvid3, buvid4, _uuid, _ in
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata); innersign=0; buvid3=\(buvid3); b_nut=1704873471; i-wanna-go-back=-1; b_ut=7; b_lsid=9910433CB_18CF260AB89; _uuid=\(_uuid); enable_web_push=DISABLE; header_theme_version=undefined; home_feed_column=4; browser_resolution=3440-1440; buvid4=\(buvid4);",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
                biliWbiSign(paramEncoded: "mid=\(dedeUserID)".base64Encoded()) { signed in
                    if let signed {
                        debugPrint(signed)
                        autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                debugPrint(respJson)
                                if !CheckBApiError(from: respJson) { return }
                                username = respJson["data"]["name"].string ?? ""
                                userFaceUrl = respJson["data"]["face"].string ?? "E"
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SelfQrCardView()
}
#endif
