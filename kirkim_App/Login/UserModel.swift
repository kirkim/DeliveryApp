//
//  UserModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation

struct User: Codable {
    var userID: String
    var password: String
}

struct UserData: Codable {
    var userID: String
    var password: String
    var name: String
}

struct UserDataMaster: Codable {
    var data: UserData
    var id: String
}

final class UserModel {
    
    private let manager = UserManager.shared
    
    var user: UserDataMaster? {
        return manager.user
    }
    
    func setUser(user: UserDataMaster) {
        manager.setUser(user: user)
    }

    func isValidUserID(id: String) -> Bool {
        return manager.isValidUserID(id: id)
    }
    
    func isValidPassword(pwd: String) -> Bool {
        return manager.isValidPassword(pwd: pwd)
    }
}

class UserManager {
    static let shared = UserManager()
    
    private init() { }
    
    var user: UserDataMaster?
    
    func setUser(user: UserDataMaster) {
        self.user = user
    }
    
    func isValidUserID(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{1,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }

}
