//
//  ContentView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MainView()
                    .tag(1)
                PersonAccountView()
                    .tag(2)
            }
        }
    }
}

#Preview {
    ContentView()
}
