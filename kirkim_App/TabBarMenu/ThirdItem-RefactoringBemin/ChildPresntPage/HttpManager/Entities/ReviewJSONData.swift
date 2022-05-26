//
//  ReviewJSONData.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit

struct ReviewJSONData: Codable {
    var reviews: [ReviewItem]
    var averageRating: CGFloat
    var storeInfo: StoreInfo
}
