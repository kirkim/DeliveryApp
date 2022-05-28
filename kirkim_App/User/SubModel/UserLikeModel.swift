//
//  UserLikeModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/27.
//

import Foundation
import RxSwift

class UserLikeModel {
    typealias likeStoreCodes = [String]
    private let disposeBag = DisposeBag()
    private let httpManager = RxUserHttpManager()
    private var userLikeData: [String]?

    init() {
        
    }
    
    func update(id: String) {
        httpManager.getFetch(type: .likeStoreList(id: id))
            .subscribe { result in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode(likeStoreCodes.self, from: data)
                        self.userLikeData = dataModel
                    } catch {
                        print("decoding error")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } onFailure: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func checkStoreIsLiked(storeCode: String) -> Bool {
        guard let userLikeData = userLikeData else {
            return false
        }
        var isLike:Bool = false
        userLikeData.forEach { code in
            if (code == storeCode) {
                isLike = true
            }
        }
        return isLike
    }
    
    func getLikeStoreCodes() -> [String] {
        guard let userLikeData = userLikeData else {
            return []
        }
        return userLikeData
    }
}
