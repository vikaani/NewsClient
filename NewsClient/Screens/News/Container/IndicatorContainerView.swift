//
//  IndicatorContainerView.swift
//  NewsClient
//
//  Created by Vika on 16.07.2024.
//

import UIKit

final class IndicatorContainerView: UIView {
    let indicatorView: UIActivityIndicatorView = {
       let indicatorView = UIActivityIndicatorView()
       indicatorView.style = .large
       indicatorView.hidesWhenStopped = true
       indicatorView.startAnimating()
       indicatorView.translatesAutoresizingMaskIntoConstraints = false
       return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopAnimating() {
        indicatorView.stopAnimating()
        isHidden = true
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
