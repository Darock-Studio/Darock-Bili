//
//  ContentView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("IsFirstUsing") var isFirstUsing = true
    @State var isGuidePresented = false
    var body: some View {
        NavigationStack {
            TabView {
                MainView()
                    .tag(1)
                PersonAccountView()
                    .tag(2)
            }
            .sheet(isPresented: $isGuidePresented, content: {FirstUsingView()})
            .onAppear {
                if isFirstUsing {
                    isGuidePresented = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
