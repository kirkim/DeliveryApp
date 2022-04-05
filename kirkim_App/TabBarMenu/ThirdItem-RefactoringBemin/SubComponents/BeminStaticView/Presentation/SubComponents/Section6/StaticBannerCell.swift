//
//  Section6ViewModel.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/04.
//

import UIKit
import SnapKit

class StaticBannerCell: UICollectionViewCell, StaticCellProtocol {
    static var cellId: String = "StaticBannerCell"
    
    let banner = RxBannerView()
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        layout()
        attribute()
        bind()
    }
    
    func bind() {
        banner.bind(RxBannerViewModel(plistType: .staticEvent), parentViewController: UIViewController())
    }
    
    private func attribute() {
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
    
    private func layout() {
        contentView.addSubview(banner)
        banner.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(item: StaticItem) {
        return
    }
}
