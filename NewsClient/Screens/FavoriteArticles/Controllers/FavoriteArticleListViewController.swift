//
//  FavoriteArticleListViewController.swift
//  NewsClient
//
//  Created by Vika on 07.07.2024.
//

import UIKit

final class FavoriteArticleListViewController: NSObject {
    var tableView: UITableView? {
        didSet {
            guard let tableView else { return }
            setup(tableView)
        }
    }
    
    var articles: [FavoriteArticle] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var onRemoveArticle: ((FavoriteArticle) -> Void)?
    
    private let dateFormmater = {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.dateFormat = "d MMMM, HH:mm"
        return dateFormater
    }()
    
    var onSelectArticle: ((FavoriteArticle) -> Void)?
    
    private func setup(_ tableView: UITableView) {
        tableView.register(cellType: ArticleCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FavoriteArticleListViewController: UITableViewDataSource {
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
        
        if let imageData = article.imageData {
            cell.previewImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self else { return }
            
            let article = articles[indexPath.row]
            onRemoveArticle?(article)
        }
        
        deleteAction.backgroundColor = .appAccentColor
        deleteAction.image = .trash
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}

extension FavoriteArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        onSelectArticle?(article)
    }
}
