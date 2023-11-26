//
//  WatchLaterView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
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

struct WatchLaterView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var laters = [[String: String]]()
    var body: some View {
        List {
            if laters.count != 0 {
                ForEach(0...laters.count - 1, id: \.self) { i in
                    VideoCard(laters[i])
                }
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/history/toview", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint(respJson)
                    let datas = respJson["data"]["list"]
                    for data in datas {
                        laters.append(["Title": data.1["title"].string!, "Pic": data.1["pic"].string!, "UP": data.1["owner"]["name"].string!, "View": String(data.1["stat"]["view"].int!), "Danmaku": String(data.1["stat"]["danmaku"].int!), "BV": data.1["bvid"].string!])
                    }
                }
            }
        }
    }
}

struct WatchLaterView_Previews: PreviewProvider {
    static var previews: some View {
        WatchLaterView()
    }
}
