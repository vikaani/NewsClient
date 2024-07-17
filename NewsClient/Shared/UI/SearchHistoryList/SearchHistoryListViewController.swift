//
//  SearchHistoryListViewController.swift
//  NewsClient
//
//  Created by Vika on 04.07.2024.
//

import UIKit

final class SearchHistoryListViewController: NSObject {
    var searchHistoryView: SearchHistoryView? {
        didSet {
            guard let view = searchHistoryView else { return }
            setup(view)
        }
    }
    
    var onSelectSearch: ((String) -> Void)?
    
    var isHidden = true {
        didSet {
            guard !searches.isEmpty || isHidden else { return }
            searchHistoryView?.isHidden = isHidden
        }
    }
    
    private var searches: [String] = [] {
        didSet {
            isHidden = searches.isEmpty
            searchHistoryView?.tableView.reloadData()
        }
    }
    
    private func setup(_ view: SearchHistoryView) {
        view.tableView.register(cellType: SearchHistoryCell.self)
        view.tableView.dataSource = self
        view.tableView.delegate = self
        
        view.clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        
        view.isHidden = isHidden
    }
    
    func save(searchText: String) {
        searches.insert(searchText, at: 0)
    }
    
    @objc private func didTapClearButton() {
        searches.removeAll()
    }
}

extension SearchHistoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !searches.isEmpty else { return 0 }
        guard searches.count > 4 else { return searches.count }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell: SearchHistoryCell = tableView.dequeueReusableCell(for: indexPath) 
        cell.titleLabel.text = searches[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
           
            self?.searches.remove(at: indexPath.row)
        }
        
        deleteAction.backgroundColor = .appAccentColor
        deleteAction.image = UIImage(systemName: "trash")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}

extension SearchHistoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSearch = searches[indexPath.row]
        onSelectSearch?(selectedSearch)
        isHidden = true
    }
}
