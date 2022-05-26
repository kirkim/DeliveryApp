//
//  File.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/12.
//

import UIKit
import SnapKit

class PPPUP: UIViewController {
    private let presentButton = UIButton()
    private let presentButton2 = UIButton()
    private let cartButton = ShoppingCartButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.view.backgroundColor = .yellow
        presentButton.setTitle("스토어1 열기", for: .normal)
        presentButton.addAction(UIAction(handler: { _ in
            MagnetBarVC.presentView(target: self, type: .basic(storeCode: "3"))
        }), for: .touchUpInside)
        presentButton2.setTitle("스토어2 열기", for: .normal)
        presentButton2.addAction(UIAction(handler: { _ in
            MagnetBarVC.presentView(target: self, type: .basic(storeCode: "2"))
        }), for: .touchUpInside)
        
        self.presentButton.setTitleColor(.blue, for: .normal)
        self.presentButton2.setTitleColor(.purple, for: .normal)
        
        [presentButton, presentButton2].forEach {
            self.view.addSubview($0)
        }
        
        presentButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        presentButton2.snp.makeConstraints {
            $0.top.equalTo(presentButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        cartButton.addEventAndFrame(vc: self)
        
    }
}
