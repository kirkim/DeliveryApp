//
//  HttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation

class HttpClient {
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

    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    public func fetch(httpAction: HttpActionType, body: Any?, completion: @escaping (Any?) -> Void) {
        guard let url = URL(string: httpAction.url) else { return }
        var urlRequest = URLRequest(url: url)
        switch httpAction {
        case .postLogin:
            guard let user = body as? User,
                  let uploadData = try? JSONEncoder().encode(user) else { return }
            postHttp(urlRequest: &urlRequest, uploadData: uploadData, completion: completion)
        case .postSignUp:
            guard let userData = body as? UserData,
                  let uploadData = try? JSONEncoder().encode(userData) else { return }
            postHttp(urlRequest: &urlRequest, uploadData: uploadData, completion: completion)
        case .getUsers__Dev:
            getHttp(urlRequest: &urlRequest, completion: completion)
        }
    }
    
    private func postHttp(urlRequest: inout URLRequest, uploadData: Data, completion: @escaping (Any?) -> Void) {
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: urlRequest, from: uploadData) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                print("error")
                completion(nil)
                return
            }
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
        completion(nil)
    }

    private func getHttp(urlRequest: inout URLRequest, completion: @escaping (Any?) -> Void) {
        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                print("error")
                return
            }
            guard let data = data else {
                print(error.debugDescription)
                return
            }
            completion(data)
        }.resume()
        session.finishTasksAndInvalidate()
        completion(nil)
    }
}

