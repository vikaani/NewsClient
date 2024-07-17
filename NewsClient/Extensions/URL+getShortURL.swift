//
//  URL+getShortURL.swift
//  NewsClient
//
//  Created by Vika on 16.07.2024.
//

import Foundation

extension URL {
    func getShortURL() -> String {
        guard let host = self.host else {
            return self.absoluteString
        }
        
        let shortURL = host.replacingOccurrences(of: "www.", with: "")
        return shortURL
    }
}
