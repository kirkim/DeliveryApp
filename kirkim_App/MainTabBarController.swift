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
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.init(red: 110/256, green: 77/256, blue: 65/256, alpha: 1)
//        tabBarAppearance.backgroundColor = UIColor.init(red: 157/256, green: 120/256, blue: 109/256, alpha: 1)
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        self.tabBar.tintColor = .white

    }
    
    private func setVC() {
        let vc1 = MainVC(nibName: "MainVC", bundle: nil)
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        let nav1 = UINavigationController(rootViewController: vc1)

        let vc2 = KiflixVC(nibName: "KiflixVC", bundle: nil)
        vc2.tabBarItem.image = UIImage(systemName:  "play.rectangle.fill")
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let vc3 = BeminVC()
        vc3.tabBarItem.image = UIImage(systemName:  "scooter")
        let nav3 = UINavigationController(rootViewController: vc3)

        self.viewControllers = [nav1, nav2, nav3] //add your other  controllers here as needed
    }
}
