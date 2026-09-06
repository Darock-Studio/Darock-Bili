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
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import Alamofire
import SwiftyJSON
import DarockFoundation

struct LiveMessagesView: View {
    var roomId: Int
    @AppStorage("DedeUserID") private var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") private var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") private var sessdata = ""
    @AppStorage("bili_jct") private var biliJct = ""
    @State private var token = ""
    @State private var server = ""
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
            requestJSON("https://api.live.bilibili.com/xlive/web-room/v1/index/getDanmuInfo?id=\(roomId)", headers: headers) { respJson, isSuccess in
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
