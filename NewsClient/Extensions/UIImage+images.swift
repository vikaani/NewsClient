//
//  UIImage+images.swift
//  NewsClient
//
//  Created by Vika on 14.07.2024.
//

import UIKit

extension UIImage {
    static var defaultArticle: UIImage {
        UIImage(named: "emptyIcon")!
    }
    
    static var trash: UIImage {
        UIImage(systemName: "trash")!
    }
    
    static var heartFill: UIImage {
        UIImage(systemName: "heart.fill")!
    }
    
    static var heart: UIImage {
        UIImage(systemName: "heart")!
    }
    
    static var share: UIImage {
        UIImage(systemName: "square.and.arrow.up")!
    }
    
    static var noResult: UIImage {
        UIImage(named: "noResultsIcon")!
    }
}
