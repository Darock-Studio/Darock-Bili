//
//
//  ImageViewerView.swift
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

import SwiftUI
import DarockKit
import SDWebImageSwiftUI

struct ImageViewerView: View {
    var url: String
    var body: some View {
        WebImage(url: URL(string: url), options: [.progressiveLoad], isAnimating: .constant(true))
            .resizable()
//            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: CGFloat(100), height: CGFloat(100), alignment: .center)
//            .modifier(zoomable())
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(url: "")
    }
}
