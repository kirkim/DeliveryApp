//
//  StaticItem.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/05.
//

import UIKit

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
