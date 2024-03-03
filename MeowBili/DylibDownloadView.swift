//
//
//  DylibDownloadView.swift
//  DarockBili
//
//  Created by memz233 on 2024/3/2.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import Alamofire
import ZipArchive

struct DylibDownloadView: View {
    @Binding var statusSymbol: Bool
    @State var downloadProgress = 0.0
    @State var downloadedSize: Int64 = 0
    @State var totalSize: Int64 = 0
    @State var isUnziping = false
    var body: some View {
        NavigationStack {
            List {
                if !isUnziping {
                    Section {
                        Text("正在下载资源...")
                            .bold()
                    }
                    Section {
                        VStack {
                            ProgressView(value: downloadProgress)
                            HStack {
                                Spacer()
                                Text("\(String(format: "%.2f", downloadProgress * 100) + " %")")
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("\(String(format: "%.2f", Double(downloadedSize) / 1024 / 1024))MB / \(String(format: "%.2f", Double(totalSize) / 1024 / 1024))MB")
                                    .font(.system(size: 16, weight: .bold))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                                Spacer()
                            }
                        }
                    }
                } else {
                    Section {
                        VStack {
                            Text("正在安装...")
                                .bold()
                            ProgressView()
                        }
                    }
                }
                #if os(watchOS)
                Section {
                    Text("请不要让Apple Watch熄屏，可以通过保持滚动表冠以使屏幕常亮")
                }
                Section {
                    Text("""
                    顺便了解一些知识来打发时间吧！
                    
                    - 为什么要下载资源包？
                      喵哩喵哩通过资源包运行主要代码，这也就意味着您无需经常使用iPhone更新App。
                    - 获取新功能的方法？
                      在设置->软件更新中可以更新资源包，无论iPhone是否在身边
                    - 使用技巧？
                       - 保持良好的网络环境，最好不连接iPhone或在设置中关闭iPhone上的无线局域网与蓝牙
                       - 遇到问题在用户群内反馈效率最高
                       - 登录账号以获取最佳体验
                    - 开源！
                      喵哩喵哩为开源项目，您可以在GitHub上找到我们的源代码
                    """)
                }
                #endif
            }
        }
        .onAppear {
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("maind.zip")
                return (fileURL, [.removePreviousFile])
            }
            #if targetEnvironment(simulator)
                #if os(watchOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/watchsimulator.zip"
                #elseif os(iOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/iphonesimulator.zip"
                #endif
            #else
                #if os(watchOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/watchos.zip"
                #elseif os(iOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/iphoneos.zip"
                #endif
            #endif
            DispatchQueue(label: "com.darock.DarockBili.resDownload").async {
                AF.download(link, to: destination)
                    .downloadProgress { p in
                        downloadProgress = p.fractionCompleted
                        downloadedSize = p.completedUnitCount
                        totalSize = p.totalUnitCount
                    }
                    .response { r in
                        if r.error == nil, let filePath = r.fileURL?.path {
                            debugPrint(filePath)
                            isUnziping = true
                            DispatchQueue(label: "com.darock.DarockBili.resUnzip", qos: .background).async {
                                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                let fileURL = documentsURL.appendingPathComponent("main.dylib")
                                if FileManager.default.fileExists(atPath: fileURL.path()) {
                                    try! FileManager.default.removeItem(atPath: fileURL.path())
                                }
                                try! SSZipArchive.unzipFile(atPath: filePath, toDestination: fileURL.path().split(separator: "/").dropLast().joined(separator: "/"), overwrite: true, password: nil)
                                try! FileManager.default.removeItem(atPath: filePath)
                                statusSymbol.toggle()
                            }
                        } else {
                            debugPrint(r.error as Any)
                        }
                    }
            }
        }
    }
}
