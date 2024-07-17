//
//  UIView+addOverlay.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

extension UIView {
    func addOverlay(color: UIColor = .black,alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
}
