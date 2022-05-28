//
//  MyLikeStoreHttpModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/28.
//

import UIKit
import RxSwift
import RxCocoa

class MyLikeStoreHttpModel {
    static let shared = MyLikeStoreHttpModel()
    private init() {
    }
    
    private let httpmanager = RxUserHttpManager()
    private let disposeBag = DisposeBag()
    
    func toggleLikeStore(id: String, storeCode: String, completion: @escaping (Bool) -> ()) {
        httpmanager.putFetch(type: .toggleLikeStore(id: id, storeCode: storeCode))
            .subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let data):
                        do {
                            let dataModel = try JSONDecoder().decode(Bool.self, from: data)
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
