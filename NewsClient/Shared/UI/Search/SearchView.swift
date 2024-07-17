//
//  SearchView.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

final class SearchView: UIView {
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for news..."
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .search
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .systemGray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.appAccentColor, for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        backgroundView.backgroundColor = .systemBackground
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.2
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        backgroundView.layer.shadowRadius = 2
    }
    
    private func setupConstraints() {
        backgroundView.addSubview(searchTextField)
        backgroundView.addSubview(searchImageView)
        backgroundView.addSubview(searchImageView)

        stackView.addArrangedSubview(backgroundView)
        stackView.addArrangedSubview(cancelButton)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -5),
            searchTextField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            searchImageView.heightAnchor.constraint(equalToConstant: 20),
            searchImageView.widthAnchor.constraint(equalToConstant: 20),
            searchImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            searchImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
