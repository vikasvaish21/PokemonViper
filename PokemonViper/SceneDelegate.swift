//
//  SceneDelegate.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        clearNavCIO15(UIColor.primaryColor)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
//        let navigationController = UINavigationController(rootViewController: SpeciesListRouter.createModule())
        let navigationController =  MainViewController()
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        PersistanceStorage.shared.saveContext()
    }

   
    
 

}

