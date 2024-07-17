//
//  ArticleWebsiteViewController.swift
//  NewsClient
//
//  Created by Vika on 04.07.2024.
//

import UIKit
import WebKit

final class ArticleWebsiteViewController: UIViewController {
    private let articleWebsiteView = ArticleWebsiteView()
    
    private var article: Article
    private let store: ArticleWebsiteLoader
    
    init(article: Article, store: ArticleWebsiteLoader) {
        self.article = article
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = articleWebsiteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: article.url)
        articleWebsiteView.webView.load(request)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .share,
            style: .done,
            target: self,
            action: #selector(didTapShareButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func didTapShareButton(_ sender: UIBarButtonItem) {
        let shareInfo = "\(article.title) - \(article.url)"
        let activityController = UIActivityViewController(activityItems: [shareInfo], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.hidesBottomBarWhenPushed = false
    }
}



