//
//  RxUserHttpManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import Foundation
import RxSwift

class RxUserHttpManager {
    private let httpClient = RxHttpClient()
    
    public func postFetch<T: Codable>(type postType: UserPostType, body: T) -> Single<Result<Data, CustomError>> {
        return httpClient.postHttp(type: postType, body: body, headers: nil)
    }
    
    public func getFetch(type getType: UserGetType) -> Single<Result<Data, CustomError>> {
        return httpClient.getHttp(type: getType, headers: nil)
    }

    public func checkUserId(id: String) -> Single<Result<Data, CustomError>> {
        let data = CheckId(userID: id)
        return self.postFetch(type: .checkId, body: data)
    }
    
    public func signUpUser(userData: SignupUser) -> Single<Result<Data, CustomError>> {
        return self.postFetch(type: .signUp, body: userData)
    }
    
    public func logInUser(loginUserData: LoginUser) -> Single<Result<User, CustomError>> {
        return self.postFetch(type: .login, body: loginUserData)
            .flatMap { result -> Single<Result<User, CustomError>> in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode(User.self, from: data)
                        return .just(.success(dataModel))
                    } catch {
                        print(error.localizedDescription)
                        return .just(.failure(.decodingError))
                    }
                case .failure(let customError):
                    return .just(.failure(customError))
                }
            }
    }
}
