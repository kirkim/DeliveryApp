//
//  StoreListHttpModel.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import Foundation
import RxSwift
import RxCocoa


class SummaryStoreHttpModel {
    private let disposeBag = DisposeBag()
    
    let httpManager = DeliveryHttpManager.shared
    static let shared = SummaryStoreHttpModel()
    private init() { }
    
    func load(type: GetSummaryType, completion: @escaping (([StoreListSection]) -> ())) {
        
        var validType: DeliveryGetType {
            switch type {
            case .storeType(type: let t):
                return .summaryStores(type: t)
            case .userCode(code: let id):
                return .likeSummaryStores(userCode: id)
            }
        }
        
        httpManager.getFetch(type: validType)
            .subscribe { result in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode([SummaryStoreItem].self, from: data)
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
