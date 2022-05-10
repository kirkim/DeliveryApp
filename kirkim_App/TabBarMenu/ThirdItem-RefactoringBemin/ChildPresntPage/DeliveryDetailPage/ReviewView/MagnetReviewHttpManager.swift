//
//  MagnetReviewHttpManager.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/29.
//

import UIKit
import RxSwift
import RxCocoa

struct ReviewJSONData: Codable {
    var reviews: [ReviewItem]
    var averageRating: CGFloat
}

class MagnetReviewHttpManager {
    static let shared = MagnetReviewHttpManager()
    private init() {
        storeName = storeHttpManager.getStoreName()
    }
    
    private let httpmanager = DeliveryHttpManager.shared
    private let storeHttpManager = HttpModel.shared
    private let disposeBag = DisposeBag()
    var reviewData: MagnetReviewSectionModel?
    var totalRatingData: MagnetReviewSectionModel?
    let storeName: String
    
    func load(completion: @escaping () -> ()) {
        httpmanager.getFetch(type: .allReviews(storeCode: storeHttpManager.getStoreCode()))
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
