//
//
//  SkinExplorerView.swift
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

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
                            Text("Skin.add")
                        }
                        .font(.system(size: 16, weight: .bold))
                    })
                }
                if skinNames.count != 0 {
                    Section {
                        Button(action: {
                            usingSkin = ""
                        }, label: {
                            Label("Skin.none", systemImage: usingSkin == "" ? "checkmark" : "")
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
                    Text("Skin.nothing")
                }
            }
            .navigationTitle("Skin")
            .onAppear {
                skinNames.removeAll()
                let files = AppFileManager(path: "skin").GetRoot() ?? [[:]]
                for file in files {
                    if let isDirectory = file["isDirectory"] {
                        if isDirectory == "true" {
                            skinNames.append(file["name"]!)
                        }
                    }
                }
            }
        }
    }
}

struct SkinExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        SkinExplorerView()
    }
}
