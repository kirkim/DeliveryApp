//
//  TestVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/07.
//

import UIKit
import SnapKit

class TestVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let banner = MyBannerByPlistView(modelType: .staticEvent)
        self.view.addSubview(banner)
        banner.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(400)
        }
//        let vc = BeminCollectionVC()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: false, completion: nil)

    }
}
