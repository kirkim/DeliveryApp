//
//  BottomBar.swift
//  TopBarVC
//
//  Created by 김기림 on 2022/04/08.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BottomBar: UIView {
    private let disposeBag = DisposeBag()
    
    private let bundleBaseButton = BundleBaseButton()
    private let centerButton = UIButton()
    let CENTERBUTTONRATIO: CGFloat = 0.15 // 가운데 버튼의 크기는 윈도우너비 기준으로 만들어지도록 만듬(오토레이아웃)
    let windowWidth = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).windowWidth
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: BottomBarViewModel) {
        bundleBaseButton.bind(viewModel.bundleBaseButtonViewModel)
        centerButton.rx.tap
            .bind(to: viewModel.centerButtonTapped)
            .disposed(by: disposeBag)
    }
    
    //MARK: attribute(), layout() function
    private func attribute() {
        self.backgroundColor = .black.withAlphaComponent(0.2) // 뷰를 그림자로써 사용
        self.centerButton.backgroundColor = .systemBlue
        self.centerButton.layer.cornerRadius = windowWidth! * CENTERBUTTONRATIO / 2
        
        // 뷰(그림자), 기본버튼번들뷰의 코너를 설정
        bundleBaseButton.layer.cornerRadius = 20
        self.layer.cornerRadius = 10
        [bundleBaseButton, self].forEach {
            $0.clipsToBounds = true
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        }
    }
    
    private func layout() {
        [bundleBaseButton, centerButton].forEach {
            self.addSubview($0)
        }
        
        let shadowWidth = 10
        
        bundleBaseButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(shadowWidth)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        centerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(CENTERBUTTONRATIO)
            $0.height.equalTo(centerButton.snp.width)
            $0.top.equalToSuperview()
        }

    }
}
