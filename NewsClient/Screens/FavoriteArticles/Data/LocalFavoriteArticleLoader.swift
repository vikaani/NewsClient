//
//  FavoriteArticleLoaderStore.swift
//  NewsClient
//
//  Created by Vika on 08.07.2024.
//

import Foundation

protocol FavoriteArticleLoaderStore {
    func save(_ article: FavoriteArticle) throws
    func removeArticle(byID id: UUID) throws
    func retrieve() throws -> [FavoriteArticle]
}

class LocalFavoriteArticleLoader {
    var onArticlesChange: (([FavoriteArticle]) -> Void)?
    var onRemoveArticle: ((FavoriteArticle) -> Void)?
    
    let store: FavoriteArticleLoaderStore
    
    var articles: [FavoriteArticle] = [] {
        didSet {
            onArticlesChange?(articles)
        }
    }
    
    init(store: FavoriteArticleLoaderStore) {
        self.store = store
    }
}

extension LocalFavoriteArticleLoader: ArticleWebsiteLoader {
    func save(_ article: Article) throws {
        let favoriteArticle = FavoriteArticle(
            id: article.id,
            title: article.title,
            description: article.description,
            url: article.url,
            imageData: nil,
            publishedAt: article.publishedAt
        )
        
        articles.append(favoriteArticle)
        try! store.save(favoriteArticle)
    }
    
    func remove(_ article: Article) throws {
        try removeArticle(byID: article.id)
    }
    
}

extension LocalFavoriteArticleLoader: FavoriteArticleStore {
    func save(_ article: FavoriteArticle) throws {
        articles.append(article)
        try! store.save(article)
    }
    
    func removeArticle(byID id: UUID) throws {
        articles.removeAll(where: { $0.id == id })
        try store.removeArticle(byID: id)
    }
}

extension LocalFavoriteArticleLoader: FavoritedArticleStore {
    func load() {
        articles = try! store.retrieve()
    }
    
    func remove(_ article: FavoriteArticle) {
        onRemoveArticle?(article)
        try? removeArticle(byID: article.id)
    }
}
