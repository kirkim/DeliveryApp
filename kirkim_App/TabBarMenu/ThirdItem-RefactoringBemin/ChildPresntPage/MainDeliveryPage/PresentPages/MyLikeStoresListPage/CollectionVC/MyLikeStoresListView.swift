//
//  MyLikeStoresCollectionView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/28.
//

import UIKit
import RxSwift
import RxCocoa

class MyLikeStoresListView: UICollectionView {
    private let disposeBag = DisposeBag()
    private var viewModel: MyLikeStoresListViewModel?
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MyLikeStoresListViewModel) {
        self.viewModel = viewModel
        let dataSource = viewModel.getDataSource()
        let cellData = viewModel.getCellData()
        cellData
            .drive(self.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        self.rx.itemSelected.withLatestFrom(cellData) { indexPath, cellData in
            return cellData[indexPath.section].items[indexPath.row].storeCode
        }
        .bind(to: viewModel.presentStoreDetailVC)
        .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.register(cellType: StoreListCell.self)
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        DispatchQueue.global().async {
            self.viewModel?.update {
                sleep(1) // 임시로 지연시간 1초 주기
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    func update() {
        self.viewModel?.update()
    }
}

//MARK: - MyLikeStoresListView: UICollectionViewDelegateFlowLayout
extension MyLikeStoresListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = self.frame.height/8
        return CGSize(width: width , height: height)
    }
}
