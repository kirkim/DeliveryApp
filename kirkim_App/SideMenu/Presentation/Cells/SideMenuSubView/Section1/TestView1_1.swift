//
//  TestView1-1.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/22.
//

import UIKit
import SnapKit

class TestView1_1: UIViewController, SideMenuViewProtocol {
    static var sideMenuViewInfo = SideMenuViewInfo(thumnailImage: "drop.fill", mainTitle: "TestView1-1", section: .one, identifier: "TestView1_1")
    
    private let btn = UIButton()
    private var num: Int = 0
    private var numLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = TestView1_1.sideMenuCellInfo.mainTitle
        layout()
        self.view.backgroundColor = .yellow
    }
    
    private func layout() {
        btn.setTitle("sfsdfds", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addAction(UIAction(handler: { _ in
            self.num += 1
            self.numLabel.text = "\(self.num)"
        }), for: .touchUpInside)
        
        self.view.addSubview(btn)
        self.view.addSubview(numLabel)
        btn.snp.makeConstraints {
            $0.top.leading.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(60)
        }
        numLabel.snp.makeConstraints {
            $0.top.equalTo(btn.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
