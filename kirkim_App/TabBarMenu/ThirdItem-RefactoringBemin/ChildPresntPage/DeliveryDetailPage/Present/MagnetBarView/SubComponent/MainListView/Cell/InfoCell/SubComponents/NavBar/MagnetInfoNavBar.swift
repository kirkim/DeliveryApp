//
//  InfoCellNavBar.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit
import RxSwift
import RxGesture
import RxCocoa

class MagnetInfoNavBar: UIView {
    private let disposeBag = DisposeBag()
    
    private let deliveryButton = MagnetInfoButton(title: "배달 24-34분")
    private let takeoutButton = MagnetInfoButton(title: "포장 12-22분")
    private let bottomSlide = UIView()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetInfoNavBarViewModel) {
        deliveryButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in MagnetInfoType.delivery }
            .bind(to: viewModel.tappedButton)
            .disposed(by: disposeBag)
        
        takeoutButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in MagnetInfoType.takeout }
            .bind(to: viewModel.tappedButton)
            .disposed(by: disposeBag)
        
        viewModel.buttonChanged
            .asDriver{ _ in .never() }
            .drive { [weak self] type in
                self?.toggleButton(type: type)
            }
            .disposed(by: disposeBag)
    }
    
    private func toggleButton(type: MagnetInfoType) {
        var slideOffset:CGFloat = 0
        switch type {
        case .delivery:
            self.deliveryButton.selected()
            self.takeoutButton.deSelected()
            slideOffset = 0
        case .takeout:
            self.deliveryButton.deSelected()
            self.takeoutButton.selected()
            slideOffset = self.frame.width/2
        }
        UIView.animate(withDuration: 0.2) {
            self.bottomSlide.frame.origin.x = slideOffset
        }
    }
    
    private func attribute() {
        self.deliveryButton.selected()
        self.bottomSlide.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: 3)
        self.bottomSlide.backgroundColor = .systemBlue
    }
    
    private func layout() {
        [deliveryButton, takeoutButton, bottomSlide].forEach {
            self.addSubview($0)
        }
        
        deliveryButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        takeoutButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        bottomSlide.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(3)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(70)
        }
    }
}
