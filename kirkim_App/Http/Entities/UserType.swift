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
