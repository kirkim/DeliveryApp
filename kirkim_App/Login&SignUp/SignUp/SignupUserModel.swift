//
//  SignupUserModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/19.
//

import Foundation

struct User: Codable {
    var data: UserData
    var id: String
}
struct UserData: Codable {
    var userID: String
    var password: String
    var name: String
}

struct SignupUser: Codable {
    var userID: String
    var password: String
    var confirmPassword: String
    var name: String
}

class SignupUserModel {
    
    private let manager = SignupUserManager.shared
    
    func signup(signupData: SignupUser, completion: @escaping (SignupUserManager.ValidatorResult) -> Void) {
        manager.signup(signupData: signupData, completion: completion)
    }
    
    func isValidUserID(id: String) -> Bool {
        return manager.isValidUserID(id: id)
    }
    
    func isValidPassword(pwd: String) -> Bool {
        return manager.isValidPassword(pwd: pwd)
    }

}

class SignupUserManager {
    static let shared = SignupUserManager()
    private init() { }
    private let httpClient = UserHttpClient()
    
    
    enum ValidatorResult {
        case success
        case wrongID
        case wrongPW
        case wrongConfimPW
        case wrongName
        var message: String {
            switch self {
            case .success:
                return ""
            case .wrongID:
                return "유효한 아이디를 입력해 주세요!"
            case .wrongPW:
                return "유효한 비밀번호를 입력해 주세요!"
            case .wrongConfimPW:
                return "동일한 비밀번호를 입력해 주세요!"
            case .wrongName:
                return "이름을 입렵해 주세요!"
            }
        }
    }
    
    func signup(signupData: SignupUser, completion: @escaping (ValidatorResult) -> Void) {
        let checkUserResult = checkUserData(checkData: signupData)
        if ( checkUserResult != .success) {
            completion(checkUserResult)
            return
        } else {
            httpClient.fetch(httpAction: .postSignUp, body: signupData, completion: { _ in
                completion(.success)
            })
        }
    }
    
    private func checkUserData(checkData: SignupUser) -> ValidatorResult {
        if(self.isValidUserID(id: checkData.userID) == false) {
            return ValidatorResult.wrongID
        }
        if(self.isValidPassword(pwd: checkData.password) == false) {
            return ValidatorResult.wrongPW
        }
        if(checkData.password != checkData.confirmPassword) {
            return ValidatorResult.wrongConfimPW
        }
        if(self.isValidName(name: checkData.name) == false) {
            return ValidatorResult.wrongName
        }
        return ValidatorResult.success
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
    
    func isValidName(name: String) -> Bool {
        let nameRegEx = "[A-Z0-9a-z._%+-]{1,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
}
