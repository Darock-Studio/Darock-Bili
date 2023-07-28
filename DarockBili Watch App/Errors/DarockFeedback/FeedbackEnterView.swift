//
//  FeedbackEnterView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/13.
//

import SwiftUI

struct FeedbackEnterView: View {
    @AppStorage("DarockIDAccount") var darockIdAccount = ""
    var body: some View {
        if darockIdAccount == "" {
            FeedbackLoginView()
        } else {
            FeedbackMainView()
        }
    }
}

struct FeedbackEnterView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackEnterView()
    }
}

