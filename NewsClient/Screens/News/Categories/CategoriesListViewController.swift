//
//  CategoriesListViewController.swift
//  NewsClient
//
//  Created by Vika on 04.07.2024.
//

import UIKit

final class CategoriesListViewController: NSObject {
    var collectionView: UICollectionView? {
        didSet {
            guard let collectionView else { return }
            setup(collectionView)
        }
    }
    
    var isDarkMode = false {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var onSelectCategory: ((String) -> Void)?
    
    var categories: [CategoryItem] = [
        CategoryItem(name: "General", isSelected: true),
        CategoryItem(name: "Entertainment", isSelected: false),
        CategoryItem(name: "Business", isSelected: false),
        CategoryItem(name: "Health", isSelected: false),
        CategoryItem(name: "Sports", isSelected: false),
        CategoryItem(name: "Technology", isSelected: false)
    ]
    
    private func setup(_ collectionView: UICollectionView) {
        collectionView.register(CategoryCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CategoriesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let categoryItem = categories[indexPath.row]
        cell.titlelLabel.text = categoryItem.name
        
        cell.update(isSelected: categoryItem.isSelected,isDarkMode: isDarkMode)
        
        return cell
    }
}

extension CategoriesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let totalPadding: CGFloat = padding * 2
        
        let categoryName = categories[indexPath.row].name
        
        let textWidth = categoryName.sizeOf(.systemFont(ofSize: 17)).width
        let totalWidth = totalPadding + textWidth
        
        return CGSize(width: totalWidth, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemIndex = categories.firstIndex(where: { $0.isSelected == true })!
        categories[selectedItemIndex].isSelected = false
        categories[indexPath.row].isSelected = true
        
        let name = categories[indexPath.row].name
        onSelectCategory?(name)
        
        collectionView.reloadData()
    }
}
