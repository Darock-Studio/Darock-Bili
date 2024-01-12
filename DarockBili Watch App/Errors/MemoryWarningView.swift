//
//  MemoryWarningView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/24.
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

struct MemoryWarningView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack {
                Text("注意！")
                    .font(.system(size: 18, weight: .bold))
                Text("当前占用内存过高")
                Text("喵哩喵哩可能会被系统终止")
                Text("当前内存占用大于 240 MB\n内存占用超过 300 MB 后会被系统终止")
                Button(action: {
                    dismiss()
                }, label: {
                    Text("了解！")
                })
                Button(action: {
                    isShowMemoryInScreen = true
                    dismiss()
                }, label: {
                    Text("在右上角显示占用（仅本次启动）")
                })
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct MemoryWarningView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryWarningView()
    }
}
