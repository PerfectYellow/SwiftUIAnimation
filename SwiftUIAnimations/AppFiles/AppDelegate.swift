//
//  AppDelegate.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 21/12/2024.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("launch 2")
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Background")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Terminated")
    }
}
