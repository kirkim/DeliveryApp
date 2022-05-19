//
//  MagnetInfoCollectionView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/15.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class MagnetSummaryReviewView: UICollectionView {
    private let disposeBag = DisposeBag()
    private let viewModel = MagnetSummaryReviewViewModel()
    private let model = MagnetSummaryReviewModel()
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
        layout()
        model.setData(coView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func bind(_ viewModel: MagnetSummaryReviewViewModel) {
        self.rx.itemSelected
            .map { [weak self] indexPath -> Int? in
                if (indexPath.row == self?.model.dataCount) {
                    return nil
                }
                return indexPath.row
            }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.delegate = self
        self.register(cellType: MagnetInfoReviewCell.self)
        self.register(cellType: MagnetInfoMoreButtonCell.self)
        self.showsHorizontalScrollIndicator = false
    }
    
    private func layout() {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 20)
        }
    }
}

extension MagnetSummaryReviewView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = indexPath.row == (model.dataCount ?? 0) ? self.frame.height - 20 : self.frame.width*3/4
        let height:CGFloat = self.frame.height - 20
        return CGSize(width: width, height: height)
    }
}
