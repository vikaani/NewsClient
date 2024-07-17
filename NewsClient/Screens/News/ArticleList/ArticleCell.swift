//
//  ArticleCell.swift
//  NewsClient
//
//  Created by Vika on 05.06.2024.
//

import UIKit

final class ArticleCell: UITableViewCell {
    let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoLabel: UILabel = {
        let date = UILabel()
        date.font = .systemFont(ofSize: 10)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoLabel,favoriteImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    var isFavorite = false {
        didSet {
            favoriteImageView.isHidden = !isFavorite
            favoriteImageView.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }
    
    private let imageHeight: CGFloat = 90
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.image = nil
    }
    
    private func setupViews() {
        selectionStyle = .none
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(previewImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            previewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            previewImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            previewImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            previewImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            stackView.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor,constant: -30),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
}
