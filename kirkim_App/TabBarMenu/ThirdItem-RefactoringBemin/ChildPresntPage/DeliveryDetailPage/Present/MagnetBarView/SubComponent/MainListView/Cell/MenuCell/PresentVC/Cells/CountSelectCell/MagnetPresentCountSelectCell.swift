//
//  MagnetPresentCountSelectCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import SnapKit
import Reusable

class MagnetPresentCountSelectCell: UICollectionViewCell, Reusable {
    private let container = UIView()
    private let titleLabel = UILabel()
    private let countCheckerView = CountCheckerView()
    private let guideLabel = UILabel()
    private var flag:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetPresentCountSelectViewModel) {
        if (self.flag == false) {
            self.flag = true
            self.countCheckerView.bind(viewModel.countCheckerViewModel)
        }
    }
    
    private func attribute() {
        self.backgroundColor = .clear
        self.container.backgroundColor = .white
        
        self.titleLabel.text = "수량"
        self.titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        self.guideLabel.text = "❕메뉴 사진은 연출된 이미지로 실제 조리된 음식과 다를 수 있습니다."
        self.guideLabel.textAlignment = .center
        self.guideLabel.font = .systemFont(ofSize: 13, weight: .light)
        
        self.countCheckerView.layer.cornerRadius = 20
        self.countCheckerView.layer.borderColor = UIColor.black.cgColor
        self.countCheckerView.layer.borderWidth = 1
        self.countCheckerView.layer.masksToBounds = true
    }
    
    private func layout() {
        [container, guideLabel].forEach {
            self.addSubview($0)
        }
        
        container.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        [titleLabel, countCheckerView].forEach {
            self.container.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        countCheckerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(45)
            $0.width.equalTo(140)
        }
        
        
    }
}
