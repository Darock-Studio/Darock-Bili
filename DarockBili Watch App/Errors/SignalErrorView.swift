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
    @State var userDesc = ""
    @State var isSending = false
    @State var errorText = ""
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
                    VStack {
                        Text(errorText)
                            .font(.system(size: 10))
                            .padding(3)
                        Spacer()
                    }
                    .frame(height: 10000)
                }
                .frame(maxHeight: 100)
                .border(Color.accentColor, width: 2)
                .cornerRadius(5)
                Text("将上方信息发送到 Darock 可以帮助我们改进喵哩喵哩")
                    .bold()
                    .multilineTextAlignment(.leading)
                TextField("发生错误前...", text: $userDesc)
                Button(action: {
                    isSending = true
                    let headers: HTTPHeaders = [
                        "accept": "application/json",
                        "Content-Type": "multipart/form-data"
                    ]
                    AF.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(("User Description: " + userDesc + "\n\n" + errorText).data(using: .utf8)!, withName: "file", fileName: UserDefaults.standard.string(forKey: "NewSignalError")!)
                    }, to: "https://api.darock.top/bili/crashfeedback/\(UserDefaults.standard.string(forKey: "NewSignalError")!.base64Encoded())", method: .post, headers: headers).responseString { response in
                        let rspStr = String(data: response.data!, encoding: .utf8)!
                        debugPrint(response)
                        isSending = false
                        UserDefaults.standard.set("", forKey: "NewSignalError")
                    }
                }, label: {
                    if !isSending {
                        Text("发送")
                            .bold()
                    } else {
                        ProgressView()
                    }
                })
                .disabled(isSending)
                Button(action: {
                    UserDefaults.standard.set("", forKey: "NewSignalError")
                }, label: {
                    Text("不发送")
                })
            }
        }
        .onAppear {
            let fileName = UserDefaults.standard.string(forKey: "NewSignalError")!
            let manager = FileManager.default
            let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
            errorText = try! String(contentsOf: URL(string: (urlForDocument[0] as URL).absoluteString + fileName.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "__"))!)
        }
    }
}

struct SignalErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SignalErrorView()
    }
}

