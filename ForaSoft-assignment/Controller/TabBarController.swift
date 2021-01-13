//
//  TabBarController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTabBar()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configureNavBar() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = .black
    }
    
    func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    func configureViewControllers() {
        
        let searchNav = templateNavigationController(image: UIImage(systemName: "magnifyingglass"),
                                                     navTitle: "Search",
                                                     rootViewController: SearchViewController())
        
        let historyNav = templateNavigationController(image: UIImage(systemName: "list.star"),
                                                      navTitle: "History",
                                                      rootViewController: HistoryViewController())
        
        viewControllers = [searchNav, historyNav]
    }
    
    func templateNavigationController(image: UIImage?, navTitle: String, rootViewController: UIViewController) -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: rootViewController)
        navCtrl.tabBarItem.image = image
        navCtrl.navigationBar.barTintColor = .white
        navCtrl.title = navTitle
        
        return navCtrl
    }
}
