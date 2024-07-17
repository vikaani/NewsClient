//
//  FavoriteArticleView.swift
//  NewsClient
//
//  Created by Vika on 07.07.2024.
//

import UIKit

final class FavoriteArticleView: UIView {
    let searchView: SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchHistoryView: SearchHistoryView = {
        let view = SearchHistoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let emptyArticlesView: FavoriteArticleEmptyView = {
        let view = FavoriteArticleEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(tableView)
        addSubview(emptyArticlesView)
        addSubview(searchHistoryView)
        addSubview(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20),
            searchView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 40),
            
            searchHistoryView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
            
            searchHistoryView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchHistoryView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchHistoryView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            emptyArticlesView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            emptyArticlesView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyArticlesView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            emptyArticlesView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
