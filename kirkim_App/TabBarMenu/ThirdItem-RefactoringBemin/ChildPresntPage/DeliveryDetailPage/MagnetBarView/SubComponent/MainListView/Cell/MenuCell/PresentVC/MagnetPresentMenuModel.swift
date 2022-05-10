//
//  MagnetPresentMenuModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/03.
//

import UIKit

struct MagnetPresentMenuModel {
    private let httpManager = HttpModel.shared
    var data:[PresentMenuSectionModel] = []
    let title: String
    
    init(indexPath: IndexPath, image: UIImage?) {

        // initData
        let hasData = httpManager.getMenuDetail(indexPath: indexPath)
        self.title = httpManager.getMenuTitle(indexPath: indexPath)
        self.data.append(PresentMenuSectionModel.SectionMainTitle(items: [PresentMenuTitleItem(image: image, mainTitle: self.title, description: hasData?.description)]))
        hasData?.optionSection.forEach({ section in
            let sectionType = self.setSectionType(min: section.min, max: section.max)
            var menuBundle:[PresentMenuItem] = []
            section.optionMenu.forEach { menu in
                menuBundle.append(PresentMenuItem(title: menu.title, price: menu.price))
            }
            self.data.append(PresentMenuSectionModel.SectionMenu(header: section.title, selecType: sectionType, items: menuBundle))
        })
        self.data.append(PresentMenuSectionModel.SectionSelectCount(items: [PresentSelectCountItem(title: "")]))
    }
    
    func setSectionType(min: Int?, max: Int?) -> SelectType {
        if (min == nil && max == nil) {
            return .mustOne
        }
        guard let min = min else {
            return .custom(min: 0, max: max!)
        }
        guard let max = max else {
            return .custom(min: min, max: 100)
        }
        let correctMin = min > max ? max : min
        if (correctMin == 1 && max == 1) {
            return .mustOne
        }
        return .custom(min: correctMin, max: max)
    }
}
