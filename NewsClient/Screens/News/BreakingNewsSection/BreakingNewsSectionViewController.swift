//
//  BreakingNewsSectionViewController.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit
import SDWebImage

final class BreakingNewsSectionViewController: NSObject {
    var breakingNewsSectionView: BreakingNewsSectionView? {
        didSet {
            guard let breakingNewsSectionView else { return }
            setup(breakingNewsSectionView)
        }
    }
    
    var articles: [Article] = [] {
        didSet {
            breakingNewsSectionView?.collectionView.reloadData()
        }
    }
    
    var onSelectArticle: ((Article) -> Void)?
    
    private func setup(_ view: BreakingNewsSectionView) {
        view.collectionView.register(BreakingNewsCell.self)
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
    }
}

extension BreakingNewsSectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BreakingNewsCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let article = articles[indexPath.row]
        cell.sourceLabel.text = article.url.getShortURL()
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        cell.previewImageView.image = .defaultArticle

        cell.previewImageView.sd_setImage(with: article.imageURL,placeholderImage: UIImage(named: "emptyIcon"))
        
        return cell
    }
}

extension BreakingNewsSectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         CGSize(
            width: collectionView.bounds.width - 85,
            height: collectionView.bounds.height
         )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        onSelectArticle?(article)
    }
    
}
