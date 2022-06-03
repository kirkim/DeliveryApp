//
//  BASE_URL.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/06/02.
//

import Foundation

enum MYURL {
    case base
    case dev
    var url:String {
        switch self {
        case .base:
            return "https://kirkim.com"
        case .dev:
            return "http://localhost:4000"
        }
    }
}

struct HttpConfig {
    static let url = MYURL.dev.url
}
