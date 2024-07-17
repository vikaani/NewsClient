//
//  SearchViewController.swift
//  NewsClient
//
//  Created by Vika on 14.07.2024.
//

import UIKit
import Combine

final class SearchViewController: NSObject {
    var searchView: SearchView? {
        didSet {
            guard let searchView else { return }
            setup(searchView)
        }
    }
    
    var onTextChange: ((String) -> Void)?
    var onTextDidBeginEditing: (() -> Void)?
    var onTextDidEndEditing: (() -> Void)?
    var onSelectSearch: ((String) -> Void)?
    var onCancel: (() -> Void)?
        
    @Published private var searchBarText: String = ""
    private var cancelabble = Set<AnyCancellable>()

    private let delay: Int
    
    init(delay: Int = 0) {
        self.delay = delay
    }

    private func setup(_ searchView: SearchView) {
        searchView.searchTextField.delegate = self
        searchView.searchTextField.addTarget(
            self,
            action: #selector(searchTextFieldTextChanged),
            for: .editingChanged
        )
        
        searchView.cancelButton.addTarget(
            self,
            action: #selector(didTapCancelButton),
            for: .touchUpInside
        )
        
        observeEvents()
    }
    
    @objc func searchTextFieldTextChanged(_ sender: UITextField) {
        searchBarText = sender.text!
    }
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        sender.isHidden = true
        searchView?.searchTextField.text = ""
        searchView?.searchTextField.resignFirstResponder()
        onTextChange?("")
        onCancel?()
    }
    
    private func observeEvents() {
        $searchBarText
            .dropFirst()
            .debounce(for: .seconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.onTextChange?(text)
                print(text)
            }.store(in: &cancelabble)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onSelectSearch?(textField.text!)
        textField.resignFirstResponder()

        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchView?.cancelButton.isHidden = false
        onTextDidBeginEditing?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onTextDidEndEditing?()
    }
}

