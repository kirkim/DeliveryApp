//
//  TestView3-1.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit

class TestView3_1: UIViewController, SideMenuCellView {
    static var sideMenuCellInfo = SideMenuCellInfo(thumnailImage: UIImage(systemName: "flame"), mainTitle: "TestView3-1", section: .three, identifier: "TestView3-1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
