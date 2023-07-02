//
//  FirstUsingView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import SwiftUI

struct FirstUsingView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("IsFirstUsing") var isFirstUsing = true
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("欢迎使用腕上哔哩！")
                    Text("看起来你是第一次使用，这里有一些值得注意的地方：")
                }
                Section {
                    Label("网络环境：", systemImage: "1.circle.fill")
                    Text("请确定 Watch 的状态栏（控制中心上方）显示为\(Image(systemName: "wifi"))而不是\(Image(systemName: "iphone"))")
                    Label("问题反馈：", systemImage: "2.circle.fill")
                    Text("腕上哔哩现在还处于测试阶段，遇到问题可以使用暗礁反馈（将在晚些时候上线）帮助我们改进")
                }
                Section {
                    Button(action: {
                        isFirstUsing = false
                        dismiss()
                    }, label: {
                        Text("我知道了！")
                    })
                }
            }
            .bold()
        }
    }
}

#Preview {
    FirstUsingView()
}
