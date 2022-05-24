//
//  MagnetReviewViewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/25.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class MagnetReviewViewModel {
    let model = MagnetReviewModel()
    let headerViewModel = MagnetReviewHeaderCellViewModel()
    private let cellViewModel = MagnetReviewCellViewModel()
    let pickSortTypeViewModel = PickSortTypeViewModel()
    let data = BehaviorRelay<[MagnetReviewSectionModel]>(value: [])
    
    // childViewModel -> ViewModel -> View
    let movingSortTypeView = PublishRelay<Bool>()
    let presentUserReviewList: Signal<UserInfo>
    
    private let disposeBag = DisposeBag()
    
    let storeName: String
    
    init() {
        storeName = model.storeName
        self.presentUserReviewList = cellViewModel.nameLabelTapped.asSignal()
        let pickSortTypeButton = pickSortTypeViewModel.selectedSortType.share()
        
        MagnetReviewHttpManager.shared.load {
            Observable.combineLatest(
                self.headerViewModel.hasPhoto,
                self.pickSortTypeViewModel.selectedSortType) {
                    ($0, $1)
                }
                .map(self.model.getData)
                .bind(to: self.data)
                .disposed(by: self.disposeBag)
        }
    
        headerViewModel.sortButtonTapped
            .map { true }
            .bind(to: movingSortTypeView)
            .disposed(by: disposeBag)
        
        pickSortTypeButton
            .bind(to: headerViewModel.selectedSortType)
            .disposed(by: disposeBag)
        
        pickSortTypeButton
            .map { _ in false }
            .bind(to: self.movingSortTypeView)
            .disposed(by: disposeBag)
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<MagnetReviewSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<MagnetReviewSectionModel>(
            configureCell: { [weak self] dataSource, tableView, indexPath, item in
                switch dataSource[indexPath.section] {
                case .totalRatingSection(items: let items):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MagnetReviewTotalRatingCell.self)
                    cell.setData(data: items[indexPath.row])
                    return cell
                case .reviewSection(items: let items):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MagnetReviewCell", for: indexPath) as! MagnetReviewCell
                    cell.setData(data: items[indexPath.row], image: self?.model.makeReviewImage(url: items[indexPath.row].photoUrl))
                    cell.bind((self?.cellViewModel)!)
                    return cell
                }
            })
        return dataSource
    }
}
