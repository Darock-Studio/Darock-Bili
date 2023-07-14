//
//  SignalErrorView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/14.
//

import SwiftUI
import DarockKit
import Alamofire

struct SignalErrorView: View {
    @AppStorage("signalErrorLogNum") var signalErrorLogNum = 0
    @State var userDesc = ""
    @State var isSending = false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("呜啊！")
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text("喵哩喵哩在上次运行时出现了一些问题")
                        .font(.system(size: 17))
                    Spacer()
                }
                HStack {
                    Text("下面是错误详情：")
                        .font(.system(size: 15))
                    Spacer()
                }
                ScrollView {
                    Text(UserDefaults.standard.string(forKey: "signalError\(signalErrorLogNum)")!)
                        .font(.system(size: 10))
                }
                .frame(maxHeight: 100)
                Text("将上方信息发送到 Darock 可以帮助我们改进喵哩喵哩")
                    .bold()
                    .multilineTextAlignment(.leading)
                TextField("发生错误前...", text: $userDesc)
                Button(action: {
                    isSending = true
                    let headers: HTTPHeaders = [
                        "accept": "application/json",
                        "Content-Type": "application/json",
                        "codedContent": userDesc + "\n" + UserDefaults.standard.string(forKey: "signalError\(signalErrorLogNum)")!
                    ]
                    AF.request("https://api.darock.top/bili/crashfeedback", headers: headers).response { response in
                        let respStr = String(data: response.data!, encoding: .utf8)!
                        debugPrint(response)
                        debugPrint(respStr)
                        UserDefaults.standard.set(false, forKey: "isNewSignalError")
                    }
                }, label: {
                    if !isSending {
                        Text("发送")
                            .bold()
                    } else {
                        ProgressView()
                    }
                })
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isNewSignalError")
                }, label: {
                    Text("不发送")
                })
            }
        }
    }
}

#Preview {
    SignalErrorView()
}
