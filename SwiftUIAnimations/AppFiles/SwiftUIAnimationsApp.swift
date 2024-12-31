//
//  SwiftUIAnimationsApp.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 10/12/2024.
//

import SwiftUI
import Combine

@main
struct SwiftUIAnimationsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var cancelable: Set<AnyCancellable> = Set()
    
    init() {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification).sink { notification in
            print(notification.name.rawValue)
            print(UIDevice.current.orientation.rawValue)
        }
        .store(in: &cancelable)
    }
    
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
