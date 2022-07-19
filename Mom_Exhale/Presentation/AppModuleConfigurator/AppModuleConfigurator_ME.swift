//
//  AppModuleConfigurator_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 05.01.2022.
//

import Foundation
import UIKit
import SwiftUI
#if ROOT_APP
import SamoprikormModule
import BabyTrackerModule
import CalmingNotificationsModule
#endif


protocol AppModuleConfiguratorProtocol_ME {
    static func configureModuleScene(by key: Module_ME.KeyName) -> UIViewController?
}


struct AppModuleConfigurator_ME: AppModuleConfiguratorProtocol_ME {
    
    static func configureModuleScene(by key: Module_ME.KeyName) -> UIViewController? {
        #if ROOT_APP
        switch key {
        case .BLW:
            let view = MainSceneConfigurator_SP.configure()
            return UIHostingController(rootView: view)
        case .calmingNotifications:
            let view = SplashSceneConfigurator_CN.configure()
            return view
        case .babyTracker:
            guard let _ = Bundle.BTWWModule().path(forResource: key.rawValue, ofType: "storyboardc") else { return nil }
            let stb = UIStoryboard(name: key.rawValue, bundle: Bundle.BTWWModule())
            guard let vc = stb.instantiateInitialViewController() else { return nil }
            return vc
        }
        #else
        return nil
        #endif
    }
}
