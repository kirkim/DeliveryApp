//
//  StoreListHttpManager.swift
//  DeliveryMenuPage
//
//  Created by 김기림 on 2022/05/08.
//

import Foundation
import RxSwift

class DeliveryHttpManager {
    static let shared = DeliveryHttpManager()
    
    private init() { }
    private let httpClient = RxHttpClient()
    
    public func getFetch(type getType: DeliveryGetType) -> Single<Result<Data, CustomError>> {
        return httpClient.getHttp(type: getType, headers: nil)
    }
}
