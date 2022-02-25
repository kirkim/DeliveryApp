//
//  HttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation

enum CustomError: Error {
    case decodingError
    case responseError
    case noData
    case error(Error)
    case code(Int)
    
    var msg: String {
        switch self {
        case .decodingError:
            return "Decoding Error"
        case .noData:
            return "No Data"
        case .responseError:
            return "Response Error"
        case .error(let err):
            return err.localizedDescription
        case .code(let code):
            return "\(code) Error"
        }
    }
}

protocol UrlType {
    var url: String { get }
}

// TODO: fetch의 Data 타입을 뷰모델에서 처리하도록 바꾸자
struct HttpClient {
    func postHttp<T: UrlType, B: Codable>(type postType: T, body: B, completion: @escaping (Result<Data, CustomError>) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = URL(string: postType.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let uploadData = try? JSONEncoder().encode(body) else {
            completion(.failure(.decodingError))
            return
        }
        session.uploadTask(with: urlRequest, from: uploadData) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            if let err = error {
                completion(.failure(.error(err)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
        session.finishTasksAndInvalidate()
    }

    func getHttp<T: UrlType>(type getType: T, completion: @escaping (Result<Data, CustomError>) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = URL(string: getType.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            if let err = error {
                completion(.failure(.error(err)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
        session.finishTasksAndInvalidate()
    }
    
    func getHttpAsync<T: UrlType>(type getType: T, completion: @escaping (Result<Data, CustomError>) -> Void) async {
        guard let url = URL(string: getType.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            completion(.success(data))
        } catch {
            completion(.failure(.error(error)))
            return
        }
    }
    
}

