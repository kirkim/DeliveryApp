//
//  MagnetListView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable

class MagnetListView: UICollectionView {
    private let disposeBag = DisposeBag()
    private let sectionManager = MagnetListSectionManager()
    private let dragEvent = PublishRelay<CGFloat>()
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MagnetListViewModel) {
        let dataSource = viewModel.dataSource()
        let sectionOriginY = sectionManager.calculateSectionOriginY(data: viewModel.data)
        let maxValue = MagnetBarViewMath.windowWidth*sectionManager.bannerCellHeightRatio - MagnetBarViewMath.navigationHeight
        Observable.just(viewModel.data)
            .bind(to: self.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
         
        let scrollEvent = self.rx.didScroll
            .map { _ -> CGFloat in
                return self.contentOffset.y
            }
            .share()
        
        scrollEvent
            .map { originY -> (CGFloat, CGFloat) in
                let value = originY <= maxValue ? -originY : -maxValue
                return (value, maxValue)
            }
            .bind(to: viewModel.scrollEvent)
            .disposed(by: disposeBag)
        
        scrollEvent
            .map { originY -> Bool in
                if (originY > self.sectionManager.stickyHeaderPositionY) {
                    return true
                } else {
                    return false
                }
            }
            .distinctUntilChanged()
            .bind(to: viewModel.stickyHeaderOn)
            .disposed(by: disposeBag)
        
        scrollEvent
            .map { originY -> Int in
                if (originY < self.sectionManager.stickyHeaderPositionY) {
                    return 1
                }
                for (index, data) in sectionOriginY.enumerated() {
                    if (originY < data - 1) {
                        return index
                    }
                }
                return 1
            }
            .bind(to: viewModel.changeSection)
            .disposed(by: disposeBag)
        
        viewModel.slotChanged
            .bind { [weak self] indexPath in
                self?.setContentOffset(CGPoint(x: 0, y: sectionOriginY[indexPath.row]), animated: true)
            }
            .disposed(by: disposeBag)
        
        self.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = .systemGray5
        self.register(cellType: MagnetBannerCell.self)
        self.register(cellType: MagnetInfoCell.self)
        self.register(cellType: MagnetStickyCell.self)
        self.register(cellType: MagnetMenuCell.self)
        self.register(supplementaryViewType: MagnetMenuHeaderCell.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    private func layout() {
        self.collectionViewLayout = sectionManager.createLayout()
    }
}
