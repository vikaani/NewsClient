//
//  TabBarButton.swift
//  NewsClient
//
//  Created by Vika on 12.07.2024.
//

import UIKit

class TabBarButton: UIButton {
    init(image: UIImage, title: String) {
        var config = UIButton.Configuration.plain()
        config.image = image
        let newsButtonTitle = title
        var attributedTitle = AttributedString(newsButtonTitle)
        attributedTitle.setAttributes(AttributeContainer([.font: UIFont.systemFont(ofSize: 13, weight: .medium)]))
        
        config.attributedTitle = attributedTitle
        config.baseBackgroundColor = .systemGray4
        config.imagePadding = 4.0
        config.baseForegroundColor = .black
        
        config.imagePlacement = .top
        config.buttonSize = .medium
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 2,
            bottom: 5,
            trailing: 2
        )
        
        super.init(frame: .zero)
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

