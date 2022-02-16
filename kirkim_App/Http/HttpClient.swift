//
//  HttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation

enum HttpActionType: String {
    case postLogin = "http://localhost:8080/user/login"
}

class HttpClient {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    public func fetch(httpAction: HttpActionType, body: Any?, completion: @escaping (Any?) -> Void) {
        guard let url = URL(string: httpAction.rawValue) else { return }
        var urlRequest = URLRequest(url: url)
        switch httpAction {
        case .postLogin:
            guard let user = body as? User else { return }
            postLogin(urlRequest: &urlRequest, user: user, completion: completion)
        }

    }
    
    private func postLogin(urlRequest: inout URLRequest, user: User, completion: @escaping (Any?) -> Void) {
        urlRequest.httpMethod = "POST"
        guard let uploadData = try? JSONEncoder().encode(user) else { return }
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
    
    //    private func getData(urlRequest: inout URLRequest, completion: @escaping (Any?) -> Void) {
    //        urlRequest.httpMethod = "GET"
    //        session.dataTask(with: urlRequest) { data, response, error in
    //            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
//                    print("error")
    //                return
    //            }
    //            guard let data = data else {
    //                print(error.debugDescription)
    //                return
    //            }
    //            completion(data)
    //        }.resume()
    //        session.finishTasksAndInvalidate()
    //        completion(nil)
    //    }
}

