//
//  VideoCommentsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import OSLog
import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct VideoCommentsView: View {
    var oid: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var avid = -1
    @State var comments = [[String: String]]()
    var body: some View {
        ScrollView {
            if comments.count != 0 {
                ForEach(0...comments.count - 1, id: \.self) { i in
                    VStack {
                        HStack {
                            WebImage(url: URL(string: comments[i]["SenderPic"]! + "@30w"), options: [.progressiveLoad])
                                .cornerRadius(100)
                            VStack {
                                HStack {
                                    Text(comments[i]["Sender"]!)
                                        .font(.system(size: 14, weight: .bold))
                                        .lineLimit(1)
//                                    switch Int(comments[i]["SenderLevel"]!)! {
//                                    case 0:
//                                        Image("Lv0Icon")
//                                    case 1:
//                                        Image("Lv1Icon")
//                                    case 2:
//                                        Image("Lv2Icon")
//                                    case 3:
//                                        Image("Lv3Icon")
//                                    case 4:
//                                        Image("Lv4Icon")
//                                    case 5:
//                                        Image("Lv5Icon")
//                                    case 6:
//                                        Image("Lv6Icon")
//                                    case 7:
//                                        Image("Lv7Icon")
//                                    case 8:
//                                        Image("Lv8Icon")
//                                    case 9:
//                                        Image("Lv9Icon")
//                                    default:
//                                        Image("Lv9Icon")
//                                    }
                                }
                                Text(comments[i]["IP"]!)
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                        HStack {
                            Text(comments[i]["Text"]!)
                                .font(.system(size: 16, weight: .bold))
                                .lineLimit(8)
                            Spacer()
                        }
                        HStack {
                            Label("", systemImage: comments[i]["UserAction"]! == "1" ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(comments[i]["UserAction"]! == "1" ? Color(hex: 0xfa678e) : .white)
                                .lineLimit(1)
                                .onTapGesture {
                                    AF.request("https://api.bilibili.com/x/v2/reply/action", method: .post, parameters: BiliCommentLike(oid: avid, rpid: Int(comments[i]["Rpid"]!)!, action: comments[i]["UserAction"]! == "1" ? 0 : 1, csrf: biliJct)).response { response in
                                        debugPrint(response)
                                        
                                        comments[i]["UserAction"]! = comments[i]["UserAction"]! == "1" ? "0" : "1"
                                    }
                                }
                            Spacer()
                        }
                        Divider()
                    }
                }
            }
        }
        .onAppear {
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/toav/\(oid)") { respStr, isSuccess in
                if isSuccess {
                    avid = Int(respStr)!
                    debugPrint(avid)
                    let headers: HTTPHeaders = [
                        "cookie": "SESSDATA=\(sessdata);"
                    ]
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/reply?type=1&oid=\(avid)&sort=1&ps=3&pn=1", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            let replies = respJson["data"]["replies"]
                            for reply in replies {
                                comments.append(["Text": reply.1["content"]["message"].string!, "Sender": reply.1["member"]["uname"].string!, "SenderPic": reply.1["member"]["avatar"].string!, "SenderLevel": String(reply.1["member"]["level_info"]["current_level"].int!), "IP": reply.1["reply_control"]["location"].string!, "UserAction": String(reply.1["action"].int!), "Rpid": String(reply.1["rpid"].int!)])
                            }
                        } else {
                            Logger().error("There is a error when request comments from Bilibili server")
                        }
                    }
                } else {
                    Logger().error("There is a error when request avid from Darock server")
                }
            }
        }
    }
}

struct BiliCommentLike: Codable {
    var type: Int = 1
    let oid: Int
    let rpid: Int
    let action: Int
    let csrf: String
}

#Preview {
    VideoCommentsView(oid: "1tV4y1379v")
}
