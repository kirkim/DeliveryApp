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
//        makeTempBanner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        test()
    }
    
    func makeTempBanner() {
        let basicLabel = UILabel()
        basicLabel.text = "flowlayoutdelegate 사용"
        let compositionalLabel = UILabel()
        compositionalLabel.text = "CompositionalLayout 사용"
        
        [basicLabel, compositionalLabel].forEach {
            $0.font = .systemFont(ofSize: 25, weight: .bold)
            $0.textAlignment = .center
            view.addSubview($0)
        }
        
        let basicBanner = MyBannerBasicView(modelType: .staticEvent)
        let compositionalBanner = MyBannerUsingRxswift(modelType: .staticEvent)
        [basicBanner, compositionalBanner].forEach {
            view.addSubview($0)
        }
        
        basicLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        basicBanner.snp.makeConstraints {
            $0.top.equalTo(basicLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        
        compositionalLabel.snp.makeConstraints {
            $0.top.equalTo(basicBanner.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        compositionalBanner.snp.makeConstraints {
            $0.top.equalTo(compositionalLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    func test() {
        let vc = RxSignUpPageVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    

}
