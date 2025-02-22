//
//  UIViewController+isDarkMode.swift
//  NewsClient
//
//  Created by Vika on 13.07.2024.
//

import UIKit

extension UIViewController {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }
}
