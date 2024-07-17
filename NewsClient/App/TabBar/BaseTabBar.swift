//
//  BaseTabBar.swift
//  NewsClient
//
//  Created by Vika on 17.07.2024.
//

import UIKit

final class BaseTabBar: UITabBar {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }
}
