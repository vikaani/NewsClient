//
//  FavoriteArticleStore.swift
//  NewsClient
//
//  Created by Vika on 08.07.2024.
//

import Foundation

protocol FavoriteArticleStore {
    var onRemoveArticle: ((FavoriteArticle) -> Void)? { get set}
    func save(_ article: FavoriteArticle) throws
    func removeArticle(byID id: UUID) throws 
}
