//
//  String+sizeOf.swift
//  NewsClient
//
//  Created by Vika on 04.07.2024.
//

import UIKit

extension String {
    func sizeOf(_ font: UIFont) -> CGSize {
        let size = self.size(withAttributes: [NSAttributedString.Key.font: font])
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
    func boundingRectSize(withConstrainedWidth width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return CGSize(width: ceil(boundingBox.width), height: ceil(boundingBox.height))
    }
}

