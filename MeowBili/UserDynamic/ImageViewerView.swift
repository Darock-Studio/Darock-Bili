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
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(alignment: .center)
            .modifier(zoomable())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let img = UIImage(data: try! Data(contentsOf: URL(string: url)!))!
                        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                        AlertKitAPI.present(title: "已保存", subtitle: "图片已保存到相册", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                    })
                }
            }
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(url: "")
    }
}
