//
//  BeminCollectionVC.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class StaticSectionCell: UICollectionViewCell {
    private let disposeBag = DisposeBag()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
//MARK: - BeminStaticCell init
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - BeminStaticCell: attribute, layout
    private func attribute() {
        self.registerCells(on: collectionView)
        collectionView.backgroundColor = .white
    }
    
    private func layout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - BeminStaticCell: bind
    func bind(_ viewModel: StaticSectionViewModel) {
        collectionView.collectionViewLayout = viewModel.createLayout()
        
        collectionView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        Observable.just(viewModel.sectionContents)
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource()))
            .disposed(by: disposeBag)
    }
    
    func registerCells(on collectionView: UICollectionView) {
        collectionView.register(StaticBigCell.self, forCellWithReuseIdentifier: StaticBigCell.cellId)
        collectionView.register(StaticMediumCell.self, forCellWithReuseIdentifier: StaticMediumCell.cellId)
        collectionView.register(StaticMedium_2Cell.self, forCellWithReuseIdentifier: StaticMedium_2Cell.cellId)
        collectionView.register(StaticSmall_3Cell.self, forCellWithReuseIdentifier: StaticSmall_3Cell.cellId)
        collectionView.register(StaticSmall_4Cell.self, forCellWithReuseIdentifier: StaticSmall_4Cell.cellId)
        collectionView.register(StaticBannerCell.self, forCellWithReuseIdentifier: StaticBannerCell.cellId)
    }
}
