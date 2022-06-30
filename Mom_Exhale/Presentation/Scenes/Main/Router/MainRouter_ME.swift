//
//  MainRouter_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 29.06.2022.
//

import Foundation
import UIKit



protocol MainRouterProtocol_ME {
    func showModule(by key: Module_ME.KeyName)
}


final class MainRouter_ME: MainRouterProtocol_ME {
    
    weak var navigationContainer: UINavigationController?
    private let repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME
    
    init(navigationContainer: UINavigationController?,
         repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME) {
        self.navigationContainer = navigationContainer
        self.repositoryDIContainer = repositoryDIContainer
    }
    
    func showModule(by key: Module_ME.KeyName) {
        guard let vc = AppModuleConfigurator_ME.configureModuleScene(by: key),
              let container = navigationContainer
        else {
            return
        }
        vc.modalPresentationStyle = .overFullScreen
        container.present(vc, animated: true, completion: nil)
    }
    
    func showAuthScene() {
//        let vc = AuthVC.configure()
//        let navVC = UINavigationController(rootViewController: vc)
//        navigationContainer?.present(true, animated: true, completion: nil)
    }
    
}
