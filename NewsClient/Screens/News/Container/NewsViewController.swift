//
//  NewsViewController.swift
//  NewsClient
//
//  Created by Vika on 03.06.2024.
//

import UIKit

final class NewsViewController: UIViewController {
    private let articleView = NewsView()
    
    private let searchViewController = SearchViewController()
    
    private let breakingNewsSectionViewController = BreakingNewsSectionViewController()
    private let searchHistoryListViewController = SearchHistoryListViewController()
    private let categoriesListViewController = CategoriesListViewController()
    private let articlesListViewController = ArticleListViewController()
    private let articlesListByKeywordViewController = ArticleListViewController()
    
    private var articles: [Article] = [] {
        didSet {
            print("Current page -\(pagination.currentPage)")
            updateArticlesList()
        }
    }
    
    private var downloadedArticles: [Article] = []
    private var favoriteArticleStore: FavoriteArticleStore
    private let articleLoader: ArticlesByCategoryLoader
    private let articleByKeywordLoader: ArticleByKeywordLoader
    private var pagination = Pagination()
    private var isPagination = false
    
    private let operationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    var onSelectArticle: ((Article) -> Void)?
    
    init(favoriteArticleStore: FavoriteArticleStore,
         articleLoader: ArticlesByCategoryLoader,
         articleByKeywordLoader: ArticleByKeywordLoader) {
        self.favoriteArticleStore = favoriteArticleStore
        self.articleLoader = articleLoader
        self.articleByKeywordLoader = articleByKeywordLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = articleView
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        categoriesListViewController.isDarkMode = isDarkMode
    }
    
    func unsavedArticle(withID id: UUID) {
        guard let index = articles.firstIndex(where: { $0.id == id}) else { return }
        articles[index].isFavorited = false
    }
}

private extension NewsViewController {
    func setup() {
        setupControllers()
        loadInitialData()
        observeEvents()
    }
    
    func updateUI(articles: [Article]) {
        self.articles = articles
    }
    
    func updateArticlesList() {
        if breakingNewsSectionViewController.articles.isEmpty {
            breakingNewsSectionViewController.articles = Array(articles[0...5])
            articlesListViewController.articles = Array(articles[6...])
        } else {
            articlesListViewController.articles = articles
        }
    }
    
    func observeEvents() {
        favoriteArticleStore.onRemoveArticle = { [weak self] article in
            self?.unsavedArticle(withID: article.id)
        }
    }
}

private extension NewsViewController {
    func setupControllers() {
        setupBreakingNewsViewController()
        setupSearchController()
        setupCategoriesViewController()
        setupArticlesListViewController()
        setupSearchHistoryViewController()
        setupArticlesListByKeywordViewController()
    }
    
    func setupBreakingNewsViewController() {
        breakingNewsSectionViewController.breakingNewsSectionView = articleView.breakingNews
        
        breakingNewsSectionViewController.onSelectArticle = { [weak self] article in
            self?.onSelectArticle?(article)
        }
    }
    
    func setupCategoriesViewController() {
        categoriesListViewController.collectionView = articleView.categoriesCollectionView
        categoriesListViewController.isDarkMode = isDarkMode
        
        categoriesListViewController.onSelectCategory = { [weak self] category in
            self?.loadData(forCategory: category.lowercased())
        }
    }
    
    func setupArticlesListViewController() {
        articlesListViewController.tableView = articleView.tableView
        articlesListViewController.favoriteArticleStore = favoriteArticleStore
        
        articlesListViewController.onLoadNextPage = { [weak self] in
            self?.loadNextPage()
        }
        
        articlesListViewController.onSelectArticle = { [weak self] article in
            self?.onSelectArticle?(article)
        }
    }
    
    func setupArticlesListByKeywordViewController() {
        articlesListByKeywordViewController.tableView = articleView.articlesListByKeywordView.tableView
        articlesListByKeywordViewController.favoriteArticleStore = favoriteArticleStore
        
        articlesListByKeywordViewController.onLoadNextPage = { [weak self] in
            self?.loadNextPage()
        }
        
        articlesListByKeywordViewController.onSelectArticle = { [weak self] article in
            self?.onSelectArticle?(article)
        }
    }
    
    func setupSearchHistoryViewController() {
        searchHistoryListViewController.searchHistoryView = articleView.searchHistoryView
        searchHistoryListViewController.onSelectSearch = {[weak self] search in
            self?.searchViewController.searchView?.searchTextField.text = search
        }
    }
    
    func setupSearchController() {
        searchViewController.searchView = articleView.searchView
        
        searchViewController.onTextDidBeginEditing = { [weak self] in
            self?.searchHistoryListViewController.isHidden = false
        }
        
        searchViewController.onTextDidEndEditing = { [weak self] in
            self?.searchHistoryListViewController.isHidden = true
        }
        
        searchViewController.onSelectSearch = { [weak self] newText in
            self?.searchHistoryListViewController.save(searchText: newText)
            self?.articleByKeywordLoader.load(keyword: newText, completionHandler: { result in
                switch result {
                case .success(let articles):
                    DispatchQueue.main.async {
                        self?.articleView.articlesListByKeywordView.isHidden = false
                        self?.articlesListByKeywordViewController.articles = articles
                    }
                    
                case .failure(let failure):
                    print(failure)
                }
            })
        }
        
        searchViewController.onCancel = { [weak self] in
            self?.articleView.articlesListByKeywordView.isHidden = true
        }
    }
}

private extension NewsViewController {
    func loadNextPage() {
        guard !isPagination else { return }
        guard !pagination.isCompleted else { return }
        
        isPagination = true
        
        pagination.currentPage += 1
        
        let parameters = Parameters(
            category: "",
            page: pagination.currentPage
        )
        
        articleLoader.loadData(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.isPagination = false
                    self?.articles.append(contentsOf: articles)
                    self?.downloadedArticles.append(contentsOf: articles)
                }
            case .failure(_):
                break
            }
            
        }
    }
    
    func loadData(forCategory category: String) {
        let parameters = Parameters(category: category, page: 1)
        articleLoader.loadData(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.articles = articles
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func loadInitialData() {
        let parameters = Parameters(category: "", page: pagination.currentPage)
        articleLoader.loadData(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                        self?.articleView.indicatorContainerView.stopAnimating()
                    }
                    self?.articles = articles
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func loadNewsData(parameters: Parameters) {
        articleLoader.loadData(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.articles = articles
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

