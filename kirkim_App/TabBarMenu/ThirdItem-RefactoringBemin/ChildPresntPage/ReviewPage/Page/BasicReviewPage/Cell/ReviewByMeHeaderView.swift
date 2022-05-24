//
//  ReviewHeaderView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/23.
//

import UIKit
import Reusable
import SnapKit

class ReviewByMeHeaderView: UITableViewHeaderFooterView, Reusable {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let guideLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func setData(totalCount: Int) {
        self.titleLabel.text = "내가 쓴 총 리뷰 \(totalCount)개"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.contentView.backgroundColor = .white
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.guideLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        self.guideLabel.text = "리뷰 수정 안내 ⍰"
        self.guideLabel.textColor = .systemGray
    }
    
    private func layout() {
        self.contentView.addSubview(self.containerView)
                
        [titleLabel, guideLabel].forEach {
            self.containerView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        guideLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.bottom.equalTo(guideLabel)
            $0.centerY.equalToSuperview()
        }
    }
}
