//
//  MagnetReviewHttpManager.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/29.
//

import UIKit
import RxSwift
import RxCocoa

class MagnetReviewHttpModel {
    static let shared = MagnetReviewHttpManager()
    private init() {
    }
    
    private let httpmanager = DeliveryHttpManager.shared
    private let disposeBag = DisposeBag()
    
    func load(storeCode: String, completion: @escaping (ReviewJSONData) -> ()) {
        httpmanager.getFetch(type: .allReviews(storeCode: storeCode))
            .subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let data):
                        do {
                            let dataModel = try JSONDecoder().decode(ReviewJSONData.self, from: data)
                            completion(dataModel)
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
