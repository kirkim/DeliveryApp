//
//  StaticEventContent.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit

struct StaticBannerContent: Decodable, BannerContent {
    static let plistName: String = "StaticEventContent"
    let title: String
    let eventDeadline: Date
    let smallImageName: String?
    let bigImageName: String?
    
    var smallImage: UIImage {
        guard let smallImageName = smallImageName else {
            return UIImage()
        }
        return UIImage(named: smallImageName) ?? UIImage()
    }
}
