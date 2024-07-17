//
//  NewsApiArticlesByCategoryLoader.swift
//  NewsClient
//
//  Created by Vika on 03.06.2024.
//

import UIKit

final class NewsApiArticlesByCategoryLoader: ArticlesByCategoryLoader {
    fileprivate enum NewsError: Error {
        case invalidURL, invalidData
    }
    
    func loadData(parameters: Parameters, completionHandler: @escaping (Result<[Article], Error>) -> Void) {
        let url = NewsApiEndpoint.getArticles(by: parameters.category, page: parameters.page)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try JSONDecoder().decode(DecodableArticleInfo.self, from: responseData)
                
                
                let articles: [Article] = response.articles
                    .compactMap { article in
                        guard let title = article.title,
                              !title.contains("Removed"),
                              let articleURLString = article.url,
                              let url = URL(string: articleURLString),
                              let imageURLString = article.urlToImage,
                              let imageURL =  URL(string: imageURLString)
                        else {
                            return nil
                        }
                        
                        return Article(
                            id: UUID(),
                            title: title,
                            description: article.description ?? "",
                            content: article.content ?? "",
                            url: url,
                            imageURL: imageURL,
                            publishedAt: Date(),
                            isFavorited: false
                        )
                    }
                
                completionHandler(.success(articles))
                
            } catch {
                completionHandler(.failure(NewsError.invalidData))
                print(error.localizedDescription)
            }
        }.resume()
    }
}



struct DecodableArticleInfo: Decodable {
    let status: String
    let totalResults: Int
    let articles: [DecodableArticle]
}

struct DecodableArticle: Decodable {
    let source: DecodableSource
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct DecodableSource: Decodable {
    let id: String?
    let name: String?
}
