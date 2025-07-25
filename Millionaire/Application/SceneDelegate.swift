//
//  SceneDelegate.swift
//  Millionaire
//
//  Created by Иван Семенов on 21.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let userDefaultsManager = UserDefaultsManager.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        
        // STUB
        if userDefaultsManager.getUser() == nil {
            userDefaultsManager.createUser()
        }
        guard let user = userDefaultsManager.getUser() else { return }
        
        let factory = GameViewControllerFactoryImpl()
        let navVC = UINavigationController(rootViewController: .init())
        navVC.pushViewController(
            factory.createGameViewController(question: user.currentLevel, sum: user.getSum()),
            animated: false
        )
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
