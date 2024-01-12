//
//  OfflineMainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/11/3.
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

struct OfflineMainView: View {
    var body: some View {
        TabView {
            DownloadsView()
                .tag(1)
        }
    }
}

#Preview {
    OfflineMainView()
}
