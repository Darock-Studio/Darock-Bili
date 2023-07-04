//
//  DownloadsView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/4.
//

import SwiftUI

struct DownloadsView: View {
    var body: some View {
        List {
            VStack {
                Text("很快到来")
                    .bold()
                Text("Darock 正在努力开发，将会很快更新")
            }
        }
        .onAppear {
            let files = AppFileManager(path: "dlds").GetRoot() ?? [[String: String]]()
            for file in files {
                debugPrint(file)
            }
        }
    }
}

struct DownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadsView()
    }
}
