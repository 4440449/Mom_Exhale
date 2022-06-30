//
//  AppModuleConfigurator_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 05.01.2022.
//

import UIKit
import SwiftUI
import SPM_TEST


protocol AppModuleConfiguratorProtocol_ME {
    static func configureModuleScene(by key: Module_ME.KeyName) -> UIViewController?
}


struct AppModuleConfigurator_ME: AppModuleConfiguratorProtocol_ME {
    
    private static func storyboard(name: String) -> UIViewController? {
         guard let _ = Bundle.main.path(forResource: name, ofType: "storyboardc") else { return nil }
         let stb = UIStoryboard(name: name, bundle: nil)
         guard let vc = stb.instantiateInitialViewController() else { return nil }
         return vc
     }
    
        
    static func configureModuleScene(by key: Module_ME.KeyName) -> UIViewController? {
        #if ROOT_APP
        switch key {
        case .BLW:
            let view = MainSceneConfigurator_SP.configure()
            return UIHostingController(rootView: view)
        case .calmingNotifications:
            return nil
//            let repositoryDIContainer = GatewaysRepositoryDIContainer_CN(
//                quoteCard:
//                    GatewaysRepositoryDIContainer_CN.createQuoteCardRepository(),
//                notification:
//                    GatewaysRepositoryDIContainer_CN.createNotificationRepository(),
//                menuItem:
//                    GatewaysRepositoryDIContainer_CN.createMenuItemRepository() )
//           return = SplashSceneConfigurator_CN.configure(
//                repositoryDIContainer: repositoryDIContainer )
        case .babyTracker:
            return storyboard(name: key.rawValue)
        }
        #else
        return nil
        
        #endif
    }
}
