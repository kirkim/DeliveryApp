//
//  ReviewHttpManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class BasicReviewHttpManager {
    static let shared = BasicReviewHttpManager()
    private init() {
    }
    
    private let httpmanager = DeliveryHttpManager.shared
    private let disposeBag = DisposeBag()
    
    func load(id: String, completion: @escaping ([ReviewItem]) -> ()) {
        httpmanager.getFetch(type: .reviewById(id: id))
            .subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let data):
                        do {
                            let dataModel = try JSONDecoder().decode([ReviewItem].self, from: data)
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
