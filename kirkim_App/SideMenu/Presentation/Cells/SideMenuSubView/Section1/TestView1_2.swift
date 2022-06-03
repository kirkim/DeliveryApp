//
//  TestView1-2.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit

class TestView1_2: UIViewController, SideMenuViewProtocol {
    static var sideMenuViewInfo = SideMenuViewInfo(thumnailImage: "bolt", mainTitle: "TestView1-2", section: .one, identifier: "TestView1_2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
