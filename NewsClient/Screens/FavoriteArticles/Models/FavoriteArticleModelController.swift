//
//  FavoriteArticleModelController.swift
//  NewsClient
//
//  Created by Vika on 08.07.2024.
//

import UIKit

final class FavoriteArticleModelController {
    var onArticlesChange: (([FavoriteArticle]) -> Void)?
    
    private var articles: [FavoriteArticle] = [] {
        didSet {
            onArticlesChange?(articles)
        }
    }
    
    private var downloadedArticles: [FavoriteArticle] = []
    
    private var store: FavoritedArticleStore
    
    init(store: FavoritedArticleStore) {
        self.store = store
    }
    
    func load() {
        store.onArticlesChange = { [weak self] newArticles in
            self?.articles = newArticles
            self?.downloadedArticles = newArticles
        }
        
        store.load()
    }
    
    func remove(_ article: FavoriteArticle) {
        store.remove(article)
    }
    
    func findArticles(withText text: String) {
        if text.isEmpty {
            articles = downloadedArticles
            return
        }
        
        let filteredArticles = downloadedArticles.filter { article in
            article.title.lowercased().contains(text.lowercased())
        }
        
        articles = filteredArticles
    }
}

