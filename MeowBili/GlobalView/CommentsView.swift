//
//
//  CommentsView.swift
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

import OSLog
import SwiftUI
import DarockUI
import Alamofire
import SwiftyJSON
import DarockFoundation
import SDWebImageSwiftUI

struct CommentsView: View {
    var oid: String
    var type: Int = 1
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var id = ""
    @State var comments = [[String: String]]()
    @State var sepTexts = [[String]]()
    @State var emojiUrls = [[String]]()
    @State var isEmoted = [Bool]()
    @State var commentReplies = [[[String: String]]]()
    @State var nowPage = 1
    @State var isSenderDetailsPresented = [Bool]()
    @State var isLoaded = false
    @State var isSendCommentPresented = false
    @State var isNoMore = false
    @State var presentRepliesGoto = ""
    @State var presentRepliesRootData = [String: String]()
    @State var isCommentRepliesPresented = false
    @State var presentImageItem: String?
    var body: some View {
        ScrollView {
            VStack {
                if comments.count != 0 {
                    ForEach(0...comments.count - 1, id: \.self) { i in
                        VStack {
                            HStack {
                                WebImage(url: URL(string: comments[i]["SenderPic"]!))
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(comments[i]["Sender"]!)
                                            .font(.system(size: 14, weight: .bold))
                                            .lineLimit(1)
                                    }
                                    Text(comments[i]["IP"]!)
                                        .font(.system(size: 10))
                                        .lineLimit(1)
                                        .opacity(0.6)
                                }
                                .navigationDestination(isPresented: $isSenderDetailsPresented[i], destination: { UserDetailView(uid: comments[i]["SenderID"]!) })
                                Spacer()
                                if comments[i]["IsPinned"] == "true" {
                                    Image(systemName: "pin.fill")
                                        .foregroundStyle(.accent)
                                        .rotationEffect(.degrees(45))
                                }
                            }
                            .onTapGesture {
                                isSenderDetailsPresented[i] = true
                            }
                            HStack {
                                #if !os(watchOS)
                                CopyableView(comments[i]["Text"]!) {
                                    Text(comments[i]["Text"]!)
                                        .font(.system(size: 16, weight: .bold))
                                        .lineLimit((comments[i]["isFull"] ?? "false") == "true" ? 1000 : 8)
                                        .onTapGesture {
                                            comments[i].updateValue((comments[i]["isFull"] ?? "false") == "true" ? "false" : "true", forKey: "isFull")
                                        }
                                }
                                #else
                                Text(comments[i]["Text"]!)
                                    .font(.system(size: 16, weight: .bold))
                                    .lineLimit((comments[i]["isFull"] ?? "false") == "true" ? 1000 : 8)
                                    .onTapGesture {
                                        comments[i].updateValue((comments[i]["isFull"] ?? "false") == "true" ? "false" : "true", forKey: "isFull")
                                    }
                                #endif
                                Spacer()
                            }
                            if !comments[i]["Pictures"]!.isEmpty {
                                let picUrls = comments[i]["Pictures"]!.components(separatedBy: "|")
                                ForEach(0..<picUrls.count, id: \.self) { i in
                                    WebImage(url: URL(string: picUrls[i] + "@200w_150h_0e"))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxHeight: 100)
                                        .clipped()
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            presentImageItem = picUrls[i]
                                        }
                                }
                            }
                            if commentReplies[i].count != 0 {
                                VStack {
                                    ForEach(0...commentReplies[i].count - 1, id: \.self) { j in
                                        Button(action: {
                                            presentRepliesGoto = commentReplies[i][j]["Rpid"]!
                                            presentRepliesRootData = comments[i]
                                            isCommentRepliesPresented = true
                                        }, label: {
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
                                .wrapIf({ if #available(iOS 26.0, watchOS 26.0, *) { true } else { false } }()) { content in
                                    if #available(iOS 26.0, watchOS 26.0, *) {
                                        content
                                            .glassEffect(in: RoundedRectangle(cornerRadius: 7))
                                    }
                                } else: { content in
                                    content
                                        .background {
                                            RoundedRectangle(cornerRadius: 7)
                                                .foregroundColor(.white)
                                                .opacity(0.5)
                                        }
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
                                            "cookie": "SESSDATA=\(sessdata)",
                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                        ]
                                        AF.request("https://api.bilibili.com/x/v2/reply/action", method: .post, parameters: BiliCommentLike(type: type, oid: id, rpid: Int64(comments[i]["Rpid"]!)!, action: comments[i]["UserAction"]! == "1" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
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
                                            "cookie": "SESSDATA=\(sessdata)",
                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                        ]
                                        AF.request("https://api.bilibili.com/x/v2/reply/hate", method: .post, parameters: BiliCommentLike(type: type, oid: id, rpid: Int64(comments[i]["Rpid"]!)!, action: comments[i]["UserAction"]! == "2" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
                                            debugPrint(response)
                                            comments[i]["UserAction"]! = comments[i]["UserAction"]! == "2" ? "0" : "2"
                                        }
                                    }
                                Spacer()
                            }
                            Divider()
                        }
                        .padding(5)
                    }
                    if !isNoMore {
                        Button(action: {
                            nowPage += 1
                            ContinueLoadComment()
                        }, label: {
                            Text("Home.more")
                                .bold()
                        })
#if !os(watchOS)
                        .buttonStyle(.borderedProminent)
#endif
                    }
                } else {
                    if isNoMore {
                        Text("什么都木有")
                    } else {
                        ProgressView()
                    }
                }
            }
#if !os(watchOS)
            .padding(.horizontal)
#endif
            .sheet(isPresented: $isCommentRepliesPresented, content: { CommentRepliesView(avid: id, type: type, goto: $presentRepliesGoto, rootData: $presentRepliesRootData) })
        }
        .sheet(item: $presentImageItem) { url in
            ImageViewerView(url: url)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isSendCommentPresented = true
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
                .sheet(isPresented: $isSendCommentPresented, content: { CommentSendView(oid: oid, type: type) })
            }
        }
        .onAppear {
            if !isLoaded {
                ContinueLoadComment()
                isLoaded = true
            }
        }
    }
    
    func ContinueLoadComment() {
        if Int(oid) == nil, type == 1 {
            id = String(bv2av(bvid: oid))
        } else {
            id = oid
        }
        debugPrint(id)
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);",
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        requestJSON("https://api.bilibili.com/x/v2/reply?type=\(type)&oid=\(id)&sort=1&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                DispatchQueue(label: "com.darock.DarockBili.Comment-Load", qos: .background).async {
                    debugPrint(respJson)
                    if !CheckBApiError(from: respJson) { return }
                    let replies = respJson["data"]["replies"]
                    if replies.count == 0 {
                        isNoMore = true
                        return
                    }
                    var calNum = 0
                    for reply in replies {
                        isSenderDetailsPresented.append(false)
                        let repliesInComment = reply.1["replies"]
                        commentReplies.append([])
                        for sigReply in repliesInComment {
                            commentReplies[calNum].append(["Text": sigReply.1["content"]["message"].string ?? "[加载失败]", "Sender": sigReply.1["member"]["uname"].string ?? "[加载失败]", "SenderPic": sigReply.1["member"]["avatar"].string ?? "E", "SenderID": sigReply.1["member"]["mid"].string ?? "E", "IP": sigReply.1["reply_control"]["location"].string ?? "", "UserAction": String(sigReply.1["action"].int ?? 0), "Rpid": String(sigReply.1["rpid"].int ?? -1), "Like": String(sigReply.1["like"].int ?? -1)])
                        }
                        let text = reply.1["content"]["message"].string ?? "[加载失败]"
                        var pictures = [String]()
                        for pic in reply.1["content"]["pictures"].arrayValue {
                            pictures.append(pic["img_src"].string ?? "[加载失败]")
                        }
                        var emoteInfo = ""
                        for (emote, info) in reply.1["content"]["emote"].dictionaryValue {
                            emoteInfo += "|\(emote)::\(info["url"].stringValue)"
                        }
                        comments.append(["Text": text, "Sender": reply.1["member"]["uname"].string ?? "[加载失败]", "SenderPic": reply.1["member"]["avatar"].string ?? "E", "SenderID": reply.1["member"]["mid"].string ?? "E", "IP": reply.1["reply_control"]["location"].string ?? "", "UserAction": String(reply.1["action"].int ?? 0), "Rpid": reply.1["rpid_str"].string ?? "-1", "Like": String(reply.1["like"].int ?? -1), "Pictures": pictures.joined(separator: "|"), "EmoteInfo": emoteInfo])
                        calNum += 1
                    }
                    // Pinned comment
                    if nowPage == 1 && respJson["data"]["upper"]["top"].null == nil {
                        let reply = respJson["data"]["upper"]["top"]
                        isSenderDetailsPresented.insert(false, at: 0)
                        let repliesInComment = reply["replies"]
                        commentReplies.insert([], at: 0)
                        for sigReply in repliesInComment {
                            commentReplies[0].append(["Text": sigReply.1["content"]["message"].string ?? "[加载失败]", "Sender": sigReply.1["member"]["uname"].string ?? "[加载失败]", "SenderPic": sigReply.1["member"]["avatar"].string ?? "E", "SenderID": sigReply.1["member"]["mid"].string ?? "E", "IP": sigReply.1["reply_control"]["location"].string ?? "", "UserAction": String(sigReply.1["action"].int ?? 0), "Rpid": String(sigReply.1["rpid"].int ?? -1), "Like": String(sigReply.1["like"].int ?? -1)])
                        }
                        let text = reply["content"]["message"].string ?? "[加载失败]"
                        var pictures = [String]()
                        for pic in reply["content"]["pictures"].arrayValue {
                            pictures.append(pic["img_src"].string ?? "[加载失败]")
                        }
                        var emoteInfo = ""
                        for (emote, info) in reply["content"]["emote"].dictionaryValue {
                            emoteInfo += "|\(emote)::\(info["url"].stringValue)"
                        }
                        comments.insert(["Text": text, "Sender": reply["member"]["uname"].string ?? "[加载失败]", "SenderPic": reply["member"]["avatar"].string ?? "E", "SenderID": reply["member"]["mid"].string ?? "E", "IP": reply["reply_control"]["location"].string ?? "", "UserAction": String(reply["action"].int ?? 0), "Rpid": reply["rpid_str"].string ?? "-1", "Like": String(reply["like"].int ?? -1), "Pictures": pictures.joined(separator: "|"), "EmoteInfo": emoteInfo, "IsPinned": "true"], at: 0)
                    }
                }
            } else {
                Logger().error("There is an error when request comments from Bilibili server")
            }
        }
    }
    
    struct CommentRepliesView: View {
        var avid: String
        var type: Int
        @Binding var goto: String
        @Binding var rootData: [String: String]
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var replies = [[String: String]]()
        @State var isSenderDetailsPresented = [Bool]()
        @State var currentPresentationDetent = PresentationDetent.medium
        var body: some View {
            NavigationStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack {
                            if replies.count != 0 {
                                ForEach(0...replies.count - 1, id: \.self) { i in
                                    VStack {
                                        HStack {
                                            WebImage(url: URL(string: replies[i]["SenderPic"]!))
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .clipShape(Circle())
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Text(replies[i]["Sender"]!)
                                                        .font(.system(size: 14, weight: .bold))
                                                        .lineLimit(1)
                                                }
                                                Text(replies[i]["IP"]!)
                                                    .font(.system(size: 10))
                                                    .lineLimit(1)
                                                    .opacity(0.6)
                                            }
                                            .navigationDestination(isPresented: $isSenderDetailsPresented[i], destination: { UserDetailView(uid: replies[i]["SenderID"]!) })
                                            Spacer()
                                        }
                                        .onTapGesture {
                                            isSenderDetailsPresented[i] = true
                                            currentPresentationDetent = .large
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
                                                        "cookie": "SESSDATA=\(sessdata)",
                                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                    ]
                                                    AF.request("https://api.bilibili.com/x/v2/reply/action", method: .post, parameters: BiliCommentLike(type: type, oid: avid, rpid: Int64(replies[i]["Rpid"]!)!, action: replies[i]["UserAction"]! == "1" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
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
                                                        "cookie": "SESSDATA=\(sessdata)",
                                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                    ]
                                                    AF.request("https://api.bilibili.com/x/v2/reply/hate", method: .post, parameters: BiliCommentLike(type: type, oid: avid, rpid: Int64(replies[i]["Rpid"]!)!, action: replies[i]["UserAction"]! == "2" ? 0 : 1, csrf: biliJct), headers: headers).response { response in
                                                        debugPrint(response)
                                                        replies[i]["UserAction"]! = replies[i]["UserAction"]! == "2" ? "0" : "2"
                                                    }
                                                }
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                    .id(replies[i]["Rpid"]!)
                                    .padding(5)
                                }
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    .onAppear {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata);",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        debugPrint("https://api.bilibili.com/x/v2/reply/reply?type=\(type)&oid=\(avid)&root=\(rootData["Rpid"]!)")
                        requestJSON("https://api.bilibili.com/x/v2/reply/reply?type=\(type)&oid=\(avid)&root=\(rootData["Rpid"]!)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                debugPrint(respJson)
                                if !CheckBApiError(from: respJson) { return }
                                for reply in respJson["data"]["replies"] {
                                    isSenderDetailsPresented.append(false)
                                    var emoteInfo = ""
                                    for (emote, info) in reply.1["content"]["emote"].dictionaryValue {
                                        emoteInfo += "|\(emote)::\(info["url"].stringValue)"
                                    }
                                    replies.append(["Text": reply.1["content"]["message"].string ?? "[加载失败]", "Sender": reply.1["member"]["uname"].string ?? "[加载失败]", "SenderPic": reply.1["member"]["avatar"].string ?? "E", "SenderID": reply.1["member"]["mid"].string ?? "E", "IP": reply.1["reply_control"]["location"].string ?? "", "UserAction": String(reply.1["action"].int ?? 0), "Rpid": reply.1["rpid_str"].string ?? "-1", "Like": String(reply.1["like"].int ?? -1), "EmoteInfo": emoteInfo])
                                }
                            }
                        }
                        
                        proxy.scrollTo(goto, anchor: .top)
                    }
                }
                .navigationTitle("评论回复")
            }
            .presentationDetents([.medium, .large], selection: $currentPresentationDetent)
        }
    }
    struct CommentSendView: View {
        var oid: String
        var type: Int
        @Environment(\.presentationMode) var presentationMode
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var sendCommentCache = ""
        @State var isSendingComment = false
        @State var id = ""
        var body: some View {
            NavigationStack {
                VStack {
                    if !isSendingComment {
                        TextField("Comment.send", text: $sendCommentCache) {
                            if sendCommentCache != "" {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                AF.request("https://api.bilibili.com/x/v2/reply/add", method: .post, parameters: BiliSubmitComment(type: type, oid: id, message: sendCommentCache, csrf: biliJct), headers: headers).response { response in
                                    sendCommentCache = ""
                                    debugPrint(response)
                                    isSendingComment = false
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                        #if !os(watchOS)
                            .textFieldStyle(.roundedBorder)
                        #endif
                            .submitLabel(.send)
                        Spacer()
                    } else {
                        ProgressView()
                    }
                }
                .navigationTitle("发送评论")
                .padding(.horizontal)
            }
            .onAppear {
                if Int(oid) == nil, type == 1 {
                    id = String(bv2av(bvid: oid))
                } else {
                    id = oid
                }
                debugPrint(id)
            }
        }
    }
}

struct BiliCommentLike: Codable {
    var type: Int
    let oid: String
    let rpid: Int64
    let action: Int
    let csrf: String
}

struct BiliSubmitComment: Codable {
    var type: Int
    let oid: String
    var root: Int?
    var parent: Int?
    let message: String
    let csrf: String
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(oid: "1tV4y1379v")
    }
}
