//
//  SkinExplorerView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/29.
//

import SwiftUI

struct SkinExplorerView: View {
    var body: some View {
        if #available(watchOS 10, *) {
            MainView()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: {SkinChooserView()}, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
        } else {
            MainView()
        }
    }
    
    struct MainView: View {
        @AppStorage("UsingSkin") var usingSkin = ""
        @State var skinNames = [String]()
        var body: some View {
            List {
                if #unavailable(watchOS 10) {
                    NavigationLink(destination: {SkinChooserView()}, label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("添加装扮")
                        }
                        .font(.system(size: 16, weight: .bold))
                    })
                }
                if skinNames.count != 0 {
                    Section {
                        Button(action: {
                            usingSkin = ""
                        }, label: {
                            Label("不使用装扮", systemImage: usingSkin == "" ? "checkmark" : "")
                        })
                    }
                    Section {
                        ForEach(0..<skinNames.count, id: \.self) { i in
                            Button(action: {
                                usingSkin = skinNames[i]
                            }, label: {
                                Label(skinNames[i], systemImage: usingSkin == skinNames[i] ? "checkmark" : "")
                            })
                        }
                    }
                } else {
                    Text("还没有装扮呢，去添加一个吧！")
                }
            }
            .navigationTitle("个性装扮")
            .onAppear {
                skinNames.removeAll()
                let files = AppFileManager(path: "skin").GetRoot() ?? [[:]]
                for file in files {
                    if file["isDirectory"]! == "true" {
                        skinNames.append(file["name"]!)
                    }
                }
            }
        }
    }
}

#Preview {
    SkinExplorerView()
}
