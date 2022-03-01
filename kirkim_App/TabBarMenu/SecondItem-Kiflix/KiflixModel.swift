//
//  KiflixModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import Foundation
import UIKit

struct Kiflix: Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let director: String
    let thumbnail: String
    let shortDescription: String?
    let longDescription: String?
    let releaseDate: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnail = "artworkUrl100"
        case shortDescription
        case longDescription
        case releaseDate
        case previewURL = "previewUrl"
    }
}

struct KiflixModel {
    private let manager = KiflixManager.shared
    
    var data: [Movie] {
        return manager.data
    }
    
    func update(text: String, completion: @escaping () -> Void) {
        manager.update(text: text, completion: completion)
    }
    
    func getThumbnail(row index: Int, completion: @escaping (UIImage) -> Void) {
        manager.getThumbnail(row: index, completion: completion)
    }
}

class KiflixManager {
    static let shared = KiflixManager()
    private init() { }
    private let httpManager = KiflixHttpManager()
    
    var data: [Movie] = []
    
    func update(text: String, completion: @escaping () -> Void) {
        httpManager.getFetch(type: .search(title: text), completion: { result in
            switch result {
            case .success(let data):
                do {
                    let datamodel = try JSONDecoder().decode(Kiflix.self, from: data)
                    self.data = datamodel.movies
                    completion()
                } catch {
                    print("----> KiflixModel - update() parsing to Json fail")
                    print(error.localizedDescription)
                    completion()
                }
            case .failure(let error):
                print("----> KiflixModel - update() http fail")
                print(error)
                completion()
            }
        })
    }
    
    func getThumbnail(row index: Int, completion: @escaping (UIImage) -> Void) {
        httpManager.getFetch(type: .image(urlString: self.data[index].thumbnail), completion: { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(UIImage())
                    print("----> KiflixModel - getThumbnail() parsing to image fail")
                    return
                }
                completion(image)
            case .failure(let error):
                print("----> KiflixModel - getThumbnail() http fail")
                print(error)
                completion(UIImage())
            }
        })
    }
}
