//
//  TestView1-2.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit

class TestView1_2: UIViewController, SideMenuViewProtocol {
    static var sideMenuViewInfo = SideMenuViewInfo(uiType: .xib, thumnailImage: "bolt", mainTitle: "TestView1-2", section: .one, identifier: "TestView1-2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
