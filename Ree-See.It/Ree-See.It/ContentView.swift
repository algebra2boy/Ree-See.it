//
//  ContentView.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: MenuTab = .receipt
        
    var body: some View {
        TabView(selection: $selectedTab) {
            MenuTabView()
        }
    }
}

#Preview {
    ContentView()
}
