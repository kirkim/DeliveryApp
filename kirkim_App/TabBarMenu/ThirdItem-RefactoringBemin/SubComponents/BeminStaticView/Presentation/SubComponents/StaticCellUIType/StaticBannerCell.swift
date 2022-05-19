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
    
//    let banner = RxBannerView()
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        layout()
        attribute()
        bind()
    }
    
    func bind() {
//        banner.bind(RxBannerViewModel(plistType: .staticEvent), parentViewController: UIViewController())
    }
    
    private func attribute() {
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func setBanner(banner: BeminBannerView) {
        contentView.addSubview(banner)
        banner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let width = 100.0
        let height = 30.0
        let x = self.contentView.frame.width - width - 10.0
        let y = self.contentView.frame.height - height - 10.0
        banner.setButtonFrame(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    private func layout() {
//        contentView.addSubview(banner)
//        banner.snp.makeConstraints {
//            $0.leading.top.trailing.bottom.equalToSuperview()
//        }
    }
    
    func setData(item: StaticItem) {
        return
    }
}
