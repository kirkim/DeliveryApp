//
//  BannerHttpManager.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/23.
//

import Foundation

final class BannerHttpManager {
    private let httpClient = HttpClient()

    enum BannerGetType: UrlType {
        case getBanner
        case image(urlString: String)
        
        var url: String {
            let BASE_URL: String = "http://localhost:8080"
            switch self {
            case .getBanner:
                return "\(BASE_URL)/banner"
            case .image(urlString: let url):
                return url
            }
        }
    }
    public func getFetch(type getType: BannerGetType, completion: @escaping (Result<Data, CustomError>) -> Void) {
        httpClient.getHttp(type: getType, completion: completion)
    }
    
    public func getFetchAsync(type getType: BannerGetType, completion: @escaping (Result<Data, CustomError>) -> Void) async {
        await httpClient.getHttpAsync(type: getType, completion: completion)
    }

}
