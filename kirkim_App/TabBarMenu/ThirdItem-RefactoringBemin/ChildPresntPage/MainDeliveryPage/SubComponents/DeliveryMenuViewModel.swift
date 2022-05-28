//
//  DeliveryMenuViewModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/06.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa
import UIKit

class DeliveryMenuViewModel {
    private let deliveryListViewModel = SelectStoreViewModel()
    private let model = DeliveryMenuModel()
    private let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let data: Driver<[DeliveryMenuSectionModel]>
    
    // View -> ViewModel
    let itemSelected = PublishRelay<IndexPath>()
    
    // ViewModel -> View
    let presentVC = PublishRelay<SelectStoreVC>()
    
    init() {
        self.data = model.dataObservable.asDriver()
        
        itemSelected.filter { $0.section == 2 }
        .map { [weak self] indexPath in
            let vc = SelectStoreVC(startPage: indexPath.row)
            vc.bind((self?.deliveryListViewModel)!)
            return vc
        }
        .bind(to: presentVC)
        .disposed(by: disposeBag)
    }
    
    func setBannerTouchEvent(at viewController: UIViewController) {
        self.model.setBannerTouchEvent(at: viewController)
    }
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<DeliveryMenuSectionModel> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<DeliveryMenuSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch dataSource[indexPath.section] {
                case .SectionBanner(items: let items):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DeliveryMenuBannerCell.self)
                    cell.setBanner(banner: items[indexPath.row].banner)
                    return cell
                case .SectionSpecialMenu(items: let items):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DeliveryMenuSpecialCell.self)
                    cell.setData(data: items[indexPath.row])
                    return cell
                case .SectionBasicMenu(items: let items):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DeliveryMenuBasicCell.self)
                    cell.setData(data: items[indexPath.row])
                    return cell
                }
            })
        
        // Header
//        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
//            switch dataSource[indexPath.section] {
//
//            }
//        }
        return dataSource
    }
}
