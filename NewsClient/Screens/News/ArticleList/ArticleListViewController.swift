//
//  ArticleListViewController.swift
//  NewsClient
//
//  Created by Vika on 22.06.2024.
//

import UIKit
import SDWebImage

final class ArticleListViewController: NSObject {
    var tableView: UITableView? {
        didSet {
            guard let tableView else { return }
            setup(tableView)
        }
    }

    var articles: [Article] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var favoriteArticleStore: FavoriteArticleStore!
    
    private let dateFormmater = {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.dateFormat = "d MMMM, HH:mm"
        return dateFormater
    }()
    
    var onLoadNextPage: (() -> Void)?
    var onSelectArticle: ((Article) -> Void)?
    
    private var images: [IndexPath: UIImage] = [:]
    
    private var offsetObserver: NSKeyValueObservation?
    
    private func setup(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(cellType: ArticleCell.self)
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleCell = tableView.dequeueReusableCell(for: indexPath)
        
        let article = articles[indexPath.row]
        
        cell.titleLabel.text = article.title
        
        let dateString = dateFormmater.string(from: article.publishedAt)
        let shortURL = article.url.getShortURL()
        
        cell.infoLabel.text = "\(dateString)  \(shortURL)"
        cell.isFavorite = article.isFavorited
        cell.previewImageView.sd_setImage(with: article.imageURL,placeholderImage: .defaultArticle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        offsetObserver = tableView.observe(\.contentOffset,options: .new, changeHandler: { [weak self] tableView, contentOffset in
            guard tableView.isDragging else { return }
            let contentHeight = tableView.contentSize.height
            let tableViewHeight = tableView.frame.size.height


            if tableView.contentOffset.y > contentHeight - tableViewHeight {
                self?.onLoadNextPage?()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let article = articles[indexPath.row]
        
        let saveAction = UIContextualAction(style: .normal, title: article.isFavorited ? "Unsave" : "Save") { [weak self] _, _, completionHandler in
            guard let self else { return }
            
            articles[indexPath.row].isFavorited.toggle()
            let article = articles[indexPath.row]
            
            let cell = tableView.cellForRow(at: indexPath) as! ArticleCell
            
            let favoriteArticle = FavoriteArticle(
                id: article.id,
                title: article.title,
                description: article.description,
                url: article.url,
                imageData: cell.previewImageView.image?.pngData(),
                publishedAt: article.publishedAt
            )
            
            if article.isFavorited {
                try? favoriteArticleStore.save(favoriteArticle)
            } else {
                try? favoriteArticleStore.removeArticle(byID: favoriteArticle.id)
            }
            
            completionHandler(true)
        }

        saveAction.image = article.isFavorited ? .heartFill : .heart
        saveAction.backgroundColor = article.isFavorited ? .appAccentColor : .unsave
        let config = UISwipeActionsConfiguration(actions: [saveAction])
        return config
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        onSelectArticle?(article)
    }
}

