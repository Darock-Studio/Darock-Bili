//
//
//  LiveMessagesiew.swift
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
import Alamofire
import SwiftyJSON

struct LiveMessagesView: View {
    var roomId: Int
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var token = ""
    @State var server = ""
    var body: some View {
        ScrollView {
            VStack {
                
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.live.bilibili.com/xlive/web-room/v1/index/getDanmuInfo?id=\(roomId)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    token = respJson["data"]["token"].string ?? "E"
                    server = respJson["data"]["host_list"][0]["host"].string ?? "E"
                    
                    
                }
            }
        }
    }
}

//#Preview {
//    LiveMessagesView()
//}
