//
//  ArticleWebsiteStore.swift
//  NewsClient
//
//  Created by Vika on 08.07.2024.
//

import Foundation

protocol ArticleWebsiteLoader {
    func save(_ article: Article) throws
    func remove(_ article: Article) throws
} 
