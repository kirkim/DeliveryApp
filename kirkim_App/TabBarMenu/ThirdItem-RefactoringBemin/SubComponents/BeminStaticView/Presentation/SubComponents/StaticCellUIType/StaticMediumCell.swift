//
//  Section2ViewModel.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import Foundation
import UIKit

class StaticMediumCell: UICollectionViewCell, StaticCellProtocol {
    static var cellId: String = "StaticMediumCell"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func layoutSubviews() {
        layout()
        attribute()
    }
    
    private func attribute() {
        contentView.backgroundColor = .green
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        titleLabel.textColor = .white
        
        imageView.contentMode = .scaleToFill
        
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .medium)
        descriptionLabel.textColor = .purple
        descriptionLabel.numberOfLines = 2
    }
    
    private func layout() {
        [titleLabel, imageView, descriptionLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.top.equalToSuperview().offset(5)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(imageView.snp.height)
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
