//
//  BeminStaticContent.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit

struct BeminStaticContent: Decodable {
    let sectionType: StaticSectionType
    let contentItem: [StaticItem]
    
    enum StaticSectionType: String, Decodable {
        case big, medium, medium_2, small_3, small_4, banner
    }
}

struct StaticItem: Decodable {
    let title: String
    let description: String?
    let imageName: String?
    
    var image: UIImage {
        guard let imageName = imageName else {
            return UIImage()
        }
        return UIImage(named: imageName) ?? UIImage()
    }
}
