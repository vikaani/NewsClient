//
//  FavoritedArticleStore.swift
//  NewsClient
//
//  Created by Vika on 08.07.2024.
//

import Foundation

protocol FavoritedArticleStore {
    var onArticlesChange: (([FavoriteArticle]) -> Void)? { get set }
    func load()
    func remove(_ article: FavoriteArticle)
}
