//
//  SignalErrorView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/14.
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

struct SignalErrorView: View {
    @State var userDesc = ""
    @State var isSending = false
    @State var errorText = ""
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Error.oops")
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text("Error.ran-into-a-problem")
                        .font(.system(size: 17))
                    Spacer()
                }
                HStack {
                    Text("Error.details")
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
                Text("Error.send-to-Darock-advice")
                    .bold()
                    .multilineTextAlignment(.leading)
                TextField("Error.before-ranning-into-problem", text: $userDesc)
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
                        Text("Error.send")
                            .bold()
                    } else {
                        ProgressView()
                    }
                })
                .disabled(isSending)
                Button(action: {
                    UserDefaults.standard.set("", forKey: "NewSignalError")
                }, label: {
                    Text("Error.do-not-send")
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

