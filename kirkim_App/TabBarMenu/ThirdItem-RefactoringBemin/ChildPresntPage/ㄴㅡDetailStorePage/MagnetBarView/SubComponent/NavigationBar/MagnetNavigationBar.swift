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
    
    private var isLiked:Bool = false
    private var isSight:Bool = false
    let userModel = UserModel()
    let storeCode = DetailStoreHttpManager.shared.getStoreCode()
    private let httpManager = MyLikeStoreHttpManager.shared
    
        
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
                    self.isSight = true
                } else {
                    self.titleLabel.textColor = .black.withAlphaComponent(0)
                    self.backgroundColor = UIColor(white: 1, alpha: 0)
                    self.layer.zPosition = 1
                    self.isSight = false
                }
                if (self.isLiked == true) {
                    self.likeButton.tintColor = .systemRed
                }
            }
            .disposed(by: disposeBag)
        
        self.titleLabel.text = viewModel.mainTitle
        
        backButton.rx.tap
            .bind(to: viewModel.backButtonTapped)
            .disposed(by: disposeBag)
        
        self.likeButton.rx.tap
            .bind {
                self.httpManager.toggleLikeStore(id: (self.userModel.info?.id)!, storeCode: self.storeCode) { isLiked in
                    DispatchQueue.main.async {
                        self.toggleLikeButton(liked: isLiked)
                        self.userModel.updateLikeStore()
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func toggleLikeButton(liked: Bool) {
        self.isLiked = liked
        if (isLiked == true) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .systemRed
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = self.isSight ? .systemRed : .white
        }
    }
    
    private func attribute() {        
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .white
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        
        self.isLiked = userModel.checkStoreIsLiked(storeCode: storeCode)
        self.toggleLikeButton(liked: self.isLiked)
        
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
