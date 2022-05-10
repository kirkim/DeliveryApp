//
//  TopNavigationBar.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MagnetNavigationBar: UIView {
    private let disposeBag = DisposeBag()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let shareButton = UIButton()
    private let likeButton = UIButton()
        
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetNavigationBarViewModel) {
        viewModel.transItem
            .emit { value, maxValue in
                let alpha = -value / maxValue
                self.backButton.tintColor = UIColor(white: 1 - alpha, alpha: 1)
                self.shareButton.tintColor = UIColor(white: 1 - alpha, alpha: 1)
                self.likeButton.tintColor = UIColor(red: 1 + alpha, green: 1 - alpha, blue: 1 - alpha, alpha: 1)
                if (-value >= maxValue) {
                    self.titleLabel.textColor = .black
                    self.backgroundColor = .white
                } else {
                    self.titleLabel.textColor = .black.withAlphaComponent(0)
                    self.backgroundColor = UIColor(white: 1, alpha: 0)
                    self.layer.zPosition = 1
                }
                
            }
            .disposed(by: disposeBag)
        
        self.titleLabel.text = viewModel.mainTitle
        
        backButton.rx.tap
            .bind(to: viewModel.backButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {        
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .white
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .white
        
        titleLabel.textColor = .white.withAlphaComponent(0)
        titleLabel.font = UIFont(name: "Helvetica", size: MagnetBarViewMath.naviTitleFontSize)
        titleLabel.textAlignment = .left
    }
    
    private func layout() {
        [backButton, titleLabel, shareButton, likeButton].forEach {
            self.addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(MagnetBarViewMath.naviTitleLeftMargin)
            $0.bottom.equalToSuperview().offset(-MagnetBarViewMath.naviTitleBottomMargin)
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        shareButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalTo(likeButton.snp.leading).inset(-20)
        }
    }
}
