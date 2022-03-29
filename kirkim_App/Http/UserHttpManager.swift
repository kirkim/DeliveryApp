//
//  UserHttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/19.
//

import Foundation
import RxSwift

enum UserPostType: String, UrlType {
    case login
    case signUp
    case checkId
    
    var url: String {
        let BASE_URL: String = "http://localhost:8080"
        switch self {
        case .login:
            return "\(BASE_URL)/user/login"
        case .signUp:
            return "\(BASE_URL)/user/signup"
        case .checkId:
            return "\(BASE_URL)/user/checkid"
        }
    }
}
enum UserGetType: String, UrlType {
    case usersData__Dev
    
    var url: String {
        let BASE_URL: String = "http://localhost:8080"
        switch self {
        case .usersData__Dev:
            return "\(BASE_URL)/user"
        }
    }
}

final class UserHttpManager {
    private let httpClient = HttpClient()
    
    public func postFetch<T: Codable>(type postType: UserPostType, body: T, completion: @escaping (Result<Data, CustomError>) -> Void) {
        httpClient.postHttp(type: postType, body: body, completion: completion)
    }
    
    public func getFetch(type getType: UserGetType, completion: @escaping (Result<Data, CustomError>) -> Void) {
        httpClient.getHttp(type: getType, completion: completion)
    }
}


