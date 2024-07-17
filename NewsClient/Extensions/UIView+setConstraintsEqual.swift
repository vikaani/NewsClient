//
//  UIView+setConstraintsEqual.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

extension UIView {
    func setConstraintsEqual(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
