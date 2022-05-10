//
//  BannerControlButton.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/08.
//

import UIKit
import RxSwift
import RxCocoa

class BeminBannerButton: UIButton {
    private let disposeBag = DisposeBag()
    private let nowPage = BehaviorSubject<Int>(value: 0)
    
//MARK: - BannerControlButton init
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - BannerControlButton: layout, bind function
    private func layout() {
        self.backgroundColor = .gray.withAlphaComponent(0.7)
        self.layer.cornerRadius = 15
        self.titleLabel?.font = .systemFont(ofSize: 10)
    }
    
    func bind(_ viewModel: BeminBannerButtonViewModel) {        
        viewModel.nowPage
            .bind(to: self.nowPage)
            .disposed(by: disposeBag)
        
        viewModel.title
            .subscribe(onNext: {
                self.setTitle($0, for: .normal)
            })
            .disposed(by: disposeBag)
        self.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
    }
}
