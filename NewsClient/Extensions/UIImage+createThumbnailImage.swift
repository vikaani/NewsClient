//
//  UIImage+createThumbnailImage.swift
//  NewsClient
//
//  Created by Vika on 16.07.2024.
//

import UIKit

extension UIImage {
    func createThumbnailImage(size: CGSize) -> UIImage? {
        let scale = max(size.width / self.size.width, size.height / self.size.height)
        let width = self.size.width * scale
        let height = self.size.height * scale
        let newSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let jpegData = newImage?.jpegData(compressionQuality: 0.8) {
            return UIImage(data: jpegData)
        } else {
            return nil
        }
    }
}

