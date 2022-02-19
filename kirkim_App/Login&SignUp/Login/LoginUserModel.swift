//
//  UserModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation

struct LoginUser: Codable {
    var userID: String
    var password: String
}

enum LoginStatus {
    case success
    case fail
}

final class LoginUserModel {
    private let manager = LoginUserManager.shared
    
    var isLogin: Bool {
        return manager.isLogin
    }
    
    var user: LoginUser? {
        return manager.user
    }
    
    func logIn(userID: String, password: String, completion: @escaping (LoginStatus) -> Void) {
        manager.logIn(userID: userID, password: password, completion: completion)
    }
    
    func logOut() {
        manager.logOut()
    }
}

class LoginUserManager {
    static let shared = LoginUserManager()
    private init() { }
    let httpClient = HttpClient()
    var user: LoginUser?
    var isLogin: Bool = false
    
    private func setUser(user: LoginUser) {
        self.user = user
        self.isLogin = true
    }
    
    func logIn(userID: String, password: String, completion: @escaping (LoginStatus) -> Void) {
        httpClient.fetch(httpAction: .postLogin, body: LoginUser(userID: userID, password: password), completion: { data in
            guard let data = data as? Data else {
                completion(.fail)
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(LoginUser.self, from: data)
                self.setUser(user: dataModel)
                completion(.success)
                print(dataModel)
            } catch {
                completion(.fail)
                print(error)
            }
        })
    }
        
    func logOut() {
        self.user = nil
        self.isLogin = false
    }
}
