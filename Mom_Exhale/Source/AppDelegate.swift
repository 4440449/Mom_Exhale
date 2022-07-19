//
//  AppDelegate.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit
import PhotosUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    #if ROOT_APP
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isAllowed, error in }
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in }
    #endif
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
}

