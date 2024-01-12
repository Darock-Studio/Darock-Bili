//
//  EnterPage.swift
//  DarockBili Watch App
//
//  Created by 凌嘉徽 on 2024/1/11.
//

import SwiftUI

struct EnterPage: View {
    @AppStorage("showEnterPage") var showEnterPage = true
    var body: some View {
        ScrollView {
            VStack {
                Text("你好，欢迎使用我的app。")
                Text("本app的名字叫\(Text("“喵哩喵哩”").foregroundColor(Color.accentColor))")
                Text("本app是非官方的B站客户端，哔哩哔哩是上海宽娱数码科技有限公司的商标。本app强烈建议您登录账号，以便B站官方可以正常收获网络流量，并且鼓励您尽可能使用官方app。本app中和B站相关的功能完全免费，请您再次确认本app与B站官方没有任何合作关系，认可并且尊重本app中所呈现的B站内容来自哔哩哔哩官方。")
                    .font(.footnote)
                Text("本app的开发者、负责人和实际责任人是\(Text("WindowsMEMZ").foregroundColor(Color.accentColor))\n联系QQ：3245146430")
                Button("开始使用", action: {
                    withAnimation(.smooth) {
                        showEnterPage = false
                    }
                })
                .buttonStyle(.borderedProminent)
            }
            .scenePadding(.horizontal)
        }
    }
}

#Preview {
    EnterPage()
}
