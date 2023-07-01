//
//  FollowListView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/1.
//

import SwiftUI
import DarockKit
import SwiftyJSON
import SDWebImageSwiftUI

struct FollowListView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    var viewUserId: String
    @State var users = [[String: String]]()
    @State var nowPage = 1
    @State var totalPage = 1
    var body: some View {
        List {
            Section {
                if users.count != 0 {
                    ForEach(0...users.count - 1, id: \.self) { i in
                        NavigationLink(destination: {UserDetailView(uid: users[i]["UID"]!)}, label: {
                            HStack {
                                WebImage(url: URL(string: users[i]["Face"]! + "@40w"), options: [.progressiveLoad])
                                    .cornerRadius(100)
                                VStack {
                                    Text(users[i]["Name"]!)
                                        .font(.system(size: 16, weight: .bold))
                                        .lineLimit(2)
                                    Text(users[i]["Sign"]!)
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }
                            }
                        })
                    }
                }
            }
            Section {
                if nowPage > 1 {
                    Button(action: {
                        nowPage -= 1
                        RefreshNew()
                    }, label: {
                        Text("上一页")
                    })
                }
                Text("\(nowPage) / \(totalPage)")
                    .bold()
                if nowPage < totalPage {
                    Button(action: {
                        nowPage += 1
                        RefreshNew()
                    }, label: {
                        Text("下一页")
                    })
                }
            }
        }
        .onAppear {
            RefreshNew()
        }
    }
    func RefreshNew() {
        users = [[String: String]]()
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/followings?vmid=\(viewUserId)&order_type=&ps=20&pn=\(nowPage)") { respJson, isSuccess in
            if isSuccess {
                let datas = respJson["data"]["list"]
                for data in datas {
                    users.append(["Name": data.1["uname"].string!, "Face": data.1["face"].string!, "Sign": data.1["sign"].string!, "UID": String(data.1["mid"].int!)])
                }
                totalPage = respJson["data"]["total"].int! / 20 + 1
            }
        }
    }
}

#Preview {
    FollowListView(viewUserId: "356891781")
}
