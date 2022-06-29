//
//  GlobalRouter_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 05.01.2022.
//

import UIKit
import SwiftUI
import SPM_TEST


//import Samoprikorm_SPM


final class GlobalRouter_ME {
    
    private static func storyboard(name: String) -> UIViewController? {
         guard let _ = Bundle.main.path(forResource: name, ofType: "storyboardc") else { return nil }
         let stb = UIStoryboard(name: name, bundle: nil)
         guard let vc = stb.instantiateInitialViewController() else { return nil }
         return vc
     }
    
    private func manual() -> UIViewController? {
        return nil
    }
    
    private func swiftUi() -> UIViewController? {
//        return UIHostingController(rootView: view)
        return nil
    }
    
    
    static func initVC(module: Module) -> UIViewController? {
        #if ROOT_APP
        switch module.keyName {
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
            return storyboard(name: module.keyName.rawValue)
        }
        #else
        return nil
        
        #endif
    }
}
