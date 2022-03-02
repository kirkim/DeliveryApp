//
//  KiflixHttpManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import Foundation

final class KiflixHttpManager {
    private let httpClient = HttpClient()

    enum KiflixGetType: UrlType {
        case search(title: String)
        case image(urlString: String)
        
        var url: String {
            let BASE_URL: String = "https://itunes.apple.com/search?media=movie&entity=movie&term="
            switch self {
            case .search(title: let title):
                return BASE_URL + title
            case .image(urlString: let url):
                return url
            }
        }
    }
    
    public func getFetch(type getType: KiflixGetType, completion: @escaping (Result<Data, CustomError>) -> Void) {
        httpClient.getHttp(type: getType, completion: completion)
    }
    
    public func getFetchAsync(type getType: KiflixGetType, completion: @escaping (Result<Data, CustomError>) -> Void) async {
        await httpClient.getHttpAsync(type: getType, completion: completion)
    }
}
