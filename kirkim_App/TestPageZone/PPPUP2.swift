//
//  PPPUP2.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/24.
//

import UIKit

class PPPUP2: UIViewController {
    private let presentButton = UIButton()
    private let presentButton2 = UIButton()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.view.backgroundColor = .yellow
        presentButton.setTitle("내가 쓴리뷰", for: .normal)
        presentButton.addAction(UIAction(handler: { _ in
//            let vc = BasicReviewVC(type: BasicReviewType.me(userInfo: UserInfo(userID: "", name: "", id: "1")))
            let vc = SideMenuVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
//            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        presentButton2.setTitle("남이 쓴리뷰", for: .normal)
        presentButton2.addAction(UIAction(handler: { _ in
            let vc = BasicReviewVC(type: BasicReviewType.other(userInfo: UserInfo(userID: "", name: "림림", id: "2")))
            self.navigationController?.pushViewController(vc, animated: true)
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
    }
}
