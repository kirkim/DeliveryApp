//
//  CustomError.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case decodingError
    case responseError
    case noData
    case error(Error)
    case code(Int)
    
    var msg: String {
        switch self {
        case .invalidURL:
            return "InValid URL"
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
