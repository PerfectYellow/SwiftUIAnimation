//
//  MPHome.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 19/12/2024.
//

import SwiftUI

struct MPHome: View {
    @State private var showMiniPlayer: Bool = false
    
    var body: some View {
        TabView {
            Tab.init("Home", systemImage: "house") {
                Text("Home")
            }
            
            Tab.init("Search", systemImage: "magnifyingglass") {
                Text("Search")
            }
            
            Tab.init("Notifications", systemImage: "bell") {
                Text("Notifications")
            }
            
            Tab.init("Setting", systemImage: "gearshape") {
                Text("Setting")
            }
        }
        .universalOverlay(show: $showMiniPlayer) {
            ExpandableMusicPlayer(show: $showMiniPlayer)
        }
        .onAppear {
            showMiniPlayer = true
        }
    }
}

#Preview {
    RootView {
        MPHome()
    }
}
