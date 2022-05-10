//
//  MagnetPresentMenuHeaderView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import SnapKit
import Reusable

class MagnetPresentMenuHeaderView: UICollectionReusableView, Reusable {
    private let titleLabel = UILabel()
    private let checkCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(header: String, type: SelectType, itemCount: Int) {
        self.titleLabel.text = header
        switch type {
        case .mustOne:
            break;
        case .custom(min: let min, max: let max):
            let maxValue = max < itemCount ? max : 0
            let minValue = min < 0 ? 0 : min
            if (maxValue == 0) {
                if (minValue == 0) {
                    self.checkCountLabel.text = "[여러개 선택 가능]"
                } else {
                    self.checkCountLabel.text = "[최소 \(minValue)개이상 선택]"
                }
            } else if (minValue == 0) {
                self.checkCountLabel.text = "[최대 \(maxValue)개까지 선택]"
            } else {
                self.checkCountLabel.text = "[최소 \(minValue)개 이상, \(maxValue)개까지 선택]"
            }
        }
    }
    
    private func attribute() {
        self.backgroundColor = .white
        //Temp
        self.titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        self.checkCountLabel.font = .systemFont(ofSize: 18, weight: .light)
    }
    
    private func layout() {
        [titleLabel, checkCountLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        checkCountLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
