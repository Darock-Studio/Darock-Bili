//
//  UIExt.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/8.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

@ViewBuilder func VideoCard(_ videoDetails: [String: String]) -> some View {
    NavigationLink(destination: {VideoDetailView(videoDetails: videoDetails)}, label: {
        VStack {
            HStack {
                WebImage(url: URL(string: videoDetails["Pic"]! + "@50w")!, options: [.progressiveLoad])
                    .cornerRadius(7)
                Text(videoDetails["Title"]!)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(2)
                Spacer()
            }
            HStack {
                Image(systemName: "play.circle")
                Text(videoDetails["View"]!.shorter())
                    .offset(x: -3)
                Image(systemName: "person")
                Text(videoDetails["UP"]!)
                    .offset(x: -3)
                Spacer()
            }
            .lineLimit(1)
            .font(.system(size: 11))
            .foregroundColor(.gray)
        }
    })
    .buttonBorderShape(.roundedRectangle(radius: 14))
}
