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
                Text("Memory.caution")
                    .font(.system(size: 18, weight: .bold))
                Text("Memory.too-much-occupied")
                Text("Memory.limit")
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Memory.understand")
                })
                Button(action: {
                    isShowMemoryInScreen = true
                    dismiss()
                }, label: {
                    Text("Memory.display-usage")
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
