//
//  Article.swift
//  NewsClient
//
//  Created by Vika on 03.06.2024.
//

import Foundation

struct Article {
    let id: UUID
    let title: String
    let description: String
    let content: String
    let url: URL
    let imageURL: URL?
    let publishedAt: Date
    var isFavorited: Bool
}
