//
//  FavoriteArticleCoordinator.swift
//  NewsClient
//
//  Created by Vika on 17.06.2024.
//

import UIKit

final class FavoriteArticleCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }
    
    private let navigationController: UINavigationController
    private let loader: LocalFavoriteArticleLoader
    
    init(navigationController: UINavigationController, loader: LocalFavoriteArticleLoader) {
        self.navigationController = navigationController
        self.loader = loader
    }
    
    func start() {
        openFavoriteScreen()
    }
    
    private func openFavoriteScreen() {
        let modelController = FavoriteArticleModelController(store: loader)
        let vc = FavoriteArticleViewController(modelController: modelController)
        navigationController.viewControllers.append(vc)
    }
    
    private func openArtcileWebsiteScreen(article: Article) {
        let vc = ArticleWebsiteViewController(article: article, store: loader)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}

