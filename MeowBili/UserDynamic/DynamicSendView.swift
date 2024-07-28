//
//
//  DynamicSendView.swift
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

import SwiftUI
import DarockKit
import PhotosUI
import Alamofire
import SwiftyJSON
#if canImport(JournalingSuggestions)
import JournalingSuggestions
#endif

struct DynamicSendView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("DynamicTailSetting") var dynamicTailSetting = "NotSet"
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var selectedPhotos = [PhotosPickerItem]()
    @State var dynamicText = ""
    @State var convertedImages = [UIImage]()
    @State var isTailInitPresented = false
    @State var isSending = false
    @State var sendProgressText = ""
    var body: some View {
        NavigationStack {
            List {
                #if canImport(JournalingSuggestions)
                if #available(iOS 17.2, *) {
                    Section {
                        JournalingSuggestionsPicker {
                            Label("手记建议", systemImage: "sparkles")
                        } onCompletion: { suggestion in
                            dynamicText = suggestion.title
                            await suggestion.content(forType: JournalingSuggestion.Photo.self).forEach { photo in
                                convertedImages.append(UIImage(data: try! Data(contentsOf: photo.photo))!)
                            }
                        }
                    }
                }
                #endif
                Section {
                    #if !os(watchOS)
                    TextEditor(text: $dynamicText)
                        .frame(height: 100)
                    #else
                    TextField("内容", text: $dynamicText)
                    #endif
                } header: {
                    Text("动态内容")
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
                            Image(uiImage: convertedImages[i])
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
                            isSending = true
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3); bili_jct=\(biliJct)",
                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                            ]
                            if convertedImages.count == 0 {
                                sendProgressText = "正在发送..."
                                AF.request("https://api.vc.bilibili.com/dynamic_svr/v1/dynamic_svr/create", method: .post, parameters: ["dynamic_id": 0, "type": 4, "rid": 0, "content": "\(dynamicText)\(dynamicTailSetting == "" ? "" : "\n\n    \(dynamicTailSetting)")", "csrf": biliJct], headers: headers).response { response in
                                    debugPrint(response)
                                    if let rd = response.data, let json = try? JSON(data: rd) {
                                        if !CheckBApiError(from: json) { return }
                                        #if !os(watchOS)
                                        AlertKitAPI.present(title: "发送成功", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                                        #else
                                        tipWithText("发送成功", symbol: "checkmark.circle.fill")
                                        #endif
                                        dismiss()
                                    } else {
                                        #if !os(watchOS)
                                        AlertKitAPI.present(title: "发送失败,未知错误", icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                        #else
                                        tipWithText("发送失败,未知错误", symbol: "xmark.circle.fill")
                                        #endif
                                    }
                                    sendProgressText = ""
                                }
                            } else {
                                let parameters: [String: String] = [
                                    "category": "daily",
                                    "csrf": biliJct
                                ]
                                let currentUploadImageIndex = UnsafeMutablePointer<Int>.allocate(capacity: 1)
                                currentUploadImageIndex.initialize(to: 0)
                                let uploadedImageUrl = UnsafeMutablePointer<String>.allocate(capacity: 9)
                                for i in 0..<9 {
                                    uploadedImageUrl.advanced(by: i).initialize(to: "")
                                }
                                uploadImageBfs(image: convertedImages[currentUploadImageIndex.pointee], params: parameters, headers: headers) { response in
                                    uploadImageRespHander(response, cuiiPtr: currentUploadImageIndex, upliPtr: uploadedImageUrl, params: parameters, headers: headers)
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
                    .disabled(isSending)
                    .sheet(isPresented: $isTailInitPresented, content: { DynamicTailSetView() })
                } footer: {
                    Text(sendProgressText)
                }
            }
            .navigationTitle("发送动态")
            .onChange(of: selectedPhotos) {
                convertedImages.removeAll()
                for photo in selectedPhotos {
                    photo.loadTransferable(type: UIImageTransfer.self) { result in
                        switch result {
                        case .success(let success):
                            if let image = success {
                                convertedImages.append(image.image)
                            }
                        case .failure:
                            break
                        }
                    }
                }
            }
        }
    }
    
    func uploadImageBfs(image: UIImage, params: [String: String], headers: HTTPHeaders, callback: @escaping (AFDataResponse<Data?>) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            for image in convertedImages {
                multipartFormData.append(image.pngData()!, withName: "file_up", fileName: "\(Int.random(in: 1...100)).png", mimeType: "image/png")
            }
            for (key, value) in params {
                if let data = value.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: "https://api.bilibili.com/x/dynamic/feed/draw/upload_bfs", method: .post, headers: headers).response { response in
           callback(response)
        }
    }
    func uploadImageRespHander(_ response: AFDataResponse<Data?>, cuiiPtr currentUploadImageIndex: UnsafeMutablePointer<Int>, upliPtr: UnsafeMutablePointer<String>, params: [String: String], headers: HTTPHeaders) {
        sendProgressText = "正在上传图片 #\(currentUploadImageIndex + 1)"
        if let rd = response.data, let json = try? JSON(data: rd) {
            if !CheckBApiError(from: json) { return }
            if let url = json["data"]["image_url"].string {
                upliPtr.advanced(by: currentUploadImageIndex.pointee).pointee = "\(url)||\(convertedImages[currentUploadImageIndex.pointee].size.width)||\(convertedImages[currentUploadImageIndex.pointee].size.height)||\(Double(convertedImages[currentUploadImageIndex.pointee].pngData()!.count) / 1024.0)"
            } else {
                currentUploadImageIndex.deallocate()
                #if !os(watchOS)
                AlertKitAPI.present(title: "上传图片时失败,未知错误", icon: .error, style: .iOS17AppleMusic, haptic: .error)
                #else
                tipWithText("上传图片时失败,未知错误", symbol: "xmark.circle.fill")
                #endif
                return
            }
            currentUploadImageIndex.pointee++
            if currentUploadImageIndex.pointee < convertedImages.count {
                uploadImageBfs(image: convertedImages[currentUploadImageIndex.pointee], params: params, headers: headers) { response in
                    uploadImageRespHander(response, cuiiPtr: currentUploadImageIndex, upliPtr: upliPtr, params: params, headers: headers)
                }
            } else {
                currentUploadImageIndex.deallocate()
                sendProgressText = "正在上传动态"
                AF.request("https://api.bilibili.com/x/dynamic/feed/create/dyn?csrf=\(biliJct)", method: .post, parameters: [
                    "dyn_req": [
                        "content": [
                            "contents": [
                                [
                                    "raw_text": "\(dynamicText)\(dynamicTailSetting == "" ? "" : "\n\n    \(dynamicTailSetting)")",
                                    "type": 1,
                                    "biz_id": ""
                                ]
                            ]
                        ],
                        "scene": 2,
                        "pics": { () -> [[String: Any]] in
                            var tmp = [[String: Any]]()
                            for i in 0..<9 {
                                if upliPtr.advanced(by: i).pointee == "" {
                                    break
                                }
                                tmp.append([
                                    "img_src": String(upliPtr.advanced(by: i).pointee.split(separator: "||")[0]),
                                    "img_height": Int(Float(upliPtr.advanced(by: i).pointee.split(separator: "||")[1])!),
                                    "img_width": Int(Float(upliPtr.advanced(by: i).pointee.split(separator: "||")[2])!),
                                    "img_size": Double(upliPtr.advanced(by: i).pointee.split(separator: "||")[3])!
                                ])
                            }
                            return tmp
                        }()
                    ]
                ], encoding: JSONEncoding.default, headers: headers).response { response in
                    debugPrint(response)
                }
            }
        } else {
            currentUploadImageIndex.deallocate()
            #if !os(watchOS)
            AlertKitAPI.present(title: "上传图片时失败,未知错误", icon: .error, style: .iOS17AppleMusic, haptic: .error)
            #else
            tipWithText("上传图片时失败,未知错误", symbol: "xmark.circle.fill")
            #endif
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
