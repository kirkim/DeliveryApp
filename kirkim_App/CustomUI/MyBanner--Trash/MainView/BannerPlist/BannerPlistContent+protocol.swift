//
//  BannerContentProtocol.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit

protocol BannerPlistContent {
    static var plistName: String { get }
    var smallImageName: String? { get }
    var smllImage: UIImage { get }
}
