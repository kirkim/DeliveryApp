//
//  HttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation

// TODO: fetch의 Data 타입을 뷰모델에서 처리하도록 바꾸자
class HttpClient {
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func postHttp(urlRequest: inout URLRequest, uploadData: Data, completion: @escaping (Any?) -> Void) {
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.uploadTask(with: urlRequest, from: uploadData) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                print("error")
                completion(nil)
                return
            }
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            completion(data)
        }.resume()
    }

    func getHttp(urlRequest: inout URLRequest, completion: @escaping (Any?) -> Void) {
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
//        session.finishTasksAndInvalidate()
    }
}

