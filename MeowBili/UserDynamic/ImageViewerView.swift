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
#if !os(visionOS)
import SDWebImageSwiftUI
#endif

struct ImageViewerView: View {
    var url: String
    var body: some View {
        #if !os(visionOS)
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
                        AlertKitAPI.present(title: "已保存", subtitle: "图片已保存到相册", icon: .done, style: .iOS17AppleMusic, haptic: .success)
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
        #else
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                Color.clear
            case .success(let image):
                image.resizable()
            case .failure(let error):
                Color.clear
            }
        }
        .scaledToFit()
        .frame(alignment: .center)
        .modifier(Zoomable())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    let img = UIImage(data: try! Data(contentsOf: URL(string: url)!))!
                    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                    //AlertKitAPI.present(title: "已保存", subtitle: "图片已保存到相册", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                })
            }
        }
        #endif
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(url: "")
    }
}
