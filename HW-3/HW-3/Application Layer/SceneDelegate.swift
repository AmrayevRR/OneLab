//
//  SceneDelegate.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/26/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let newsPage = NewsPage(viewModel: NewsViewModel(newsService: NewsServiceImpl()))
        window?.rootViewController = UINavigationController(rootViewController: newsPage)
        window?.makeKeyAndVisible()
    }

}

