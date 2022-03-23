//
//  Kiflix.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/23.
//

import Foundation

struct KiflixModel: Codable {
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
