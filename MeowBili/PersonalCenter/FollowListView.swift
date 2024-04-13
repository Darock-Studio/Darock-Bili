//
//
//  FollowListView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import MobileCoreServices
#if !os(visionOS)
import SDWebImageSwiftUI
#endif
#if !os(watchOS) && !os(visionOS)
import AlertToast
#endif

struct FollowListView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    var viewUserId: String
    @State var users = [[String: String]]()
    @State var nowPage = 1
    @State var totalPage = 1
    @State var isLoadedFollows = false
    @State var isLoadingNew = false
    @State var pinnedUsers = [String]()
    @State var isDeleteUndoPresented = false
    @State var deletedUserName = ""
    @State var deletedUserId: Int64 = 0
    @State var isUndoCompletePresented = false
    @State var undoTipText = ""
    @State var isSelecting = false
    @State var isSelected = [Bool]()
    @State var deletedUserIds = [Int64]()
    @State var isMultipleUndoPresented = false
    var body: some View {
        List {
            if users.count != 0 {
                Section {
                    ForEach(0...users.count - 1, id: \.self) { i in
                        if !isSelecting {
                            NavigationLink(destination: { UserDetailView(uid: users[i]["UID"]!) }, label: {
                                HStack {
                                    if pinnedUsers.contains(users[i]["UID"]!) {
                                        Image(systemName: "pin.fill")
                                            .foregroundColor(.gray)
                                    }
                                    #if !os(visionOS)
                                    WebImage(url: URL(string: users[i]["Face"]! + "@56w"), options: [.progressiveLoad])
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .clipShape(Circle())
                                    #else
                                    AsyncImage(url: URL(string: users[i]["Face"]! + "@28w"))
                                        .clipShape(Circle())
                                    #endif
                                    VStack {
                                        HStack {
                                            Text(users[i]["Name"]!)
                                                .font(.system(size: 16))
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                    }
                                }
                            })
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button(action: {
                                    if pinnedUsers.contains(users[i]["UID"]!) {
                                        for j in 0..<pinnedUsers.count where pinnedUsers[j] == users[i]["UID"]! {
                                            pinnedUsers.remove(at: j)
                                            break
                                        }
                                    } else {
                                        pinnedUsers.append(users[i]["UID"]!)
                                        let ud = users.remove(at: i)
                                        users.insert(ud, at: 0)
                                    }
                                    UserDefaults.standard.set(pinnedUsers, forKey: "PinnedFollows")
                                }, label: {
                                    if pinnedUsers.contains(users[i]["UID"]!) {
                                        Image(systemName: "pin.slash.fill")
                                    } else {
                                        Image(systemName: "pin.fill")
                                    }
                                })
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive, action: {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata);",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(users[i]["UID"]!)!, act: 2, csrf: biliJct), headers: headers).response { response in
                                        debugPrint(response)
                                        let json = try! JSON(data: response.data!)
                                        let code = json["code"].int!
                                        if code == 0 {
                                            deletedUserName = users[i]["Name"]!
                                            deletedUserId = Int64(users[i]["UID"]!)!
                                            isDeleteUndoPresented = true
                                        } else {
                                            #if !os(visionOS) && !os(watchOS)
                                            AlertKitAPI.present(title: json["message"].string!, icon: .error, style: .iOS17AppleMusic, haptic: .error)
                                            #else
                                            tipWithText(json["message"].string!, symbol: "xmark.circle.fill")
                                            #endif
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "trash.fill")
                                })
                            }
                            #if !os(watchOS)
                            .onDrop(of: [UTType.data.identifier], isTargeted: nil) { items in
                                PlayHaptic(sharpness: 0.05, intensity: 0.5)
                                for item in items {
                                    item.loadDataRepresentation(forTypeIdentifier: UTType.data.identifier) { (data, _) in
                                        if let data = data, let dict = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String] {
                                            if dict["ID"] != nil {
                                                users.insert(dict, at: 0)
                                                let headers: HTTPHeaders = [
                                                    "cookie": "SESSDATA=\(sessdata)",
                                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                ]
                                                AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(dict["ID"]!)!, act: 1, csrf: biliJct), headers: headers).response { _ in }
                                            }
                                        }
                                    }
                                }
                                return true
                            }
                            #endif
                        } else {
                            Button(action: {
                                isSelected[i].toggle()
                            }, label: {
                                HStack {
                                    Image(systemName: isSelected[i] ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(Color.blue)
                                    Spacer()
                                        .frame(width: 2)
                                    if pinnedUsers.contains(users[i]["UID"]!) {
                                        Image(systemName: "pin.fill")
                                            .foregroundColor(.gray)
                                    }
                                    #if !os(visionOS)
                                    WebImage(url: URL(string: users[i]["Face"]! + "@28w"), options: [.progressiveLoad])
                                        .clipShape(Circle())
                                    #else
                                    AsyncImage(url: URL(string: users[i]["Face"]! + "@28w"))
                                        .clipShape(Circle())
                                    #endif
                                    VStack {
                                        HStack {
                                            Text(users[i]["Name"]!)
                                                .font(.system(size: 16))
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
            } else {
                ProgressView()
            }
            if (nowPage < totalPage) && !isSelecting {
                Section {
                    if !isLoadingNew {
                        Button(action: {
                            isLoadingNew = true
                            nowPage += 1
                            RefreshNew()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Home.more")
                                Spacer()
                            }
                        })
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .navigationTitle("User.subcribed-accounts")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarHidden(isDeleteUndoPresented || isMultipleUndoPresented || isUndoCompletePresented)
        #if !os(watchOS)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isSelected.removeAll()
                    for _ in users {
                        isSelected.append(false)
                    }
                    isSelecting.toggle()
                }, label: {
                    Text(isSelecting ? "完成" : "编辑")
                        .foregroundStyle(Color.blue)
                })
            }
            ToolbarItemGroup(placement: .bottomBar) {
                if isSelecting {
                    Spacer()
                    if isSelected.contains(where: { $0 }) {
                        Button(role: .destructive, action: {
                            isSelecting = false
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata);",
                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                            ]
                            for i in 0..<users.count {
                                if !isSelected[i] { continue }
                                AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(users[i]["UID"]!)!, act: 2, csrf: biliJct), headers: headers).response { _ in }
                                deletedUserIds.append(Int64(users[i]["UID"]!)!)
                            }
                            isMultipleUndoPresented = true
                        }, label: {
                            Text("从关注列表中移除")
                        })
                    }
                }
            }
        }
        #endif
        .onAppear {
            pinnedUsers = UserDefaults.standard.stringArray(forKey: "PinnedFollows") ?? [String]()
            if !isLoadedFollows {
                RefreshNew()
                isLoadedFollows = true
            }
        }
        #if !os(visionOS) && !os(watchOS)
        .toast(isPresenting: $isDeleteUndoPresented, duration: 8.0, tapToDismiss: true) {
            AlertToast(displayMode: .hud, type: .complete(.accentColor), title: "已将“\(deletedUserName)”从关注列表中移除", subTitle: "轻触以撤销", style: .style(titleFont: .system(size: 13, weight: .semibold), subTitleFont: .system(size: 11)))
        } onTap: {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: deletedUserId, act: 1, csrf: biliJct), headers: headers).response { response in
                debugPrint(response)
                let json = try! JSON(data: response.data!)
                let code = json["code"].int!
                if code == 0 {
                    undoTipText = "已撤销移除关注"
                    isUndoCompletePresented = true
                    nowPage = 1
                    users.removeAll()
                    RefreshNew()
                } else {
                    #if !os(visionOS)
                    AlertKitAPI.present(title: json["message"].string!, icon: .error, style: .iOS17AppleMusic, haptic: .error)
                    #endif
                }
            }
        }
        .toast(isPresenting: $isUndoCompletePresented, duration: 3.0) {
            AlertToast(displayMode: .hud, type: .systemImage("arrow.uturn.backward", .accentColor), title: undoTipText)
        }
        .toast(isPresenting: $isMultipleUndoPresented, duration: 10.0, tapToDismiss: true) {
            AlertToast(displayMode: .hud, type: .complete(.accentColor), title: "已将\(deletedUserIds.count)用户从关注列表中移除", subTitle: "轻触以撤销", style: .style(titleFont: .system(size: 13, weight: .semibold), subTitleFont: .system(size: 11)))
        } onTap: {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata);",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            for uid in deletedUserIds {
                AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: uid, act: 1, csrf: biliJct), headers: headers).response { _ in }
            }
            undoTipText = "已撤销\(deletedUserIds.count)个移除关注"
            isUndoCompletePresented = true
            nowPage = 1
            users.removeAll()
            RefreshNew()
            deletedUserIds.removeAll()
        }
        #endif
    }
    func RefreshNew() {
        let headers: HTTPHeaders = [
            "cookie": "SESSDATA=\(sessdata);",
            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        ]
        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/followings?vmid=\(viewUserId)&order_type=&ps=20&pn=\(nowPage)", headers: headers) { respJson, isSuccess in
            if isSuccess {
                if !CheckBApiError(from: respJson) { return }
                let datas = respJson["data"]["list"]
                for data in datas {
                    if pinnedUsers.contains(String(data.1["mid"].int ?? 0)) {
                        users.insert(["Name": data.1["uname"].string ?? "[加载失败]", "Face": data.1["face"].string ?? "E", "Sign": data.1["sign"].string ?? "[加载失败]", "UID": String(data.1["mid"].int64 ?? 0)], at: 0)
                    } else {
                        users.append(["Name": data.1["uname"].string ?? "[加载失败]", "Face": data.1["face"].string ?? "E", "Sign": data.1["sign"].string ?? "[加载失败]", "UID": String(data.1["mid"].int64 ?? 0)])
                    }
                }
                totalPage = respJson["data"]["total"].int ?? 0 / 20 + 1
                isLoadingNew = false
            }
        }
    }
}

struct FollowListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowListView(viewUserId: "356891781")
    }
}
