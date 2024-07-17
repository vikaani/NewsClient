//
//  TabBarView.swift
//  NewsClient
//
//  Created by Vika on 12.07.2024.
//

import UIKit

final class TabBarView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.spacing = 40
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var selectedBarButtonItem: UIButton? {
        didSet {
            oldValue?.configuration?.baseForegroundColor = .black
            selectedBarButtonItem?.configuration?.baseForegroundColor = .appAccentColor
        }
    }
    
    var onSelectItem: ((Int) -> Void)?
    
    func addTabBarItems(items: [TabBarItem]) {
        items.enumerated().forEach { i,item in
            let button = TabBarButton(image: item.image, title: item.title)
            button.tag = i + 1
            
            if i == 0 {
                selectedBarButtonItem = button
            }
            
            button.addTarget(
                self,
                action: #selector(didTapButton),
                for: .touchUpInside
            )
            
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        onSelectItem?(sender.tag)
        selectedBarButtonItem = sender
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarView {
    func setup() {
        backgroundColor = .systemBackground
        
        layer.cornerRadius = 30
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
}

extension TabBarView {
    struct TabBarItem {
        let title: String
        let image: UIImage
    }
}
