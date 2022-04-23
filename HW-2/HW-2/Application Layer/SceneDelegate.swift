//
//  SceneDelegate.swift
//  HW-2
//
//  Created by Ramir Amrayev on 4/18/22.
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
        
        let tabBarVC = UITabBarController()
        
        let myFeedVC = UINavigationController(rootViewController: MyFeedViewController())
        let myFriendsVC = UINavigationController(rootViewController: MyFriendsViewController())
        let myPinsVC = UINavigationController(rootViewController: MyPinsViewController())
        let myProfileVC = UINavigationController(rootViewController: MyProfileViewController())
        
        myFeedVC.title = NSLocalizedString("My Feed", comment: "")
        myFriendsVC.title = NSLocalizedString("My Friends", comment: "")
        myPinsVC.title = NSLocalizedString("My Pins", comment: "")
        myProfileVC.title = NSLocalizedString("My Profile", comment: "")
        
        
        tabBarVC.setViewControllers([myFeedVC, myFriendsVC, myPinsVC, myProfileVC], animated: false)
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["text.below.photo.fill", "person.2.fill", "pin.fill", "person.crop.rectangle.fill"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}

