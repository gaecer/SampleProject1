//
//  SceneDelegate.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 18/12/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: CoordinatorImp?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Setup the initial Window
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        // Create and Start the coordinator to begin the navigation
        appCoordinator = CoordinatorImp(window: window)
    }
}
