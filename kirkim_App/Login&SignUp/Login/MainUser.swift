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
    var message: String {
        switch self {
        case .success:
            return ""
        case .fail:
            return "아이디 또는 비밀번호를 확인하세요."
        }
    }
}

struct MainUser {
    private let manager = MainUserManager.shared
    
    var isLogin: Bool {
        return manager.isLogin
    }
    
    var info: User? {
        return manager.info
    }
    
    func logIn(userID: String, password: String, completion: @escaping (LoginStatus) -> Void) {
        manager.logIn(userID: userID, password: password, completion: completion)
    }
    
    func logOut() {
        manager.logOut()
    }
}

final class MainUserManager {
    static let shared = MainUserManager()
    private init() { }
    private let userHttpManager = UserHttpManager()
    var info: User?
    var isLogin: Bool = false
    
    private func setUser(user: User) {
        self.info = user
        self.isLogin = true
    }
    
    func logIn(userID: String, password: String, completion: @escaping (LoginStatus) -> Void) {
        print("LoginUserMAnager logIn called")
        let loginData = LoginUser(userID: userID, password: password)
        userHttpManager.postFetch(type: .login, body: loginData, completion: { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let dataModel = try JSONDecoder().decode(User.self, from: data)
                    self?.setUser(user: dataModel)
                    completion(.success)
                    self?.isLogin = true
                } catch {
                    print(error)
                    completion(.fail)
                }
            case .failure(let error):
                print(error)
                completion(.fail)
            }
        })
    }
    
    func logOut() {
        self.info = nil
        self.isLogin = false
    }
}
