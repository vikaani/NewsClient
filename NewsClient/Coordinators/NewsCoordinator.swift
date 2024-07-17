//
//  ArticleCoordinator.swift
//  NewsClient
//
//  Created by Vika on 17.06.2024.
//

import UIKit

final class NewsCoordinator {
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
        openNewsScreen()
    }
    
    private func openNewsScreen() {
        let articleLoader = NewsApiArticlesByCategoryLoader()
        let articleByKeywordLoader = NewsApiArticleByKeywordLoader()
        let vc = NewsViewController(
            favoriteArticleStore: self.loader,
            articleLoader: articleLoader,
            articleByKeywordLoader: articleByKeywordLoader
        )
        
        vc.onSelectArticle = openArtcileWebsiteScreen
        
        navigationController.viewControllers.append(vc)
    }
    
    private func openArtcileWebsiteScreen(article: Article) {
        let loader = self.loader
        let vc = ArticleWebsiteViewController(article: article, store: loader)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}

