//
//  SampleViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/13.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class MagnetPresentMenuViewModel {
    private let disposeBag = DisposeBag()
    private let sectionManager = MagnetPresentMenuSectionManager()
    private let countSelectViewModel = MagnetPresentCountSelectViewModel()
    private let presentMenuStateManager: PresentMenuStateManager
    let submitTapViewModel = MagnetSubmitTapViewModel()
    
    //View -> ViewModel
    let itemSelect = PublishRelay<IndexPath>()
    let validateSubmitButton = BehaviorRelay<Int>(value: 0)
    
    //ViewModel -> View
    let warningAlert = PublishRelay<String>()
    let data: Driver<[PresentMenuSectionModel]>
    let title: String
    
    init(model: MagnetPresentMenuModel) {
        self.title = model.title
        self.presentMenuStateManager = PresentMenuStateManager(model: model)
        self.data = presentMenuStateManager.getCollectionViewDataObserver().asDriver()
        
        presentMenuStateManager.getTotalPriceObserver()
            .bind(to: submitTapViewModel.currentPrice)
            .disposed(by: disposeBag)
                
        self.itemSelect
            .bind { self.presentMenuStateManager.itemSelect($0)}
            .disposed(by: disposeBag)
        
        // 제출버튼 유효성 검사
        itemSelect.map { _ in 1 }
            .bind(to: validateSubmitButton)
            .disposed(by: disposeBag)
        
        countSelectViewModel.totalCount
            .bind { self.presentMenuStateManager.changeCount(value: $0) }
            .disposed(by: disposeBag)
        
        presentMenuStateManager.getErrorMessageObserver()
            .bind(to: self.warningAlert)
            .disposed(by: disposeBag)
        
        presentMenuStateManager.getIsValidObserver()
            .bind(to: self.submitTapViewModel.canSubmit)
            .disposed(by: disposeBag)
        
        self.submitTapViewModel.submitButtonTapped
            .map { self.presentMenuStateManager.parsingCartData() }
            .bind { data in
                do {
                    try CartManager.shared.addItem(data: data)
                } catch {
                    self.warningAlert.accept(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
        
    func createLayout() -> UICollectionViewCompositionalLayout {
        return sectionManager.createLayout(sectionCount: self.presentMenuStateManager.sectionTotalCount)
    }
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<PresentMenuSectionModel> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<PresentMenuSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch dataSource[indexPath.section] {
                case .SectionMainTitle(items: let items):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MagnetPresentMainTitleCell.self)
                    let item = items[indexPath.row]
                    cell.setData(image: item.image, title: item.mainTitle, description: item.description)
                    return cell
                case .SectionMenu(header: _, selectType: _, items: let items):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MagnetPresentMenuCell.self)
                    cell.setData(data: items[indexPath.row])
                    return cell
                case .SectionSelectCount(items: _):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MagnetPresentCountSelectCell.self)
                    cell.bind(self.countSelectViewModel)
                    return cell
                }
            })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            switch dataSource[indexPath.section] {
            case .SectionMenu(header: let headerString, selectType: let type, items: let items):
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: MagnetPresentMenuHeaderView.self)
                header.setData(header: headerString, type: type, itemCount: items.count)
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: MagnetPresentMenuHeaderView.self)
                return header
            }
        }
        return dataSource
    }
}
