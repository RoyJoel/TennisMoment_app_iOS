//
//  ViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/21.
//

import SnapKit
import UIKit

class TabViewController: UITabBarController {
    let homeVC = HomeViewController()
    let eventVC = EventViewController()
    let accountVC = AccountViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = UIColor(named: "ComponentBackground")
        tabBar.tintColor = UIColor(named: "Tennis")
        tabBar.unselectedItemTintColor = UIColor(named: "ContentBackground")
        tabBar.setCorner(radii: 15)

        if #available(iOS 15.0, *) {
            let appearnce = UITabBarAppearance()
            appearnce.configureWithOpaqueBackground()
            appearnce.backgroundColor = UIColor(named: "ComponentBackground")
            tabBar.standardAppearance = appearnce
            tabBar.scrollEdgeAppearance = appearnce
        }

        addViewController()
    }

    override func viewDidLayoutSubviews() {
        var frame = tabBar.frame
        frame.size.width = view.frame.size.width - 88
        frame.origin.x = 44
        frame.origin.y = view.frame.size.height - frame.size.height - 18
        tabBar.frame = frame
    }

    private func addViewController() {
        setChildViewController(homeVC, NSLocalizedString("Home", comment: ""), "tennisball.fill")
        setChildViewController(eventVC, NSLocalizedString("Event", comment: ""), "trophy.fill")
        setChildViewController(accountVC, NSLocalizedString("Me", comment: ""), "figure.tennis")
    }

    private func setChildViewController(_ childViewController: UIViewController, _ itemName: String, _ itemImage: String) {
        childViewController.title = itemName
        childViewController.tabBarItem.title = itemName
        childViewController.tabBarItem.image = UIImage(systemName: itemImage)

        let nav = UINavigationController(rootViewController: childViewController)
        addChild(nav)
    }
}
