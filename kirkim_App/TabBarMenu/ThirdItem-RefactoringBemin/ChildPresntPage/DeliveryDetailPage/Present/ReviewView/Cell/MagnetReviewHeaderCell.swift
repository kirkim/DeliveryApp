//
//  MagnetReviewHeaderCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/25.
//

import SnapKit
import UIKit
import Reusable
import RxCocoa
import RxSwift

class MagnetReviewHeaderCell: UITableViewHeaderFooterView, Reusable {
    private let checkPhotoButton = UIButton()
    private let sortButton = UIButton()
    private let disposeBag = DisposeBag()
    private var flag:Bool = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetReviewHeaderCellViewModel) {
        if (self.flag == false) {
            self.flag = true
            
            self.checkPhotoButton.rx.tap
                .map { _ -> Bool in
                    if (self.checkPhotoButton.isSelected == false) {
                        self.checkPhotoButton.isSelected = true
                        return false
                    } else {
                        self.checkPhotoButton.isSelected = false
                        return true
                    }
                }
                .bind(to: viewModel.hasPhoto)
                .disposed(by: disposeBag)
            
            sortButton.rx.tap
                .bind(to: viewModel.sortButtonTapped)
                .disposed(by: disposeBag)
            
            viewModel.selectedSortType
                .bind { self.sortButton.setTitle($0.title, for: .normal) }
                .disposed(by: disposeBag)
        }
    }
    
    private func attribute() {
        self.contentView.backgroundColor = .white
//        self.sortButton.font = .systemFont(ofSize: 20, weight: .medium)
        self.sortButton.setTitle("최신순", for: .normal)
        self.sortButton.setTitleColor(.black, for: .normal)
        self.checkPhotoButton.setTitle("포토리뷰", for: .normal)
        self.checkPhotoButton.setTitleColor(.systemBlue, for: .normal)
        self.checkPhotoButton.setTitleColor(.black, for: .selected)
        self.checkPhotoButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        self.checkPhotoButton.setImage(UIImage(systemName: "square"), for: .selected)
    }
    
    private func layout() {
        [checkPhotoButton, sortButton].forEach {
            self.contentView.addSubview($0)
        }
        
        checkPhotoButton.snp.makeConstraints {
            $0.top.equalTo(self.contentView).offset(10)
            $0.leading.equalTo(self.contentView).offset(20)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(checkPhotoButton)
            $0.trailing.equalTo(self.contentView).inset(30)
        }
    }
}
