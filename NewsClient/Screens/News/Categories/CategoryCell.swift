//
//  CategoryCell.swift
//  NewsClient
//
//  Created by Vika on 04.07.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    let titlelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isDarkMode = false {
        didSet {
            
        }
    }
    
    func updatelabel(isSelected: Bool) {
        titlelLabel.textColor = isSelected ? .white : .black
    }
    
    private func getTitleLabelAccentColor(isSelected: Bool, isDarkMode: Bool) -> UIColor {
        switch (isSelected,isDarkMode) {
        case (true,true),(false, true),(true, false): return .white
        case (false,false): return .black
        }
    }
    
    func update(isSelected: Bool, isDarkMode: Bool) {
        titlelLabel.textColor = getTitleLabelAccentColor(isSelected: isSelected, isDarkMode: isDarkMode)
        
        
        if isSelected {
            backgroundContainerView.backgroundColor = .appAccentColor
        } else {
            backgroundContainerView.backgroundColor = .systemBackground
            backgroundContainerView.layer.shadowOpacity = 0.3
            backgroundContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            backgroundContainerView.layer.shadowRadius = 2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundContainerView.layer.cornerRadius = 10
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(backgroundContainerView)
        contentView.addSubview(titlelLabel)
        
        NSLayoutConstraint.activate([
            backgroundContainerView.topAnchor.constraint(equalTo: topAnchor),
            backgroundContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titlelLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titlelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
