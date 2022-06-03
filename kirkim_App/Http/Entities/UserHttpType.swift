//
//  UserType.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/30.
//

import Foundation

enum UserPostType: String, UrlType {
    case login
    case signUp
    case checkId
    
    var url: String {
        let BASE_URL: String = HttpConfig.url
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

enum UserGetType: UrlType {
    case usersData__Dev
    case likeStoreList(id: String)
    
    var url: String {
        let BASE_URL: String = HttpConfig.url
        switch self {
        case .likeStoreList(let id):
            return "\(BASE_URL)/user/like?id=\(id)"
        case .usersData__Dev:
            return "\(BASE_URL)/user"
        }
    }
}

enum UserPutType: UrlType {
    case toggleLikeStore(id: String, storeCode: String)
    
    var url: String {
        let BASE_URL: String = HttpConfig.url
        switch self {
        case .toggleLikeStore(id: let id, storeCode: let storeCode):
            return "\(BASE_URL)/user/toggleLike?id=\(id)&storeCode=\(storeCode)"
        }
    }
}
