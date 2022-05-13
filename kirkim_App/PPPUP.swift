//
//  File.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/12.
//

import UIKit

class PPPUP: UIViewController {
    private let presentButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.view.backgroundColor = .yellow
        presentButton.setTitle("페이지 열기", for: .normal)
        presentButton.addAction(UIAction(handler: { _ in
//            let vc = ShoppingcartVC()
            MagnetBarHttpModel.shared.loadData(code: "1") {
                DispatchQueue.main.async {
                    let vc = MagnetBarView()
//                    self.present(vc, animated: true)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }), for: .touchUpInside)
        self.view.addSubview(presentButton)
        
        presentButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
