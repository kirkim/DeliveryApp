//
//  SignupUserModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/19.
//

import Foundation

struct SignUpPageViewModel {
    private let manager = SignUpPageViewManager.shared
    
    func signup(signupData: SignUserData, completion: @escaping (SignUpPageViewManager.ValidatorResult) -> Void) {
        manager.signup(signupData: signupData, completion: completion)
    }
    
    func isValidUserID(id: String) -> Bool {
        return manager.isValidUserID(id: id)
    }
    
    func isValidPassword(pwd: String) -> Bool {
        return manager.isValidPassword(pwd: pwd)
    }
}

class SignUpPageViewManager {
    static let shared = SignUpPageViewManager()
    private init() { }
    private let userHttpManager = UserHttpManager()
    
    //View -> ViewModel
    
    
    
    enum ValidatorResult {
        case success
        case wrongID
        case wrongPW
        case wrongConfimPW
        case wrongName
        case httpError
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
            case .httpError:
                return "Http Error"
            }
        }
    }
    
    func signup(signupData: SignUserData, completion: @escaping (ValidatorResult) -> Void) {
        let checkUserResult = checkUserData(checkData: signupData)
        if ( checkUserResult != .success) {
            completion(checkUserResult)
            return
        } else {
            userHttpManager.postFetch(type: .signUp, body: signupData, completion: { result in
                switch result {
                case .success(_):
                    completion(.success)
                    break;
                case .failure(let error):
                    completion(.httpError)
                    print(error)
                }
            })
        }
    }
    
    private func checkUserData(checkData: SignUserData) -> ValidatorResult {
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
        let nameRegEx = "[A-Z0-9a-z가-힣._%+-]{1,}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: name)
    }
}
