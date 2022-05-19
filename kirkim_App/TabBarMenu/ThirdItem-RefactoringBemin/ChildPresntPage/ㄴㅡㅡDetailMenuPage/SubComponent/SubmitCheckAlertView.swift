//
//  SubmitCheckAlertView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/18.
//

import UIKit
import SnapKit
import RxGesture
import RxSwift

class SubmitCheckAlertView: UIView {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    private let separateView = UIView()
    
    private let buttonStackView = UIStackView()
    private let cancelLabel = UILabel()
    private let okLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SubmitCheckAlertViewModel) {
        self.cancelLabel.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.cancelButtonTapped)
            .disposed(by: disposeBag)
        
        self.okLabel.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.okButtonTapped)
            .disposed(by: disposeBag)
    }
    
    func setData(data: CheckAlertData) {
        self.titleLabel.text = data.title
        self.subTitleLabel.text = data.subTitle
    }
    
    private func attribute() {
        self.containerView.layer.cornerRadius = 5
        self.containerView.layer.masksToBounds = true
        
        self.backgroundColor = .clear.withAlphaComponent(0.3)
        self.containerView.backgroundColor = .white
        
        self.titleLabel.numberOfLines = 2
        self.titleLabel.alpha = 0.7
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        self.titleLabel.lineBreakMode = .byCharWrapping
        
        self.subTitleLabel.numberOfLines = 2
        self.subTitleLabel.alpha = 0.4
        self.subTitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        self.subTitleLabel.lineBreakMode = .byCharWrapping
        
        self.separateView.backgroundColor = .systemGray5
        
        self.buttonStackView.axis = .horizontal
        self.buttonStackView.distribution = .fillEqually
        self.buttonStackView.backgroundColor = .systemGray5
        self.buttonStackView.spacing = 1
        
        self.cancelLabel.backgroundColor = .white
        self.okLabel.backgroundColor = .white
        
        [titleLabel, subTitleLabel, cancelLabel, okLabel].forEach {
            $0.textAlignment = .center
        }
        
        cancelLabel.text = "취소"
        okLabel.text = "담기"
        
        // temp
//        titleLabel.text = "장바구니에는 같은 가게의 매뉴만 담을 수 있습니다."
//        subTitleLabel.text = "선택하신 메뉴를 장바구니에 담을 경우 이전에 담은 메뉴가 삭제됩니다."
    }
    
    private func layout() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        [titleLabel, subTitleLabel, separateView, buttonStackView].forEach {
            self.containerView.addSubview($0)
        }
        
        let sidePadding = 22
        let width = MagnetBarViewMath.windowWidth*2 / 3
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(sidePadding)
            $0.trailing.equalToSuperview().inset(sidePadding)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(sidePadding)
            $0.trailing.equalToSuperview().inset(sidePadding)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        separateView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top)
            $0.height.equalTo(1)
        }
        
        [cancelLabel, okLabel].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.bottom.equalTo(buttonStackView.snp.bottom)
        }
    }
}
