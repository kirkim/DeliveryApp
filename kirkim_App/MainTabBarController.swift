//
//  MainTabBarController.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setVC()
    }
    
    private func setVC() {
        let yourViewController = UIViewController()
//        let yourViewController = KiflixVC(nibName: "KiflixVC", bundle: nil)
        yourViewController.tabBarItem.image = UIImage(systemName: "play.fill")
        let navigationController = UINavigationController(rootViewController: yourViewController)

        self.tabBar.tintColor = .green
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .black
        self.viewControllers = [navigationController] //add your other  controllers here as needed
    }
}
