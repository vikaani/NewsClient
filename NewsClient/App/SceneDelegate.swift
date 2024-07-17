//
//  SceneDelegate.swift
//  NewsClient
//
//  Created by Vika on 03.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        window.makeKeyAndVisible()
        
        openMainScreen()
    }
    
    var store: FavoriteArticleLoaderStore = CoreDataFavoriteArticleStore()
    
    private func openMainScreen() {
        let localSavedArticleLoader = LocalFavoriteArticleLoader(store: store)
        
        let newsCoordinator = NewsCoordinator(
            navigationController: UINavigationController(),
            loader: localSavedArticleLoader
        )
        
        let favoriteCoordinator = FavoriteArticleCoordinator(
            navigationController: UINavigationController(),
            loader: localSavedArticleLoader
        )
        
        let newsModel = TabBarModel(
            image: UIImage(systemName: "list.bullet.rectangle")!.applyingSymbolConfiguration(.init(pointSize: 15))!,
            title: "News",
            viewController: newsCoordinator.rootViewController
        )
        
        let favoriteArticleModel = TabBarModel(image: UIImage(systemName: "heart")!.applyingSymbolConfiguration(.init(pointSize: 15))!, title: "Saved", viewController: favoriteCoordinator.rootViewController)
        
        let tabBarController = MainTabBarController(models: [
            newsModel,
            favoriteArticleModel
        ])
        
        window?.rootViewController = tabBarController
        newsCoordinator.start()
        favoriteCoordinator.start()
    }
}

