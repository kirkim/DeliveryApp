//
//  TestView2-1.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit

class TestView2_1: UIViewController, SideMenuCellView {
    static var sideMenuCellInfo = SideMenuCellInfo(thumnailImage: UIImage(systemName: "globe.asia.australia.fill"), mainTitle: "TestView2-1", section: .two, identifier: "TestView2-1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
