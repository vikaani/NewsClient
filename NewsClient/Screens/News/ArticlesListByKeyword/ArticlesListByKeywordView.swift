//
//  ArticlesListByKeywordView.swift
//  NewsClient
//
//  Created by Vika on 14.07.2024.
//

import UIKit

final class ArticlesListByKeywordView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        
        addSubview(tableView)
        
        tableView.setConstraintsEqual(to: self)
    }
}
