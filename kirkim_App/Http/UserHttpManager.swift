//
//  UserHttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/19.
//

import Foundation
import RxSwift


final class UserHttpManager {
    private let httpClient = HttpClient()
    
    public func postFetch<T: Codable>(type postType: UserPostType, body: T, completion: @escaping (Result<Data, CustomError>) -> Void) {
        httpClient.postHttp(type: postType, body: body, completion: completion)
    }
    
    public func getFetch(type getType: UserGetType, completion: @escaping (Result<Data, CustomError>) -> Void) {
        httpClient.getHttp(type: getType, completion: completion)
    }
}


