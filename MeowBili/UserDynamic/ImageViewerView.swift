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
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import DarockUI
import SDWebImageSwiftUI

struct ImageViewerView: View {
    var url: String
    var body: some View {
        WebImage(url: URL(string: url), options: [.progressiveLoad], isAnimating: .constant(true))
            .resizable()
        #if !os(watchOS)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(alignment: .center)
            .modifier(Zoomable())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let img = UIImage(data: try! Data(contentsOf: URL(string: url)!))!
                        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                        tipWithText("已保存到相册", symbol: "checkmark.circle.fill")
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                    })
                }
            }
        #else
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: CGFloat(100), height: CGFloat(100), alignment: .center)
            .modifier(Zoomable())
        #endif
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(url: "")
    }
}
