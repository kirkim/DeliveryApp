//
//  MagnetPresentMenuSection.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/05/01.
//

import UIKit
import RxDataSources

enum SelectType: Equatable {
    case mustOne
    case custom(min: Int, max: Int)
}

///After Refactoring
enum PresentMenuSectionModel {
    case SectionMainTitle(items: [PresentMenuTitleItem])
    case SectionMenu(header: String, selecType: SelectType, items: [PresentMenuItem])
    case SectionSelectCount(items: [PresentSelectCountItem])
}

protocol PresentMenuSectionItem {
    
}

struct PresentMenuItem: PresentMenuSectionItem {
    var title: String
    var price: Int?
}

struct PresentMenuTitleItem: PresentMenuSectionItem {
    var image: UIImage?
    var mainTitle: String
    var description: String?
}

struct PresentSelectCountItem: PresentMenuSectionItem {
    var title: String?
}

extension PresentMenuSectionModel: SectionModelType {
    typealias Item = PresentMenuSectionItem
    
    init(original: PresentMenuSectionModel, items: [PresentMenuSectionItem]) {
        self = original
    }

    var headers: String? {
        switch self {
        case .SectionMenu(let header, _, _):
            return header
        default:
            return nil
        }
    }
        
  var items: [Item] {
      switch self {
      case .SectionMainTitle(let items):
          return items
      case .SectionMenu(_, _, let items):
          return items
      case.SectionSelectCount(let items):
          return items
      }
  }
}
