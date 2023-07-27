//
//  UIExt.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/8.
//

import UIKit
import SwiftUI
import WatchKit
import Foundation
import SDWebImageSwiftUI

@ViewBuilder func VideoCard(_ videoDetails: [String: String]) -> some View {
    NavigationLink(destination: {VideoDetailView(videoDetails: videoDetails)}, label: {
        VStack {
            HStack {
                WebImage(url: URL(string: videoDetails["Pic"]! + "@50w")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 50)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
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

struct VolumeControlView: WKInterfaceObjectRepresentable {
    typealias WKInterfaceObjectType = WKInterfaceVolumeControl
    
    
    func makeWKInterfaceObject(context: WKInterfaceObjectRepresentableContext<VolumeControlView>) -> WKInterfaceVolumeControl {
        // Return the interface object that the view displays.
        return WKInterfaceVolumeControl(origin: .local)
    }
    
    func updateWKInterfaceObject(_ map: WKInterfaceVolumeControl, context: WKInterfaceObjectRepresentableContext<VolumeControlView>) {
        
    }
}
