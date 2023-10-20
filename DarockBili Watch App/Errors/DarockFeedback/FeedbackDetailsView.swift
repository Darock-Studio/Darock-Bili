//
//  FeedbackDetailsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/13.
//

import SwiftUI
import DarockKit

struct FeedbackDetailsView: View {
    var fbName: String
    @AppStorage("DarockIDAccount") var darockIdAccount = ""
    var body: some View {
        ScrollView {
            VStack {
                
            }
        }
        .onAppear {
            DarockKit.Network.shared.requestString("https://api.darock.top/feedback/getDetail/\(darockIdAccount)/\(fbName)") { respStr, isSuccess in
                if isSuccess {
                    debugPrint(respStr.apiFixed())
                }
            }
        }
    }
}

struct FeedbackDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackDetailsView(fbName: "test")
    }
}
