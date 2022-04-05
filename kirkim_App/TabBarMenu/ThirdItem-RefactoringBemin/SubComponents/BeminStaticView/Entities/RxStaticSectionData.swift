//
//  RxStaticSectionData.swift
//  RefactoringBeminVC
//
//  Created by 김기림 on 2022/04/05.
//

import Foundation
import RxDataSources

// RxDataSources용 타입
struct RxStaticSectionData {
    var items: [Item]
}

extension RxStaticSectionData: SectionModelType {
    typealias Item = StaticItem
    
    init(original: RxStaticSectionData, items: [Item]) {
        self = original
        self.items = items
    }
}
