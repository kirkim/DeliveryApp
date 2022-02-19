//
//  UserHttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/19.
//

import Foundation

class UserHttpClient: HttpClient {
    enum HttpActionType: String {
        case postLogin
        case postSignUp
        case getUsers__Dev
        
        var url: String {
            let BASE_URL: String = "http://localhost:8080"
            switch self {
            case .postLogin:
                return "\(BASE_URL)/user/login"
            case .postSignUp:
                return "\(BASE_URL)/user/signup"
            case .getUsers__Dev:
                return "\(BASE_URL)/user"
            }
        }
    }
    
    public func fetch(httpAction: HttpActionType, body: Any?, completion: @escaping (Any?) -> Void) {
        guard let url = URL(string: httpAction.url) else { return }
        var urlRequest = URLRequest(url: url)
        switch httpAction {
        case .postLogin:
            guard let user = body as? LoginUser,
                  let uploadData = try? JSONEncoder().encode(user) else {
                      print("HttpClient - fetch postLogin error!")
                      return
                  }
            super.postHttp(urlRequest: &urlRequest, uploadData: uploadData, completion: completion)
        case .postSignUp:
            guard let userData = body as? SignupUser,
                  let uploadData = try? JSONEncoder().encode(userData) else {
                      print("HttpClient - fetch postSignup error!")
                      return
                  }
            super.postHttp(urlRequest: &urlRequest, uploadData: uploadData, completion: completion)
        case .getUsers__Dev:
            super.getHttp(urlRequest: &urlRequest, completion: completion)
        }
    }
}
