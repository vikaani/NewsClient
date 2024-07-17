//
//  BreakingNewsCell.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

final class BreakingNewsCell: UICollectionViewCell {
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Arial-BoldMT", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 11)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.addOverlay(alpha: 0.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleInfoStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
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
        titleInfoStackView.addArrangedSubview(sourceLabel)
        titleInfoStackView.addArrangedSubview(titleLabel)

        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(previewImageView)
        contentView.addSubview(titleInfoStackView)
        contentView.addSubview(descriptionLabel)
        
        previewImageView.setConstraintsEqual(to: contentView)
        
        NSLayoutConstraint.activate([
            titleInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
