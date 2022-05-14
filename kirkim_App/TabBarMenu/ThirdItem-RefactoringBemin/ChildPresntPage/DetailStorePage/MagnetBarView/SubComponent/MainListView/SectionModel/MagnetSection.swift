//
//  RxStaticSectionData.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/13.
//

import RxDataSources

// RxDataSources용 타입
struct MagnetSection {
    var header: String
    var items: [Item]
}

extension MagnetSection: SectionModelType {
    typealias Item = MenuItem

    init(original: MagnetSection, items: [Item]) {
        self = original
        self.items = items
    }
}

///After Refactoring
enum MagnetSectionModel {
    case SectionBanner(items: [DetailBannerItem])
    case SectionInfo(items: [InfoItem])
    case SectionSticky(items: [StrickyItem])
    case SectionMenu(header: String, items: [MenuItem])
}

protocol MagnetSectionItem {
    
}

struct InfoItem: MagnetSectionItem {
    var deliveryPrice: Int
    var minPrice: Int
    var address: String
    var storeCode: String
}

struct MenuItem: MagnetSectionItem {
    var menuCode: String
    var title: String
    var description: String?
    var price: Int
    var thumbnail: String
    var menuDetail: MenuDetail
}

struct DetailBannerItem: MagnetSectionItem {
    var imageUrl: [String]
    var mainTitle: String
}

struct StrickyItem: MagnetSectionItem {
    var slots: [String]
}

extension MagnetSectionModel: SectionModelType {
    typealias Item = MagnetSectionItem
    
    init(original: MagnetSectionModel, items: [MagnetSectionItem]) {
        self = original
    }

    var headers: String? {
        switch self {
        case .SectionMenu(let header, _):
            return header
        default:
            return nil
        }
    }
    
  var items: [Item] {
      switch self {
      case .SectionBanner(let items):
          return items
      case .SectionInfo(let items):
          return items
      case.SectionMenu(_, let items):
          return items
      case .SectionSticky(let items):
          return items
      }
  }
}
