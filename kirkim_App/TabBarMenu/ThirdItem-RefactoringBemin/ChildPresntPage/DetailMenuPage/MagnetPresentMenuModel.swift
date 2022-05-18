//
//  MagnetPresentMenuModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/03.
//

import UIKit

struct MagnetPresentMenuModel {
    private let httpManager = DetailStoreDataManager.shared
    var data:[PresentMenuSectionModel] = []
    let title: String
    let indexPath: IndexPath
    
    init(indexPath: IndexPath, image: UIImage?) {
        self.indexPath = indexPath
        // initData
        
        let hasData = httpManager.getMenuDetail(indexPath: indexPath)
        self.title = httpManager.getMenuTitle(indexPath: indexPath)
        
        let hasImage = image != nil ? image : httpManager.getMenuThumbnail(indexPath: indexPath)
        self.data.append(PresentMenuSectionModel.SectionMainTitle(items: [PresentMenuTitleItem(image: hasImage, mainTitle: self.title, description: hasData?.description)]))
        hasData?.optionSection.forEach({ section in
            let sectionType = self.setSectionType(min: section.min, max: section.max)
            var menuBundle:[PresentMenuItem] = []
            var i = 0
            section.optionMenu.forEach { menu in
                i += 1
                let isSelected = (sectionType == .mustOne && i == 1) ? true : false
                menuBundle.append(PresentMenuItem(title: menu.title, price: menu.price, isSelected: isSelected))
            }
            self.data.append(PresentMenuSectionModel.SectionMenu(header: section.title, selectType: sectionType, items: menuBundle))
        })
        self.data.append(PresentMenuSectionModel.SectionSelectCount(items: [PresentSelectCountItem(count: 1)]))
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
