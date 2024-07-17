//
//  FavoriteArticleViewController.swift
//  NewsClient
//
//  Created by Vika on 06.07.2024.
//

import UIKit

final class FavoriteArticleViewController: UIViewController {
    private let favoriteArticleView = FavoriteArticleView()
    
    private let searchViewController = SearchViewController()
    private let searchHistoryViewController = SearchHistoryListViewController()
    
    private let articlesListViewController = FavoriteArticleListViewController()
    
    private var articles: [FavoriteArticle] = [] {
        didSet {
            articlesListViewController.articles = articles
        }
    }
    
    private var downloadedArticles: [FavoriteArticle] = []
    
    private let modelController: FavoriteArticleModelController
    
    init(modelController: FavoriteArticleModelController) {
        self.modelController = modelController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onSelectArticle: ((FavoriteArticle) -> Void)?
    
    override func loadView() {
        view = favoriteArticleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

private extension FavoriteArticleViewController {
    func setup() {
        setupControllers()
        setupModelController()
    }
    
    func setupModelController() {
        modelController.onArticlesChange = { [weak self] newArticles in
            self?.favoriteArticleView.emptyArticlesView.isHidden = !newArticles.isEmpty
            self?.articlesListViewController.articles = newArticles
        }
        
        modelController.load()
    }
    
    
    func setupControllers() {
        setupSearchHistoryViewController()
        setupSearchController()
        setupArticleListViewController()
    }
    
    func setupSearchHistoryViewController() {
        searchHistoryViewController.searchHistoryView = favoriteArticleView.searchHistoryView
        searchHistoryViewController.onSelectSearch = { [weak self] newText in
            self?.favoriteArticleView.searchView.searchTextField.text = newText
            self?.modelController.findArticles(withText: newText)
            
        }
    }
    
    func setupArticleListViewController() {
        articlesListViewController.tableView = favoriteArticleView.tableView
        articlesListViewController.onSelectArticle = { [weak self] article in
            self?.onSelectArticle?(article)
        }
        
        articlesListViewController.onRemoveArticle = { [weak self] article in
            self?.modelController.remove(article)
        }
    }
    
    func setupSearchController() {
        searchViewController.searchView = favoriteArticleView.searchView
        
        searchViewController.onTextChange = { [weak self] newText in
            self?.modelController.findArticles(withText: newText)
        }
        
        searchViewController.onTextDidBeginEditing = { [weak self] in
            self?.searchHistoryViewController.isHidden = false
        }
        
        searchViewController.onTextDidEndEditing = { [weak self] in
            self?.searchHistoryViewController.isHidden = true
        }
        
        searchViewController.onSelectSearch = { [weak self] newText in
            guard !newText.isEmpty else { return }
            self?.searchHistoryViewController.save(searchText: newText)
        }
    }
}




