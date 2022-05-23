//
//  ReviewHttpManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class ReviewHttpManager {
    static let shared = ReviewHttpManager()
    private init() {
    }
    
    private let httpmanager = DeliveryHttpManager.shared
    private let disposeBag = DisposeBag()
    var reviewData: MagnetReviewSectionModel?
    var totalRatingData: MagnetReviewSectionModel?
    
    func load(id: String, completion: @escaping () -> ()) {
        httpmanager.getFetch(type: .reviewById(id: id))
            .subscribe(
                onSuccess: { [weak self] result in
                    switch result {
                    case .success(let data):
                        do {
                            let dataModel = try JSONDecoder().decode(ReviewJSONData.self, from: data)
                            self?.totalRatingData = MagnetReviewSectionModel.totalRatingSection(items: [TotalRatingItem(totalCount: dataModel.reviews.count, averageRating: dataModel.averageRating)])
                            self?.reviewData = MagnetReviewSectionModel.reviewSection(items: dataModel.reviews)
                            completion()
                        } catch {
                            print("decoding error: ", error.localizedDescription)
                        }
                    case .failure(let error):
                        print("fail: ", error.localizedDescription)
                    }
                
            }, onFailure: { error in
                print("error: ", error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
