//
//  BreakingNewsSectionView.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

final class BreakingNewsSectionView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Breaking News"
        label.font = UIFont(name: "Arial-BoldMT", size: 17) 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.appAccentColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.distribution = .fill
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(UIView())
        
        stackView.addArrangedSubview(seeAllButton)
        
        addSubview(stackView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
