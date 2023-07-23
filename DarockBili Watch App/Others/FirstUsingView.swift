//
//  FirstUsingView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/2.
//

import SwiftUI

struct FirstUsingView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("IsFirstUsing2") var isFirstUsing = true
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("欢迎使用腕上哔哩！")
                    Text("这里有一些值得注意的地方：")
                }
                Section {
                    Label("网络环境：", systemImage: "1.circle.fill")
                    Text("请确定 Watch 的状态栏（控制中心上方）显示为\(Image(systemName: "wifi"))而不是\(Image(systemName: "iphone"))")
                    Label("问题反馈：", systemImage: "2.circle.fill")
                    Text("腕上哔哩现在还处于测试阶段，遇到问题可以使用暗礁反馈（将在晚些时候上线）帮助我们改进")
                    Label("基本操作：", systemImage: "3.circle.fill")
                    Text("腕上哔哩切换页面主要靠点击和滑动，当您发现屏幕下方有小点时可尝试左右滑动切换页面")
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

struct NewVerInformationView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("LastUsingVer") var lastUsingVer = ""
    var infoUpdateVer = "1.0.0|106"
    @State var appGetVer = ""
    var body: some View {
        ScrollView {
            VStack {
                Text("您已更新到新版喵哩喵哩！")
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                if infoUpdateVer != appGetVer {
                    Spacer()
                        .frame(height: 20)
                    Text("警告：发布信息版本与 App 版本不匹配，开发者可能未更改发布信息，或此版本无显著更改")
                        .font(.system(size: 18))
                }
                Text("""
                
                
                发布信息:
                基本
                  App 图标已更改
                  已知问题:
                    未登录时尝试播放视频可能会崩溃(75651612)
                    多级导航、连续向下加载时可能出现导致崩溃的内存溢出问题(85111073)
                    偶现内存占用远超正常值(约 4 倍)
                    App 中的一些图片可能无法正常显示(13852689)
                启动:
                  已修复的问题:
                    新手指导可能会多次出现首页推荐
                  已修复的问题:
                    页面每次出现时都会向下加载新内容(46044875)
                视频详情
                  已修复的问题:
                    当前观看人数仅显示占位符(27092768)
                  已知问题:
                    进入视频详情页时有小概率崩溃(29123798)
                    仅音频播放无法正常使用(12706417)
                    右上角详情按钮无响应(16973338)
                    收藏视频时可能崩溃(34580307)
                评论
                  已修复的问题:
                    评论区可能无法加载所有评论(18930998)
                个人主页
                  已修复的问题:
                    用户粉丝、硬币数仅显示占位符(30026849)
                    在查看非本人账号时仍显示硬币数(仅占位符)
                    可能无法加载所有专栏(49652836)
                  已知问题:
                    第一屏可能出现布局错误(42845459)
                    第一屏操作按钮无响应(44650878)
                好友列表
                  已知问题:
                   粉丝列表无内容显示(61350129)
                离线缓存
                  已知问题:
                    尝试播放已缓存视频时仅显示占位符(25083414)
                反馈问题
                  新功能:
                    App 异常退出时会自动捕获异常信息，并在下次启动时显示并允许报告
                  已知问题:
                    发送反馈失败时没有提示(76686611)
                """)
                Button(action: {
                    lastUsingVer = ContentView.nowAppVer
                    dismiss()
                }, label: {
                    Text("了解！")
                })
            }
        }
        .onAppear {
            appGetVer = "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)|\(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)"
        }
    }
}

struct FirstUsingView_Previews: PreviewProvider {
    static var previews: some View {
        FirstUsingView()
    }
}
