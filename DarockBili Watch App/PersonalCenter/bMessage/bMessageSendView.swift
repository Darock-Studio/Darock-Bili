//
//  bMessageSendView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/25.
//

import SwiftUI
import WatchKit
import DarockKit
import Alamofire
import SwiftyJSON

struct bMessageSendView: View {
    var uid: Int
    var username: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var messages = [[String: String]]()
    @State var sendTextCache = ""
    @State var refreshTimer: Timer?
    var body: some View {
        ScrollView {
            VStack {
                if messages.count != 0 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(0...messages.count - 1, id: \.self) { i in
                            if messages[i]["SenderID"] == String(uid) {
                                HStack {
                                    HStack {
                                        Text(messages[i]["Text"]!)
                                        //.frame(maxWidth: 130)
                                            .padding()
                                            .background {
                                                RoundedCornersView(color: Color(hex: 0x1F1F20), topLeading: 12, topTrailing: 12, bottomLeading: { () -> CGFloat in
                                                    if messages.count > i + 1 {
                                                        if messages[i + 1]["SenderID"] == String(uid) {
                                                            return 12
                                                        } else {
                                                            return 0
                                                        }
                                                    } else {
                                                        return 0
                                                    }
                                                }(), bottomTrailing: 12)
                                            }
                                        Spacer(minLength: 5)
                                    }
                                    .frame(width: WKInterfaceDevice.current().screenBounds.width - 10)
                                    Spacer()
                                        .frame(width: 15)
                                    Text({ () -> String in
                                        let df = DateFormatter()
                                        df.dateFormat = "a hh:mm"
                                        return df.string(from: Date(timeIntervalSince1970: Double(messages[i]["Timestamp"]!)!))
                                    }())
                                    .font(.system(size: 14))
                                    .opacity(0.6)
                                }
                            } else {
                                HStack {
                                    HStack {
                                        Spacer(minLength: 5)
                                        Text(messages[i]["Text"]!)
                                            .padding()
                                            .background {
                                                RoundedCornersView(color: Color(hex: 0xF889BA), topLeading: 12, topTrailing: 12, bottomLeading: 12, bottomTrailing: { () -> CGFloat in
                                                    if messages.count > i + 1 {
                                                        if messages[i + 1]["SenderID"] != String(uid) {
                                                            return 12
                                                        } else {
                                                            return 0
                                                        }
                                                    } else {
                                                        return 0
                                                    }
                                                }())
                                            }
                                    }
                                    .frame(width: WKInterfaceDevice.current().screenBounds.width - 10)
                                    Spacer()
                                        .frame(width: 15)
                                    Text({ () -> String in
                                        let df = DateFormatter()
                                        df.dateFormat = "a hh:mm"
                                        return df.string(from: Date(timeIntervalSince1970: Double(messages[i]["Timestamp"]!)!))
                                    }())
                                    .font(.system(size: 14))
                                    .opacity(0.6)
                                }
                            }
                        }
                    }
                }
                HStack {
//                    Button(action: {
//                        
//                    }, label: {
//                        ZStack {
//                            Circle()
//                                .foregroundStyle(Color(red: 31/255, green: 31/255, blue: 31/255))
//                            Image(systemName: "plus")
//                                .font(.title3)
//                        }
//                    })
//                    .frame(width: 50, height: 30)
                    TextField("私信", text: $sendTextCache)
                        .opacity(0.0100000002421438702673861521)
                        .background {
                            ZStack {
                                Capsule()
                                    .stroke(Color(red: 31/255, green: 31/255, blue: 31/255), lineWidth: 2)
                                HStack {
                                    Text("私信")
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .padding(.leading)
                            }
                        }
                        .textFieldStyle(.plain)
                        .submitLabel(.send)
                        .onSubmit {
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata);"
                            ]
                            AF.request("https://api.vc.bilibili.com/web_im/v1/web_im/send_msg", method: .post, parameters: ["msg[sender_uid]": Int(dedeUserID)!, "msg[receiver_id]": uid, "msg[receiver_type]": 1, "msg[msg_type]": 1, "msg[dev_id]": "372778FD-E359-461D-86A3-EA2BCC6FF52A", "msg[timestamp]": Date.now.timeStamp, "msg[content]": "{\"content\":\"\(sendTextCache)\"}", "csrf": biliJct], headers: headers).response { response in
                                messages.append(["SenderID": dedeUserID, "Text": sendTextCache, "Timestamp": String(Date.now.timeStamp)])
                                sendTextCache = ""
                                debugPrint(response)
                                let json = try! JSON(data: response.data!)
                                if json["code"].int! == 0 {
                                    //tipWithText("发送成功", symbol: "checkmark.circle.fill")
                                } else {
                                    tipWithText("发送失败", symbol: "xmark.circle.fill")
                                }
                            }
                        }
                }
            }
        }
        .onAppear {
            RefreshMessages()
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                refreshTimer = timer
                RefreshMessages(deleteAll: true)
            }
        }
    }
    
    func RefreshMessages(deleteAll: Bool = false) {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);"
        ]
        DarockKit.Network.shared.requestJSON("https://api.vc.bilibili.com/svr_sync/v1/svr_sync/fetch_session_msgs?talker_id=\(uid)&session_type=1&size=20", headers: headers) { respJson, isSuccess in
            if isSuccess {
                debugPrint(respJson)
                if deleteAll {
                    messages.removeAll()
                }
                for message in respJson["data"]["messages"] {
                    messages.insert(["SenderID": String(message.1["sender_uid"].int!), "Text": String(message.1["content"].string!.split(separator: ":\"")[1].split(separator: "\"}")[0]).replacingOccurrences(of: "\\n", with: "\n"), "Timestamp": String(message.1["timestamp"].int!)], at: 0)
                }
            }
        }
    }
    
    struct RoundedCornersView: View {
        var color: Color
        var topLeading: CGFloat
        var topTrailing: CGFloat
        var bottomLeading: CGFloat
        var bottomTrailing: CGFloat
        
        var body: some View {
            GeometryReader { geometry in
                Path { path in
                    let w = geometry.size.width
                    let h = geometry.size.height
                    
                    let tr = min(min(self.topTrailing, h/2), w/2)
                    let tl = min(min(self.topLeading, h/2), w/2)
                    let bl = min(min(self.bottomLeading, h/2), w/2)
                    let br = min(min(self.bottomTrailing, h/2), w/2)
                    
                    path.move(to: CGPoint(x: w / 2.0, y: 0))
                    path.addLine(to: CGPoint(x: w - tr, y: 0))
                    path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                    path.addLine(to: CGPoint(x: w, y: h - br))
                    path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                    path.addLine(to: CGPoint(x: bl, y: h))
                    path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                    path.addLine(to: CGPoint(x: 0, y: tl))
                    path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                }
                .fill(self.color)
            }
        }
    }
}

struct bMessageSendView_Previews: PreviewProvider {
    static var previews: some View {
        bMessageSendView(uid: 114514, username: "ReX-We")
    }
}
