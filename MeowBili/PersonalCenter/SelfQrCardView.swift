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
            Task {
                if let info = await BiliAPI.shared.userInfo() {
                    username = info.name
                    userFaceUrl = info.face
                }
            }
        }
    }
}

#Preview {
    SelfQrCardView()
}
#endif
