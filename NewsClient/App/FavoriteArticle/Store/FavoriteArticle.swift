//
//  FavoriteArticle.swift
//  NewsClient
//
//  Created by Vika on 17.07.2024.
//

import Foundation

struct FavoriteArticle: Equatable {
    let id: UUID
    let title: String
    let description: String
    let url: URL
    let imageData: Data?
    let publishedAt: Date
}
