//
//  NewsApiArticleByKeywordLoader.swift
//  NewsClient
//
//  Created by Vika on 15.07.2024.
//

import Foundation

final class NewsApiArticleByKeywordLoader: ArticleByKeywordLoader {
    enum ArticleError: Error {
        case invalidURL, invalidData
    }
    
    func load(keyword: String, completionHandler: @escaping (Result<[Article],Error>) -> Void) {
        let url = NewsApiEndpoint.getArticles(by: keyword)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                jsonDecoder.dateDecodingStrategy = .iso8601

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
                completionHandler(.failure(ArticleError.invalidData))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
