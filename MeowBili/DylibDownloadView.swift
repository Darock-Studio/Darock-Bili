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

struct DylibDownloadView: View {
    @Binding var statusSymbol: Bool
    @State var downloadProgress = 0.0
    @State var downloadedSize: Int64 = 0
    @State var totalSize: Int64 = 0
    var body: some View {
        NavigationStack {
#if os(watchOS)
            List {
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
            }
#else
            
#endif
        }
        .onAppear {
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("main.dylib")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            #if targetEnvironment(simulator)
                #if os(watchOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/watchsimulator.dylib"
                #elseif os(iOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/iphonesimulator.dylib"
                #endif
            #else
                #if os(watchOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/watchos.dylib"
                #elseif os(iOS)
                let link = "https://cd.darock.top:32767/meowbili/res/dylib/iphoneos.dylib"
                #endif
            #endif
            AF.download(link, to: destination)
                .downloadProgress { p in
                    downloadProgress = p.fractionCompleted
                    downloadedSize = p.completedUnitCount
                    totalSize = p.totalUnitCount
                }
                .response { r in
                    if r.error == nil, let filePath = r.fileURL?.path {
                        debugPrint(filePath)
                        statusSymbol.toggle()
                    } else {
                        debugPrint(r.error as Any)
                    }
                }
        }
    }
}
