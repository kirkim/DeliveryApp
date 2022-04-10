//
//  ButtonVC4.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/09.
//

import UIKit
import SnapKit

class ButtonVC4: UIViewController {
    let titleLabel = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = .white
        self.titleLabel.text = "네번째 뷰"
        self.titleLabel.font = .systemFont(ofSize: 40)
        self.titleLabel.textAlignment = .center
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
