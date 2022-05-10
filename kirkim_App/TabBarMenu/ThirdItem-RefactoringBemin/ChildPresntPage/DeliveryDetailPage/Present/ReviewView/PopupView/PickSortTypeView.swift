//
//  PickSortTypeVC.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PickSortTypeView: UIStackView {
    private let pickTitle = UILabel()
    private let latestOrderBtn = UIButton()
    private let highStarRatingBtn = UIButton()
    private let lowStarRatingBtn = UIButton()
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        bind(PickSortTypeViewModel())
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PickSortTypeViewModel) {
        self.latestOrderBtn.rx.tap
            .map { ReViewSortType.latestOrder }
            .bind(to: viewModel.selectedSortType)
            .disposed(by: disposeBag)
        
        self.highStarRatingBtn.rx.tap
            .map { ReViewSortType.highStarRating }
            .bind(to: viewModel.selectedSortType)
            .disposed(by: disposeBag)
        
        self.lowStarRatingBtn.rx.tap
            .map { ReViewSortType.lowStarRating }
            .bind(to: viewModel.selectedSortType)
            .disposed(by: disposeBag)
        
        viewModel.selectedSortType.share()
            .bind { type in
                [self.latestOrderBtn, self.highStarRatingBtn, self.lowStarRatingBtn].forEach {
                    $0.backgroundColor = .white
                    $0.setTitleColor(.black, for: .normal)
                }
                switch type {
                case .latestOrder:
                    self.latestOrderBtn.backgroundColor = .brown
                    self.latestOrderBtn.setTitleColor(.white, for: .normal)
                case .highStarRating:
                    self.highStarRatingBtn.backgroundColor = .brown
                    self.highStarRatingBtn.setTitleColor(.white, for: .normal)
                case .lowStarRating:
                    self.lowStarRatingBtn.backgroundColor = .brown
                    self.lowStarRatingBtn.setTitleColor(.white, for: .normal)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.backgroundColor = .systemGray5
        self.distribution = .fillEqually
        self.axis = .vertical
        self.spacing = 5
        self.addArrangedSubview(self.pickTitle)
        self.pickTitle.text = "리뷰정렬"
        self.pickTitle.backgroundColor = .systemGray5
        self.pickTitle.font = .systemFont(ofSize: 25, weight: .bold)
        self.pickTitle.textAlignment = .center
        [latestOrderBtn, highStarRatingBtn, lowStarRatingBtn].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
            self.addArrangedSubview($0)
        }
        
        latestOrderBtn.setTitle("최신순", for: .normal)
        highStarRatingBtn.setTitle("별점 높은순", for: .normal)
        lowStarRatingBtn.setTitle("별점 낮은순", for: .normal)
    }
}
