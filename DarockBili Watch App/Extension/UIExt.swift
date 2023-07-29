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

struct zoomable: ViewModifier {
    @AppStorage("MaxmiumScale") var maxmiumScale = 6.0
    @State var scale: CGFloat = 1.0
    @State var offset = CGSize.zero
    @State var lastOffset = CGSize.zero
    func body(content: Content) -> some View {
            content
                .scaleEffect(self.scale)
                .focusable()
                .digitalCrownRotation($scale, from: 0.5, through: maxmiumScale, by: 0.02, sensitivity: .low, isHapticFeedbackEnabled: true)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = CGSize(width: gesture.translation.width + lastOffset.width, height: gesture.translation.height + lastOffset.height)
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .onDisappear {
                    offset = CGSize.zero
                    lastOffset = CGSize.zero
                }
                .onChange(of: scale) { value in
                    if value < 2.0 {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            offset = CGSize.zero
                            lastOffset = CGSize.zero
                        }
                    }
                }
    }
}

extension Indicator where T == ProgressView<EmptyView, EmptyView> {
    static var activity: Indicator {
        Indicator { isAnimating, progress in
            ProgressView()
        }
    }
    
    static var progress: Indicator {
        Indicator { isAnimating, progress in
            ProgressView(value: progress.wrappedValue)
        }
    }
}
