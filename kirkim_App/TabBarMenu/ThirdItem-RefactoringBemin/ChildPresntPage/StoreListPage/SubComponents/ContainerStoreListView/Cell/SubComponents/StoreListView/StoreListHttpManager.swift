//
//  StoreListHttpModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import Foundation
import RxSwift
import RxCocoa

class StoreListHttpManager {
    private let disposeBag = DisposeBag()
    
    let httpManager = DeliveryHttpManager.shared
//    let data = PublishRelay<[StoreListSection]>()
    static let shared = StoreListHttpManager()
    private init() { }
    
    func load(storeType: StoreType, completion: @escaping (([StoreListSection]) -> ())) {
        httpManager.getFetch(type: .summaryStores(type: storeType))
            .subscribe { result in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode([SummaryStoreItem].self, from: data)
//                        self.data.accept([StoreListSection(items: dataModel)])
                        completion([StoreListSection(items: dataModel)])
                    } catch {
                        print("decoding error: ", error.localizedDescription)
                    }
                case .failure(let error):
                    print("fail: ", error.localizedDescription)
                }
            } onFailure: { error in
                print("error: ", error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
