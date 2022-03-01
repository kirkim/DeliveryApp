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
        self.tabBar.tintColor = .green
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .black
        setVC()
    }
    
    private func setVC() {
        let vc1 = MainVC(nibName: "MainVC", bundle: nil)
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        let nav1 = UINavigationController(rootViewController: vc1)

        let vc2 = KiflixVC(nibName: "KiflixVC", bundle: nil)
        vc2.tabBarItem.image = UIImage(systemName:  "play.rectangle.fill")
        let nav2 = UINavigationController(rootViewController: vc2)
        
        self.viewControllers = [nav1, nav2] //add your other  controllers here as needed
    }
}
