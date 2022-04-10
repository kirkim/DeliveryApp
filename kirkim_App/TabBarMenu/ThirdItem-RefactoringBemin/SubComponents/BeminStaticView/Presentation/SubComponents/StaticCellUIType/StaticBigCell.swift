//
//  StaticSection1.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import Foundation
import UIKit
import RxCocoa

class StaticBigCell: UICollectionViewCell, StaticCellProtocol {
    static var cellId: String = "StaticBigCell"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func layoutSubviews() {
        layout()
        attribute()
    }
    
    private func attribute() {
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        titleLabel.textColor = .white
        
        imageView.contentMode = .scaleToFill
        
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .medium)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 2
    }
    
    private func layout() {
        [titleLabel, imageView, descriptionLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().offset(-5)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(imageView.snp.width)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-50)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
    
    func setData(item: StaticItem) {
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
        self.imageView.image = item.image
    }
}
