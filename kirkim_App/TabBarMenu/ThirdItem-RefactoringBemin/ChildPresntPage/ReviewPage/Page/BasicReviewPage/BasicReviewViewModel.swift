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

class BasicReviewViewModel {
    private let model: BasicReviewModel
    private let reviewCellViewModel = ReviewCellViewModel()
    private let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let presentDetailStoreVC: Signal<String>
    
    init(id: String) {
        self.model = BasicReviewModel(id: id)
        self.presentDetailStoreVC = reviewCellViewModel.storeLabelTapped.asSignal()
    }
    
    func updata(id: String, completion: @escaping () -> ()) {
        self.model.updata(id: id, completion: completion)
    }
    
    func getTotalReviewsCount() -> Int {
        return model.getTotalReviewCount()
    }
    
    func getDataObservable() -> Driver<[ReviewSectionModel]> {
        return model.getCellDatas()
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<ReviewSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<ReviewSectionModel>(
            configureCell: { [weak self] dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                if (item.photoUrl != nil) {
                    cell.setData(data: item, isImage: true)
                    DispatchQueue.global().async {
                        let image = self?.model.makeReviewImage(url: item.photoUrl)
                        DispatchQueue.main.async {
                            cell.setImage(image: image!)
                        }
                    }
                } else {
                    cell.setData(data: item, isImage: false)
                }
                cell.bind((self?.reviewCellViewModel)!)
                return cell
            })
        return dataSource
    }
}
