//
//  SceneDelegate.swift
//  Millionaire
//
//  Created by Иван Семенов on 21.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // STUB
        let factory = GameViewControllerFactoryImpl()
        let navVC = UINavigationController(rootViewController: .init())
        navVC.pushViewController(factory.createGameViewController(), animated: false)
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
