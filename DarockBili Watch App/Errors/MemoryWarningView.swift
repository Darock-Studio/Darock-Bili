//
//  MemoryWarningView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/24.
//

import SwiftUI

struct MemoryWarningView: View {
    var body: some View {
        VStack {
            Text("注意！")
                .font(.system(size: 16, weight: .bold))
            Text("当前占用内存过高")
            Text("喵哩喵哩可能会被系统终止")
        }
        .multilineTextAlignment(.center)
    }
}

struct MemoryWarningView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryWarningView()
    }
}
