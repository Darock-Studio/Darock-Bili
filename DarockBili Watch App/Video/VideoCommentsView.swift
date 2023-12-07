//
//  VideoCommentsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
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
    @State var isSendCommentPresented = false
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
                            .sheet(isPresented: $isSendCommentPresented, content: {CommentSendView(oid: oid)})
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
        @State var avid: UInt64 = 0
        @State var comments = [[String: String]]()
        @State var sepTexts = [[String]]()
        @State var emojiUrls = [[String]]()
        @State var isEmoted = [Bool]()
        @State var commentReplies = [[[String: String]]]()
        @State var nowPage = 1
        @State var isSenderDetailsPresented = [Bool]()
        @State var commentOffsets = [CGFloat]()
        @State var isLoaded = false
        @State var isSendCommentPresented = false
        var body: some View {
            ScrollView {
                LazyVStack {
                    #if swift(>=5.9)
                    if #unavailable(watchOS 10) {
                        Button(action: {
                            isSendCommentPresented = true
                        }, label: {
                            HStack {
                                Image(systemName: "square.and.pencil")
                                Text("发送评论")
                            }
                        })
                        .sheet(isPresented: $isSendCommentPresented, content: {CommentSendView(oid: oid)})
                    }
                    #else
                    Button(action: {
                        isSendCommentPresented = true
                    }, label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("发送评论")
                        }
                    })
                    .sheet(isPresented: $isSendCommentPresented, content: {CommentSendView(oid: oid)})
                    #endif
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
//                                    if isEmoted[i] {
//                                        ForEach(Array(zip(0..<emojiUrls[i].count, sepTexts[i])), id: \.0) { count, component in
//                                            AsyncImage(url: URL(string: emojiUrls[i][count])) { phase in
//                                                if let image = phase.image {
//                                                    Text(component) + Text(image)
//                                                }
//                                            }
//                                        }
//                                        //Text(comments[i]["Text"]!)
//                                        .font(.system(size: 16, weight: .bold))
//                                        .lineLimit((comments[i]["isFull"] ?? "false") == "true" ? 1000 : 8)
//                                        .onTapGesture {
//                                            comments[i].updateValue((comments[i]["isFull"] ?? "false") == "true" ? "false" : "true", forKey: "isFull")
//                                        }
//                                    } else {
                                        Text(comments[i]["Text"]!)
                                            .font(.system(size: 16, weight: .bold))
                                            .lineLimit((comments[i]["isFull"] ?? "false") == "true" ? 1000 : 8)
                                            .onTapGesture {
                                                comments[i].updateValue((comments[i]["isFull"] ?? "false") == "true" ? "false" : "true", forKey: "isFull")
                                            }
//                                    }
                                    Spacer()
                                }
                                if commentReplies[i].count != 0 {
                                    VStack {
                                        ForEach(0...commentReplies[i].count - 1, id: \.self) { j in
                                            NavigationLink(destination: {CommentRepliesView(avid: avid, replies: commentReplies[i], goto: commentReplies[i][j]["Rpid"]!)}, label: {
                                                HStack {
                                                    Text("\(Text(commentReplies[i][j]["Sender"]! + ":").foregroundColor(.blue)) \(commentReplies[i][j]["Text"]!)")
                                                        .font(.system(size: 12))
                                                        .lineLimit(1)
                                                    Spacer()
                                                }
                                            })
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 7)
                                            .foregroundColor(.white)
                                            .opacity(0.5)
                                    }
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
                    } else {
                        ProgressView()
                    }
                }
            }
            .onAppear {
                if !isLoaded {
                    ContinueLoadComment()
                    isLoaded = true
                }
            }
//            .onDisappear {
//                nowPage = 1
//                comments = [[String: String]]()
//                SDImageCache.shared.clearMemory()
//            }
        }
        
        func ContinueLoadComment() {
            avid = bv2av(bvid: oid)
            debugPrint(avid)
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/reply?type=1&oid=\(avid)&sort=1&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint(respJson)
                    let replies = respJson["data"]["replies"]
                    var calNum = 0
                    for reply in replies {
                        isSenderDetailsPresented.append(false)
                        commentOffsets.append(20)
                        let repliesInComment = reply.1["replies"]
                        commentReplies.append([])
                        for sigReply in repliesInComment {
                            commentReplies[calNum].append(["Text": sigReply.1["content"]["message"].string ?? "[加载失败]", "Sender": sigReply.1["member"]["uname"].string ?? "[加载失败]", "SenderPic": sigReply.1["member"]["avatar"].string ?? "E", "SenderID": sigReply.1["member"]["mid"].string ?? "E", "IP": sigReply.1["reply_control"]["location"].string ?? "", "UserAction": String(sigReply.1["action"].int ?? 0), "Rpid": String(sigReply.1["rpid"].int ?? -1), "Like": String(sigReply.1["like"].int ?? -1)])
                        }
                        let text = reply.1["content"]["message"].string ?? "[加载失败]"
                        comments.append(["Text": text, "Sender": reply.1["member"]["uname"].string ?? "[加载失败]", "SenderPic": reply.1["member"]["avatar"].string ?? "E", "SenderID": reply.1["member"]["mid"].string ?? "E", "IP": reply.1["reply_control"]["location"].string ?? "", "UserAction": String(reply.1["action"].int ?? 0), "Rpid": String(reply.1["rpid"].int ?? -1), "Like": String(reply.1["like"].int ?? -1)])
//                      sepTexts.append([])
//                      isEmoted.append(false)
//                      // 文本中包含表情
//                      if text.range(of: "\\[(.*?)\\]", options: .regularExpression) != nil {
//                          let regex = try! NSRegularExpression(pattern: "\\[(.*?)\\]")
//                          debugPrint("Contains")
//                          // 分割文本，同时去除表情
//                          let tmpSpdText = regex.stringByReplacingMatches(in: text, range: NSRange(text.startIndex..<text.endIndex, in: text), withTemplate: "|").split(separator: "|").map {
//                              String($0)
//                          }
//                          debugPrint(tmpSpdText)
//                          for text in tmpSpdText {
//                              sepTexts[calNum].append(String(text))
//                          }
//                          // 正则获取表情
//                          let emojis = regex.matches(in: text, range: NSRange(text.startIndex..., in: text)).map {
//                              String(text[Range($0.range, in: text)!])
//                          }
//                          let jEmotes = reply.1["content"]["emote"]
//                          debugPrint(jEmotes)
//                          // 获取表情对应URL
//                          emojiUrls.append([])
//                          for emoji in emojis {
//                              if let sigEUrl = jEmotes[emoji].string {
//                                  emojiUrls[calNum].append(sigEUrl)
//                              }
//                          }
//                          isEmoted[calNum] = true
//                          debugPrint(emojiUrls)
//                      } else {
//                          
//                      }
                        calNum += 1
                    }
                } else {
                    Logger().error("There is an error when request comments from Bilibili server")
                }
            }
        }
        
        struct CommentRepliesView: View {
            var avid: Int
            @State var replies: [[String: String]]
            var goto: String? = nil
            @AppStorage("DedeUserID") var dedeUserID = ""
            @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
            @AppStorage("SESSDATA") var sessdata = ""
            @AppStorage("bili_jct") var biliJct = ""
            @State var isSenderDetailsPresented = [Bool]()
            @State var commentOffsets = [CGFloat]()
            var body: some View {
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack {
                            if isSenderDetailsPresented.count >= replies.count {
                                ForEach(0...replies.count - 1, id: \.self) { i in
                                    VStack {
                                        HStack {
                                            WebImage(url: URL(string: replies[i]["SenderPic"]! + "@30w"), options: [.progressiveLoad])
                                                .cornerRadius(100)
                                            VStack {
                                                NavigationLink("", isActive: $isSenderDetailsPresented[i], destination: {UserDetailView(uid: replies[i]["SenderID"]!)})
                                                    .frame(width: 0, height: 0)
                                                HStack {
                                                    Text(replies[i]["Sender"]!)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .lineLimit(1)
                                                }
                                                Text(replies[i]["IP"]!)
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
                                            Text(replies[i]["Text"]!)
                                                .font(.system(size: 16, weight: .bold))
                                                .lineLimit((replies[i]["isFull"] ?? "false") == "true" ? 1000 : 8)
                                                .onTapGesture {
                                                    replies[i].updateValue((replies[i]["isFull"] ?? "false") == "true" ? "false" : "true", forKey: "isFull")
                                                }
                                            Spacer()
                                        }
                                        HStack {
                                            Label(replies[i]["Like"]!, systemImage: replies[i]["UserAction"]! == "1" ? "hand.thumbsup.fill" : "hand.thumbsup")
                                                .font(.system(size: 14))
                                                .foregroundColor(replies[i]["UserAction"]! == "1" ? Color(hex: 0xF889BA) : .white)
                                                .lineLimit(1)
                                                .opacity(replies[i]["UserAction"]! == "1" ? 1 : 0.6)
                                                .onTapGesture {
                                                    let headers: HTTPHeaders = [
                                                        "cookie": "SESSDATA=\(sessdata)"
                                                    ]
                                                    AF.request("https://api.bilibili.com/x/v2/reply/action", method: .post, parameters: BiliCommentLike(oid: avid, rpid: Int(replies[i]["Rpid"]!)!, action: replies[i]["UserAction"]! == "1" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
                                                        debugPrint(response)
                                                        
                                                        replies[i]["UserAction"]! = replies[i]["UserAction"]! == "1" ? "0" : "1"
                                                    }
                                                }
                                            Label("", systemImage: replies[i]["UserAction"]! == "2" ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                                .font(.system(size: 14))
                                                .foregroundColor(replies[i]["UserAction"]! == "2" ? Color(hex: 0xF889BA) : .white)
                                                .lineLimit(1)
                                                .opacity(replies[i]["UserAction"]! == "2" ? 1 : 0.6)
                                                .onTapGesture {
                                                    let headers: HTTPHeaders = [
                                                        "cookie": "SESSDATA=\(sessdata)"
                                                    ]
                                                    AF.request("https://api.bilibili.com/x/v2/reply/hate", method: .post, parameters: BiliCommentLike(oid: avid, rpid: Int(replies[i]["Rpid"]!)!, action: replies[i]["UserAction"]! == "2" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
                                                        debugPrint(response)
                                                        
                                                        replies[i]["UserAction"]! = replies[i]["UserAction"]! == "2" ? "0" : "2"
                                                    }
                                                }
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                    .tag(replies[i]["Rpid"]!)
                                    .padding(5)
                                    .offset(y: commentOffsets[i])
                                    .animation(.easeOut(duration: 0.4), value: commentOffsets[i])
                                    .onAppear {
                                        commentOffsets[i] = 0
                                    }
                                }
                            }
                        }
                        .onAppear {
                            if goto != nil {
                                proxy.scrollTo(goto!, anchor: .top)
                            }
                            for _ in replies {
                                commentOffsets.append(20)
                                isSenderDetailsPresented.append(false)
                            }
                        }
                    }
                }
            }
        }
    }
    struct CommentSendView: View {
        var oid: String
        @Environment(\.dismiss) var dismiss
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var sendCommentCache = ""
        @State var isSendingComment = false
        @State var avid = -1
        var body: some View {
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
