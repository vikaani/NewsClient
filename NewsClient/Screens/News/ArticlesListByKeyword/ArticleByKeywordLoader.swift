//
//  ArticleByKeywordLoader.swift
//  NewsClient
//
//  Created by Vika on 14.07.2024.
//

import Foundation

protocol ArticleByKeywordLoader {
    func load(keyword: String, completionHandler: @escaping (Result<[Article],Error>) -> Void)
}
