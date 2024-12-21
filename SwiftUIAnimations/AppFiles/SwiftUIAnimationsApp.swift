//
//  SwiftUIAnimationsApp.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 10/12/2024.
//

import SwiftUI

@main
struct SwiftUIAnimationsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            SH3ContentView()
            
//            RootView {
//                UOContentView()
//            }
            
//            HAContentView()
            
            RootView {
                MPContentView()
            }
        }
    }
}
