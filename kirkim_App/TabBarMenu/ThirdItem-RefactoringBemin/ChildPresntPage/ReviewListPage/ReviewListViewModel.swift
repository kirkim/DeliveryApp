//
//  ReviewListViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class ReviewListViewModel {
    let model = ReviewListModel()
    let data = BehaviorRelay<[MagnetReviewSectionModel]>(value: [])
    
    // childViewModel -> ViewModel -> View
    let movingSortTypeView = PublishRelay<Bool>()
    
    private let disposeBag = DisposeBag()
    
    let storeName: String
    
    init() {
        storeName = model.storeName
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<MagnetReviewSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<MagnetReviewSectionModel>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath.section] {
                case .totalRatingSection(items: let items):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MagnetReviewTotalRatingCell.self)
                    cell.setData(data: items[indexPath.row])
                    return cell
                case .reviewSection(items: let items):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                    cell.setData(data: items[indexPath.row], image: self.model.makeReviewImage(index: indexPath.row, url: items[indexPath.row].photoUrl))
                    return cell
                }
            })
        return dataSource
    }
}
