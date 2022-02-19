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
    
    var user: User? {
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
    let httpClient = UserHttpClient()
    var user: User?
    var isLogin: Bool = false
    
    private func setUser(user: User) {
        self.user = user
        self.isLogin = true
    }
    
    func logIn(userID: String, password: String, completion: @escaping (LoginStatus) -> Void) {
        print("LoginUserMAnager logIn called")
        httpClient.fetch(httpAction: .postLogin, body: LoginUser(userID: userID, password: password), completion: { [weak self] data in
            guard let data = data as? Data else {
                print("LoginUserModel- logIn() fail data parsing")
                completion(.fail)
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(User.self, from: data)
                self?.setUser(user: dataModel)
                completion(.success)
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
