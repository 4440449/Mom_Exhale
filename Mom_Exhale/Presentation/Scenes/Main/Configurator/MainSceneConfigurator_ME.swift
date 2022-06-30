//
//  MainSceneConfigurator_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import UIKit


final class MainSceneConfigurator_ME: SceneConfiguratorProtocol_ME {
    
    static func configure(repositoryDIContainer: GatewaysRepositoryDIContainerProtocol_ME) -> UIViewController {
        let moduleRepository = repositoryDIContainer.module
        let router = MainRouter_ME(navigationContainer: nil,
                                   repositoryDIContainer: repositoryDIContainer)
        let viewModel = MainViewModel_ME(repository: moduleRepository,
                                         router: router)
        
        let headerConfigurator = MainHeaderConfigurator_ME(repositoryDIContainer: repositoryDIContainer)
        let vc = MainViewController_ME(viewModel: viewModel,
                                       headerConfigurator: headerConfigurator)
        let navigationVC = UINavigationController(rootViewController: vc)
        router.navigationContainer = navigationVC
        return navigationVC
    }
}
