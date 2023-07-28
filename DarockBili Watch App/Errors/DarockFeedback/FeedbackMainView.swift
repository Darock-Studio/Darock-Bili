//
//  FeedbackMainView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/13.
//

import SwiftUI
import DarockKit

struct FeedbackMainView: View {
    @AppStorage("DarockIDAccount") var darockIdAccount = ""
    @State var feedbackNames = [String]()
    @State var isNone = false
    var body: some View {
        List {
            if !isNone {
                if feedbackNames.count != 0 {
                    ForEach(0...feedbackNames.count - 1, id: \.self) { i in
                        NavigationLink(destination: {FeedbackDetailsView(fbName: feedbackNames[i])}, label: {
                            Text(feedbackNames[i])
                        })
                    }
                } else {
                    ProgressView()
                }
            } else {
                Text("无反馈")
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button(action: {
//                    
//                }, label: {
//                    Image(systemName: "square.and.pencil")
//                })
//            }
//        }
        .onAppear {
            DarockKit.Network.shared.requestString("https://api.darock.top/feedback/get/\(darockIdAccount)") { respStr, isSuccess in
                if isSuccess {
                    debugPrint(respStr)
                    if respStr.apiFixed() != "None" {
                        let namesSpd = respStr.apiFixed().split(separator: "|")
                        for name in namesSpd {
                            feedbackNames.append(String(name))
                        }
                    } else {
                        isNone = true
                    }
                }
            }
        }
    }
}

struct FeedbackMainView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackMainView()
    }
}
