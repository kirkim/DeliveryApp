//
//  BeminStaticContent.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import Foundation

enum StaticCellUIType: String, Decodable {
    case big, medium, medium_2, small_3, small_4, banner
}

// Plist -> Array 파싱용 타입
struct BeminStaticContent: Decodable {
    let sectionType: StaticCellUIType
    let contentItem: [StaticItem]
}
