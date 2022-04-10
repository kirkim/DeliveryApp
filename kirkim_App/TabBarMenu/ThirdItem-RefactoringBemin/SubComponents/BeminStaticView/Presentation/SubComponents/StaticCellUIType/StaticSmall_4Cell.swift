//
//  Section7ViewModel.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import Foundation
import UIKit

class StaticSmall_4Cell: UICollectionViewCell, StaticCellProtocol {
    static var cellId: String = "StaticSmall_4Cell"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        layout()
        attribute()
    }
    
    private func attribute() {
        contentView.backgroundColor = .purple
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .black)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleToFill
    }
    
    private func layout() {
        [titleLabel, imageView].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalTo(imageView.snp.height)
        }
    }
    
    func setData(item: StaticItem) {
        self.titleLabel.text = item.title
        self.imageView.image = item.image
    }
}
