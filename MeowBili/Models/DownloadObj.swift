//
//
//  DownloadObj.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
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

import Foundation

public struct DownloadProgressData: Equatable {
    var progress: Double
    var currentSize: Int64
    var totalSize: Int64
    
    public static func ==(lhs: DownloadProgressData, rhs: DownloadProgressData) -> Bool {
        return lhs.progress == rhs.progress
    }
}
public struct DownloadTaskDetailData: Equatable {
    var data: DownloadProgressData
    var videoDetails: [String: String]
}
