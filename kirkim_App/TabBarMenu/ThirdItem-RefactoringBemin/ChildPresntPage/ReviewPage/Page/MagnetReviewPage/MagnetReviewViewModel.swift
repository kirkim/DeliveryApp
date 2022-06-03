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
//    let data = BehaviorRelay<[MagnetReviewSectionModel]>(value: [])
    
    // childViewModel -> ViewModel -> View
    let movingSortTypeView = PublishRelay<Bool>()
    let presentUserReviewList: Signal<UserInfo>
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.presentUserReviewList = cellViewModel.nameLabelTapped.asSignal()
        let pickSortTypeButton = pickSortTypeViewModel.selectedSortType.share()
        
        Observable.combineLatest(
            self.headerViewModel.hasPhoto,
            self.pickSortTypeViewModel.selectedSortType) {
                ($0, $1)
            }
            .bind(onNext: self.model.updateByoptionChanged)
            .disposed(by: self.disposeBag)
        
        
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
    
    // public function
    func getStoreNameObservable() -> Driver<String> {
        return model.getStoreNameObservable().asDriver(onErrorJustReturn: "")
    }
    
    
    func getDataObservable() -> Driver<[MagnetReviewSectionModel]> {
        return model.getDataObservable().asDriver(onErrorJustReturn: [])
    }
    
    func update(completion: (() -> ())? = nil) {
        model.update(completion: completion)
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
                    if (items[indexPath.row].photoUrl != nil) {
                        cell.setData(data: items[indexPath.row], isImage: true)
                        DispatchQueue.global().async {
                            let image = self?.model.makeReviewImage(url: items[indexPath.row].photoUrl)
                            DispatchQueue.main.async {
                                cell.setImage(image: image!)
                            }
                        }
                    } else {
                        cell.setData(data: items[indexPath.row], isImage: false)
                    }
                    cell.bind((self?.cellViewModel)!)
                    return cell
                }
            })
        return dataSource
    }
}
