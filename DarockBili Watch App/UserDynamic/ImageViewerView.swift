//
//  ImageViewerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/28.
//

import SwiftUI
import DarockKit
import SDWebImageSwiftUI

struct ImageViewerView: View {
    var url: String
    var body: some View {
        WebImage(url: URL(string: url), options: [.progressiveLoad], isAnimating: .constant(true))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: CGFloat(100), height: CGFloat(100), alignment: .center)
            .modifier(zoomable())
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(url: "")
    }
}

