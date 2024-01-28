//
//
//  DynamicSendView.swift
//  DarockBili Watch App
//
//  Created by memz233 on 2024/1/28.
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
import PhotosUI
import Alamofire
import SwiftyJSON

struct DynamicSendView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("DynamicTailSetting") var dynamicTailSetting = "NotSet"
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var selectedPhotos = [PhotosPickerItem]()
    @State var dynamicText = ""
    @State var convertedImages = [Image]()
    @State var isTailInitPresented = false
    @State var isSending = false
    var body: some View {
        List {
            Section {
                TextField("动态内容", text: $dynamicText)
            } footer: {
                Text("将作为动态主体")
            }
            Section {
                PhotosPicker(selection: $selectedPhotos, matching: .images) {
                    Text("选择图片")
                }
            } footer: {
                Text("可选, 最多9个")
            }
            if convertedImages.count != 0 {
                Section {
                    ForEach(0..<convertedImages.count, id: \.self) { i in
                        convertedImages[i]
                            .resizable()
                            .scaledToFit()
                    }
                } header: {
                    Text("已选择的图片")
                }
            }
            Section {
                Button(action: {
                    if dynamicTailSetting == "NotSet" {
                        isTailInitPresented = true
                    } else {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3)",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        if convertedImages.count == 0 {
                            AF.request("https://api.vc.bilibili.com/dynamic_svr/v1/dynamic_svr/create", method: .post, parameters: ["dynamic_id": 0, "type": 4, "rid": 0, "content": "\(dynamicText)\(dynamicTailSetting == "" ? "" : "\n\n    \(dynamicTailSetting)")", "csrf": biliJct], headers: headers).response { response in
                                debugPrint(response)
                                dismiss()
                            }
                        } else {
                            AF.request("https://api.bilibili.com/x/dynamic/feed/create/dyn", method: .post, parameters: ["dyn_req": ["content": [["raw_text": "\(dynamicText)\(dynamicTailSetting == "" ? "" : "\n\n    \(dynamicTailSetting)")", "type": 1]], "scene": 2, "pics": []]], headers: headers).response { response in
                                
                            }
                        }
                    }
                }, label: {
                    if isSending {
                        ProgressView()
                    } else {
                        Text("发送动态")
                    }
                })
                .sheet(isPresented: $isTailInitPresented, content: {DynamicTailSetView()})
            }
        }
        .onChange(of: selectedPhotos) { value in
            convertedImages.removeAll()
            for photo in value {
                photo.loadTransferable(type: Image.self) { result in
                    switch result {
                    case .success(let success):
                        if let image = success {
                            convertedImages.append(image)
                        }
                    case .failure:
                        break
                    }
                }
            }
        }
    }
    
    struct DynamicTailSetView: View {
        @Environment(\.dismiss) var dismiss
        @AppStorage("DynamicTailSetting") var dynamicTailSetting = "NotSet"
        @State var tailContent = "———— 来自 watchOS 喵哩喵哩客户端"
        var body: some View {
            List {
                Section {
                    Text("要使用动态小尾巴吗?")
                        .bold()
                        .listRowBackground(Color.clear)
                }
                Section {
                    TextField("小尾巴内容", text: $tailContent)
                } header: {
                    Text("小尾巴内容")
                } footer: {
                    Text("您可以更改默认的小尾巴内容, 如果不想添加小尾巴, 请清空上方文本框内容. 您可以随时在设置中更改此内容")
                }
                Section {
                    Button(action: {
                        dynamicTailSetting = tailContent
                        dismiss()
                    }, label: {
                        Text("应用")
                    })
                }
            }
        }
    }
}

#Preview {
    DynamicSendView()
}
