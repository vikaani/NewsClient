//
//  NewsAPIEndpoint.swift
//  NewsClient
//
//  Created by Vika on 05.06.2024.
//

import Foundation

struct NewsApiEndpoint {
    private static let baseURL = "https://newsapi.org/v2/"
    private static let apiKey = "8bc1053ee7a54dc281cc7d59e2d81535"
    
    private init() {}
    
    static func getArticles(by category: String, page: Int) -> URL {
        let urlString = "\(baseURL)top-headlines?category=\(category)&country=us&page=\(page)&apiKey=\(apiKey)"
        return URL(string: urlString)!
    }
    
    static func getArticles(by keyword: String) -> URL {
        let urlString = "\(baseURL)everything?q=\(keyword)&apiKey=\(apiKey)"
        return URL(string: urlString)!
    }
}
