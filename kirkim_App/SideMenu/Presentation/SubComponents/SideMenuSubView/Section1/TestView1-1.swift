//
//  TestView1-1.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit

class TestView1_1: UIViewController, SideMenuViewProtocol {
    static var sideMenuViewInfo = SideMenuViewInfo(uiType: .xib, thumnailImage: "drop.fill", mainTitle: "TestView1-1", section: .one, identifier: "TestView1-1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = TestView1_1.sideMenuCellInfo.mainTitle
    }
}
