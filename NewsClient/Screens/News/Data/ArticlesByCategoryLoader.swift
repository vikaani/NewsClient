//
//  NewsInfoLoader.swift
//  NewsClient
//
//  Created by Vika on 03.06.2024.
//

import Foundation

protocol ArticlesByCategoryLoader {
    func loadData(parameters: Parameters, completionHandler: @escaping (Result<[Article],Error>) -> Void)
}
