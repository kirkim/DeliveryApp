//
//  ReviewByOtherHeaderView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/24.
//

import UIKit
import Reusable
import AVFoundation

class ReviewByOtherHeaderView: UITableViewHeaderFooterView, Reusable {
    private let containerView = UIView()
    private let avatarImageView = UIImageView()
    private let titleLabel = UILabel()
    private let nameLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    func setData(totalCount: Int, name: String) {
        self.nameLabel.text = name
        self.subTitleLabel.text = "작성한 리뷰 \(totalCount)개"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.contentView.backgroundColor = .white
        [self.titleLabel, self.nameLabel].forEach {
            $0.font = .systemFont(ofSize: 20, weight: .medium)
        }
        self.titleLabel.text = "고마운분,"
        self.titleLabel.textColor = .systemGray
        self.nameLabel.textColor = .black
        self.subTitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        //temp
        self.avatarImageView.image = UIImage(named: "sampleProfile")
    }
    
    private func layout() {
        [avatarImageView, containerView].forEach {
            self.contentView.addSubview($0)
        }
                
        [titleLabel, nameLabel, subTitleLabel].forEach {
            self.containerView.addSubview($0)
        }
        
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(60)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(1)
            $0.top.equalTo(titleLabel)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(5)
            $0.bottom.equalTo(subTitleLabel)
            $0.centerY.equalToSuperview()
        }
    }
}
