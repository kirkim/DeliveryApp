//
//  StoreListView.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa

class StoreListView: UICollectionView {
    private let disposeBag = DisposeBag()
    private let sectionManager = StoreListSectionManager()
    private let model = StoreListModel()
    private var type: StoreType?
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: [StoreListSection], type: StoreType) {
        self.model.updateData(data: data)
        self.type = type
    }
    
    func bind(_ viewModel: StoreListViewModel) {
        let dataSource = model.dataSource()
        model.cellData
            .bind(to: self.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        self.rx.itemSelected.withLatestFrom(model.cellData) { indexPath, cellData in
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
            SummaryStoreHttpManager.shared.load(storeType: self.type!) { loadData in
                self.model.updateData(data: loadData)
                sleep(1) // 임시로 지연시간 1초 주기
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }
}

//MARK: - StoreListView: UICollectionViewDelegateFlowLayout
extension StoreListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        let height = self.frame.height/8
        return CGSize(width: width , height: height)
    }
}
