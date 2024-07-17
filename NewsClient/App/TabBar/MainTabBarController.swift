//
//  MainTabBarController.swift
//  NewsClient
//
//  Created by Vika on 17.06.2024.
//

import UIKit

struct TabBarModel {
    var image: UIImage
    var title: String
    var viewController: UIViewController
}

final class MainTabBarController: UITabBarController {
    private let models: [TabBarModel]
    
    private let tabBarView: TabBarView = {
        let tabBarView = TabBarView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        return tabBarView
    }()
    
    override var hidesBottomBarWhenPushed: Bool {
        get {
            tabBarView.isHidden
        }
        
        set {
            tabBar.isUserInteractionEnabled = false 
            tabBarView.isHidden = newValue
        }
    }

    init(models: [TabBarModel]) {
        self.models = models
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let customTabBar = BaseTabBar()
        customTabBar.alpha = 0

        customTabBar.isUserInteractionEnabled = false
        
        self.setValue(customTabBar, forKey: "tabBar")
        
        viewControllers = models.map { $0.viewController }

        setupTabBarView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if hidesBottomBarWhenPushed {
            tabBarView.isHidden = true
        }
    }
}

private extension MainTabBarController {
    func setupTabBarView() {
        let items = models.map {
            TabBarView.TabBarItem(
                title: $0.title,
                image: $0.image
            )
        }
        
        tabBarView.addTabBarItems(items: items)
        
        tabBarView.onSelectItem = { [weak self] selectedIndex in
            self?.selectedIndex = selectedIndex - 1
        }
        
        setupTabBarViewConstraints()
    }
    
    func setupTabBarViewConstraints() {
        let parentView = view!
        parentView.insertSubview(tabBarView, aboveSubview: tabBar)
                
        parentView.bringSubviewToFront(tabBarView)
        
        NSLayoutConstraint.activate([
            tabBarView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),

            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}

