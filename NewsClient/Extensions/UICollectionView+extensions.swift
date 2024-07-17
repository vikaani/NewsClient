//
//  UICollectionView+extensions.swift
//  NewsClient
//
//  Created by Vika on 04.07.2024.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        let className = String(describing: cellType)
        self.register(cellType, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Error: Could not dequeue cell with identifier: \(className)")
        }
        return cell
    }
}
