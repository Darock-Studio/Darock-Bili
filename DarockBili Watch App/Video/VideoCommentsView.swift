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
    @State var isSendCommentPresented = false
    @State var sendCommentCache = ""
    @State var isSendingComment = false
    var body: some View {
        VStack {
            if #available(watchOS 10, *) {
                CommentMainView(oid: oid)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                isSendCommentPresented = true
                            }, label: {
                                Image(systemName: "square.and.pencil")
                            })
                            .sheet(isPresented: $isSendCommentPresented, content: {
                                @Environment(\.dismiss) var dismiss
                                VStack {
                                    if !isSendingComment {
                                        TextField("发送评论...", text: $sendCommentCache)
                                            .onSubmit {
                                                if sendCommentCache != "" {
                                                    let headers: HTTPHeaders = [
                                                        "cookie": "SESSDATA=\(sessdata)"
                                                    ]
                                                    AF.request("https://api.bilibili.com/x/v2/reply/add", method: .post, parameters: BiliSubmitComment(oid: avid, message: sendCommentCache, csrf: biliJct), headers: headers).response { response in
                                                        sendCommentCache = ""
                                                        debugPrint(response)
                                                        isSendingComment = false
                                                        dismiss()
                                                    }
                                                }
                                            }
                                        Spacer()
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .onAppear {
                                    DarockKit.Network.shared.requestString("https://api.darock.top/bili/toav/\(oid)") { respStr, isSuccess in
                                        if isSuccess {
                                            avid = Int(respStr)!
                                            debugPrint(avid)
                                        }
                                    }
                                }
                            })
                        }
                    }
            } else {
                CommentMainView(oid: oid)
            }
        }
        
    }
    
    struct CommentMainView: View {
        var oid: String
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var avid = -1
        @State var comments = [[String: String]]()
        @State var nowPage = 1
        @State var isSenderDetailsPresented = [Bool]()
        @State var commentOffsets = [CGFloat]()
        var body: some View {
            ScrollView {
                LazyVStack {
                    if comments.count != 0 {
                        ForEach(0...comments.count - 1, id: \.self) { i in
                            VStack {
                                HStack {
                                    WebImage(url: URL(string: comments[i]["SenderPic"]! + "@30w"), options: [.progressiveLoad])
                                        .cornerRadius(100)
                                    VStack {
                                        NavigationLink("", isActive: $isSenderDetailsPresented[i], destination: {UserDetailView(uid: comments[i]["SenderID"]!)})
                                            .frame(width: 0, height: 0)
                                        HStack {
                                            Text(comments[i]["Sender"]!)
                                                .font(.system(size: 14, weight: .bold))
                                                .lineLimit(1)
                                        }
                                        Text(comments[i]["IP"]!)
                                            .font(.system(size: 10))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                }
                                .onTapGesture {
                                    isSenderDetailsPresented[i] = true
                                }
                                HStack {
                                    //                            Text({ () -> String in
                                    //                                var showText = comments[i]["Text"]!
                                    //                                if comments[i]["Text"]!.contains("[") && comments[i]["Text"]!.contains("]") {
                                    //                                    var emojiNames = [String]()
                                    //                                    let textSpd = comments[i]["Text"]!.split(separator: "[")
                                    //                                    for text in textSpd {
                                    //                                        emojiNames.append(String(text.split(separator: "]")[0]))
                                    //                                    }
                                    //                                    var emojiLinks = [String]()
                                    //                                    for name in emojiNames {
                                    //                                        emojiLinks.append(biliEmojiDictionary[name] ?? name)
                                    //                                    }
                                    //                                    for i in 0...emojiLinks.count - 1 {
                                    //                                        showText = showText.replacingOccurrences(of: "[\(emojiNames[i])]", with: "\(AsyncImage(url: URL(string: emojiLinks[i])))")
                                    //                                    }
                                    //                                }
                                    //                                return showText
                                    //                            }())
                                    Text(comments[i]["Text"]!)
                                        .font(.system(size: 16, weight: .bold))
                                        .lineLimit((comments[i]["isFull"] ?? "false") == "true" ? 1000 : 8)
                                        .onTapGesture {
                                            comments[i].updateValue((comments[i]["isFull"] ?? "false") == "true" ? "false" : "true", forKey: "isFull")
                                        }
                                    Spacer()
                                }
                                HStack {
                                    Label(comments[i]["Like"]!, systemImage: comments[i]["UserAction"]! == "1" ? "hand.thumbsup.fill" : "hand.thumbsup")
                                        .font(.system(size: 14))
                                        .foregroundColor(comments[i]["UserAction"]! == "1" ? Color(hex: 0xF889BA) : .white)
                                        .lineLimit(1)
                                        .opacity(comments[i]["UserAction"]! == "1" ? 1 : 0.6)
                                        .onTapGesture {
                                            let headers: HTTPHeaders = [
                                                "cookie": "SESSDATA=\(sessdata)"
                                            ]
                                            AF.request("https://api.bilibili.com/x/v2/reply/action", method: .post, parameters: BiliCommentLike(oid: avid, rpid: Int(comments[i]["Rpid"]!)!, action: comments[i]["UserAction"]! == "1" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
                                                debugPrint(response)
                                                
                                                comments[i]["UserAction"]! = comments[i]["UserAction"]! == "1" ? "0" : "1"
                                            }
                                        }
                                    Label("", systemImage: comments[i]["UserAction"]! == "2" ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                        .font(.system(size: 14))
                                        .foregroundColor(comments[i]["UserAction"]! == "2" ? Color(hex: 0xF889BA) : .white)
                                        .lineLimit(1)
                                        .opacity(comments[i]["UserAction"]! == "2" ? 1 : 0.6)
                                        .onTapGesture {
                                            let headers: HTTPHeaders = [
                                                "cookie": "SESSDATA=\(sessdata)"
                                            ]
                                            AF.request("https://api.bilibili.com/x/v2/reply/hate", method: .post, parameters: BiliCommentLike(oid: avid, rpid: Int(comments[i]["Rpid"]!)!, action: comments[i]["UserAction"]! == "2" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
                                                debugPrint(response)
                                                
                                                comments[i]["UserAction"]! = comments[i]["UserAction"]! == "2" ? "0" : "2"
                                            }
                                        }
                                    Spacer()
                                }
                                Divider()
                            }
                            .padding(5)
                            .offset(y: commentOffsets[i])
                            .animation(.easeOut(duration: 0.4), value: commentOffsets[i])
                            .onAppear {
                                commentOffsets[i] = 0
                            }
                        }
                        Button(action: {
                            nowPage += 1
                            ContinueLoadComment()
                        }, label: {
                            Text("继续加载")
                                .bold()
                        })
                    }
                }
            }
            .onAppear {
                ContinueLoadComment()
            }
            .onDisappear {
                nowPage = 1
                comments = [[String: String]]()
                SDImageCache.shared.clearMemory()
            }
        }
        
        func ContinueLoadComment() {
            DarockKit.Network.shared.requestString("https://api.darock.top/bili/toav/\(oid)") { respStr, isSuccess in
                if isSuccess {
                    avid = Int(respStr)!
                    debugPrint(avid)
                    let headers: HTTPHeaders = [
                        "cookie": "SESSDATA=\(sessdata);"
                    ]
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/reply?type=1&oid=\(avid)&sort=1&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            let replies = respJson["data"]["replies"]
                            for reply in replies {
                                isSenderDetailsPresented.append(false)
                                commentOffsets.append(20)
                                comments.append(["Text": reply.1["content"]["message"].string!, "Sender": reply.1["member"]["uname"].string!, "SenderPic": reply.1["member"]["avatar"].string!, "SenderID": reply.1["member"]["mid"].string!, "IP": reply.1["reply_control"]["location"].string ?? "", "UserAction": String(reply.1["action"].int!), "Rpid": String(reply.1["rpid"].int!), "Like": String(reply.1["like"].int!)])
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

struct BiliSubmitComment: Codable {
    var type: Int = 1
    let oid: Int
    var root: Int? = nil
    var parent: Int? = nil
    let message: String
    let csrf: String
}

struct VideoCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCommentsView(oid: "1tV4y1379v")
    }
}
