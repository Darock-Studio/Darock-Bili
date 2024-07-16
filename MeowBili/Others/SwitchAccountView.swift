//
//
//  SwitchAccountView.swift
//  DarockBili
//
//  Created by linecom on 2024/7/16.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import SwiftUI

struct SwitchAccountView: View {
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var userList1: [Any] = []
    @State var userList2: [Any] = []
    @State var userList3: [Any] = []
    @State var userList4: [Any] = []
    @State var isLoginSheetPersented = false
    var body: some View {
        NavigationStack {
            List {
                #if !os(watchOS)
                NavigationLink(destination: {
                    LoginView()
                    }, label: {
                        Label("User.switch.add", systemImage: "plus")
                    })
                #endif
                }
                
                if userList1.isEmpty {
                    Text("User.switch.none")
                        .bold()
                        .foregroundStyle(.secondary)
                } else {
                    Section(content: {
                        ForEach(0..<userList1.count, id: \.self) { user in
                            Button(action: {
                                dedeUserID = userList1[user] as! String
                                dedeUserID__ckMd5 = userList2[user] as! String
                                sessdata = userList3[user] as! String
                                biliJct = userList4[user] as! String
                            }, label: {
                                Text(userList1[user] as! String)
                            })
                        }
                        .onDelete(perform: { user in
                            userList1.remove(atOffsets: user)
                            userList2.remove(atOffsets: user)
                            userList3.remove(atOffsets: user)
                            userList4.remove(atOffsets: user)
                            UserDefaults.standard.set(userList1, forKey: "userList1")
                            UserDefaults.standard.set(userList2, forKey: "userList2")
                            UserDefaults.standard.set(userList3, forKey: "userList3")
                            UserDefaults.standard.set(userList4, forKey: "userList4")
                        })
                        .onMove(perform: { users, user  in
                            userList1.move(fromOffsets: users, toOffset: user)
                            userList2.move(fromOffsets: users, toOffset: user)
                            userList3.move(fromOffsets: users, toOffset: user)
                            userList4.move(fromOffsets: users, toOffset: user)
                            UserDefaults.standard.set(userList1, forKey: "userList1")
                            UserDefaults.standard.set(userList2, forKey: "userList2")
                            UserDefaults.standard.set(userList3, forKey: "userList3")
                            UserDefaults.standard.set(userList4, forKey: "userList4")
                        })
                    }, footer: {
                        Text("User.switch.description")
                        Text("User.switch.description.1")
                    })
                }
            }
        #if os(watchOS)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button(action: {
                            isLoginSheetPersented = true
                        }, label: {
                            Image(systemName: "plus")
                        }).sheet(isPresented: $isLoginSheetPersented, content: { LoginView() })
                    }
                }
            }
        #endif
            .onAppear() {
                    userList1 = UserDefaults.standard.array(forKey: "userList1") ?? []
                    userList2 = UserDefaults.standard.array(forKey: "userList2") ?? []
                    userList3 = UserDefaults.standard.array(forKey: "userList3") ?? []
                    userList4 = UserDefaults.standard.array(forKey: "userList4") ?? []
            }
            .buttonBorderShape(.roundedRectangle(radius: 13))
    }
}

#Preview {
    SwitchAccountView()
}
