//
//  NewsView.swift
//  NewsClient
//
//  Created by Vika on 05.06.2024.
//

import UIKit

final class NewsView: UIView {
    let searchView: SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let articlesListByKeywordView: ArticlesListByKeywordView = {
        let view = ArticlesListByKeywordView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let breakingNews: BreakingNewsSectionView = {
        let view = BreakingNewsSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.layer.masksToBounds = false
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchHistoryView: SearchHistoryView = {
        let view = SearchHistoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let indicatorContainerView: IndicatorContainerView = {
        let view = IndicatorContainerView()
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
        addSubview(breakingNews)
        addSubview(categoriesCollectionView)
        addSubview(tableView)
        addSubview(searchView)
        addSubview(articlesListByKeywordView)
        addSubview(searchHistoryView)
        addSubview(indicatorContainerView)

        indicatorContainerView.setConstraintsEqual(to: self)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20),
            searchView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 40),
            
            articlesListByKeywordView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
            articlesListByKeywordView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            articlesListByKeywordView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            articlesListByKeywordView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            
            searchHistoryView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
            searchHistoryView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchHistoryView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchHistoryView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            
            breakingNews.topAnchor.constraint(equalTo: searchView.bottomAnchor,constant: 20),
            breakingNews.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 0),
            breakingNews.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 0),
            
            
            categoriesCollectionView.topAnchor.constraint(equalTo: breakingNews.bottomAnchor, constant: 20),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 45),
            
            
            tableView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

