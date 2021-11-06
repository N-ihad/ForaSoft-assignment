//
//  TabBarController.swift
//  ForaSoft-assignment
//
//  Created by Nihad on 1/13/21.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }

    private func setup() {
        let searchViewController = SearchAlbumsViewController()
        let searchNavigationController = Helper.makeNavigationController(
            image: .searchTabBarIcon,
            title: "Search",
            rootViewController: searchViewController
        )

        let searchHistoryViewController = SearchHistoryViewController()
        searchHistoryViewController.delegate = searchViewController
        let searchHistoryNavigationController = Helper.makeNavigationController(
            image: .listTabBarIcon,
            title: "Search History",
            rootViewController: searchHistoryViewController
        )

        viewControllers = [searchNavigationController, searchHistoryNavigationController]
    }

    private func style() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = .black

        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
}
