//
//  UserModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation
import RxSwift

struct UserModel {
    private let manager = UserManager.shared
    
    var isLogin: Bool {
        return manager.isLogin
    }
    
    var info: User? {
        return manager.info
    }
    
    func logIn(loginUserData: LoginUser) -> Single<CustomError?> {
        manager.logIn(loginUserData: loginUserData)
    }
    
    func logOut() {
        manager.logOut()
    }
    
    func checkStoreIsLiked(storeCode: String) -> Bool {
        return manager.checkStoreIsLiked(storeCode: storeCode)
    }
    
    func getLikeStoreCodes() -> [String] {
        return manager.getLikeStoreCodes()
    }
    
    func updateLikeStore() {
        return manager.updateLikeStore()
    }
}

final class UserManager {
    static let shared = UserManager()
    private let userHttpManager = RxUserHttpManager()
    private var userLikeModel = UserLikeModel()
    private let disposeBag = DisposeBag()
    var info: User?
    var isLogin: Bool = false
    
    private init() { }
    
    private func setUser(user: User) {
        self.info = user
        self.isLogin = true
        self.userLikeModel.update(id: user.id)
    }
    
    // Public function
    func logIn(loginUserData: LoginUser) -> Single<CustomError?>  {
        return userHttpManager.logInUser(loginUserData: loginUserData)
            .flatMap { [weak self] result -> Single<CustomError?> in
                switch result {
                case .success(let data):
                    self?.setUser(user: data)
                    self?.isLogin = true
                    return .just(nil)
                case .failure(let customError):
                    return .just(customError)
                }
            }
    }
    
    func logOut() {
        self.info = nil
        self.isLogin = false
    }
    
    func checkStoreIsLiked(storeCode: String) -> Bool {
        return self.userLikeModel.checkStoreIsLiked(storeCode: storeCode)
    }
    
    func getLikeStoreCodes() -> [String] {
        return self.userLikeModel.getLikeStoreCodes()
    }
    
    func updateLikeStore() {
        guard let id = info?.id  else { return }
        return self.userLikeModel.update(id: id)
    }
}
