//
//  FavoriteArticleEmptyView.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

final class FavoriteArticleEmptyView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Empty"
        label.textColor = .gray
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notFoundImageView: UIImageView = {
        let imageView = UIImageView(image: .noResult)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
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
        stackView.addArrangedSubview(notFoundImageView)
        stackView.addArrangedSubview(titleLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            notFoundImageView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
}
