//
//  Pagination.swift
//  NewsClient
//
//  Created by Vika on 17.07.2024.
//

import Foundation

struct Pagination {
    var currentPage = 1
    var maxPage = 3
    
    var isCompleted: Bool {
        currentPage == maxPage
    }
}
