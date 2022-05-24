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
    let model: BasicReviewModel
    private let disposeBag = DisposeBag()
    
    init(id: String) {
        self.model = BasicReviewModel(id: id)
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
            configureCell: { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                cell.setData(data: item, image: self.model.makeReviewImage(url: item.photoUrl))
                return cell
            })
        return dataSource
    }
}
