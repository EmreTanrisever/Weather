//
//  SceneDelegate.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let controller = SplashViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
        self.window = window
        window.tintColor = UIColor(named: "TabbarItemColor")
        window.makeKeyAndVisible()
    }
}

