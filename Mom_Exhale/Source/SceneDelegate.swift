//
//  SceneDelegate.swift
//  Mom Exhale
//
//  Created by Maxim on 27.12.2021.
//

import UIKit
import MommysEye


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let repositoryDIContainer = GatewaysRepositoryDIContainer_ME()
        let mainVC = MainSceneConfigurator_ME.configure(repositoryDIContainer: repositoryDIContainer)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

