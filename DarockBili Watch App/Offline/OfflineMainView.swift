//
//  OfflineMainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/11/3.
//

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
