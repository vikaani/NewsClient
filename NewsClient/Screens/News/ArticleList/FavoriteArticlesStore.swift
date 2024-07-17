//
//  FavoriteArticlesStore.swift
//  NewsClient
//
//  Created by Vika on 22.06.2024.
//

import Foundation

protocol FavoriteArticlesStore {
    func retrieve() throws -> Article
    func save(article: Article) throws
    func remove(article: Article) throws
}
