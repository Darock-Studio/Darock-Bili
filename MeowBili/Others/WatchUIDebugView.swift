//
//
//  WatchUIDebugView.swift
//  MeowBili Watch App
//
//  Created by memz233 on 2024/3/31.
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

struct WatchUIDebugView: View {
    var body: some View {
        List {
            NavigationLink(destination: { SegmentedPicker(selection: .constant(0), leftText: "TLeft", rightText: "TRight") }, label: {
                Text("DebugVPLD")
            })
        }
    }
    
    
}

#Preview {
    WatchUIDebugView()
}
