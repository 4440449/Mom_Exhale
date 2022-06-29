//
//  MainSceneConfigurator_ME.swift
//  Mom Exhale
//
//  Created by Maxim on 31.12.2021.
//

import Foundation
import UIKit

protocol SceneConfiguratorProtocol_CN { }


final class MainSceneConfigurator_ME: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let repository = GatewaysRepositoryDIContainer_ME.createModuleRepository()
        let viewModel = MainViewModel_ME(repository: repository)
        let vc = MainViewController_ME(viewModel: viewModel)
        let navigationVC = UINavigationController(rootViewController: vc)
        return navigationVC
    }
}
