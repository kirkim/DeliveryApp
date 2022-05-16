//
//  MagnetListModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/21.
//

import Foundation
import RxCocoa
import RxSwift

typealias HttpModel = DetailStoreHttpModel
class DetailStoreHttpModel {
    static let shared = DetailStoreHttpModel()
    
    private init() { }
    
    private var data:[MagnetSectionModel]?
    private let httpManager = DeliveryHttpManager.shared
    private var mainTitle: String?
    private var bannerPhotoUrl: [String]?
    private var menuTotalCount: Int?
    private var storeCode: String?
    private var minPrice: Int?
    private var deliveryTip: Int?
    private var thumbnailUrl: String?
    
    let disposeBag = DisposeBag()
    let navData = PublishRelay<[String]>()
    
    func loadData(code: String, completion: @escaping () -> ()) {
        httpManager.getFetch(type: .detailStore(storeCode: code))
            .subscribe(onSuccess: { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode(DetailStore.self, from: data)
                        var menuCount: Int = 0
                        self?.storeCode = dataModel.code
                        self?.mainTitle = dataModel.storeName
                        self?.bannerPhotoUrl = dataModel.bannerPhotoUrl
                        self?.minPrice = dataModel.minPrice
                        self?.deliveryTip = dataModel.deliveryPrice
                        self?.thumbnailUrl = dataModel.thumbnailUrl
                        var data = [
                            MagnetSectionModel.SectionBanner(items: [DetailBannerItem(imageUrl: dataModel.bannerPhotoUrl, mainTitle: dataModel.storeName)]),
                            MagnetSectionModel.SectionInfo(items: [InfoItem(deliveryPrice: dataModel.deliveryPrice, minPrice: dataModel.minPrice, address: dataModel.address, storeCode: dataModel.code)])
                        ]
                        var titles: [String] = []
                        dataModel.menuSection.forEach { section in
                            titles.append(section.title)
                        }
                        data.append(MagnetSectionModel.SectionSticky(items: [StrickyItem(slots: titles)]))
                        
                        dataModel.menuSection.forEach { section in
                            var items: [MenuItem] = []
                            section.menu.forEach { menu in
                                menuCount += 1
                                items.append(MenuItem(menuCode: menu.menuCode, title: menu.menuName, description: menu.description, price: menu.price, thumbnail: menu.menuPhotoUrl, menuDetail: menu.menuDetail))
                            }
                            data.append(MagnetSectionModel.SectionMenu(header: section.title, items: items))
                        }
//                        self?.data.accept(data)
                        self?.data = data
                        self?.menuTotalCount = menuCount
                        completion()
                    } catch {
                        print("decoding error: ", error.localizedDescription)
                    }
                case .failure(let error):
                    print("fail: ", error.localizedDescription)
                }
            }, onFailure: { error in
                print("error: ", error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func getTotalData() -> [MagnetSectionModel] {
        guard let data = data else { return [] }
        return data
    }
    
    func getSectionTitles() -> [String] {
        guard let data = data else { return [] }
        var titles:[String] = []
        data.forEach { sectionModel in
            switch sectionModel {
            case .SectionMenu(header: let header, items: _):
                titles.append(header)
            default:
                return
            }
        }
        return titles
    }
    
    func getStoreName() -> String {
        guard let mainTitle = mainTitle else { return "" }
        return mainTitle
    }
    
    func getthumbnailUrl() -> String {
        guard let thumbnailUrl = thumbnailUrl else { return "" }
        return thumbnailUrl
    }
    
    func getBannerImageUrls() -> [String] {
        guard let bannerPhotoUrl = bannerPhotoUrl else { return [] }
        return bannerPhotoUrl
    }
    
    func getMenuTotalCount() -> Int {
        guard let menuTotalCount = menuTotalCount else { return 0 }
        return menuTotalCount
    }
    
    func getStoreCode() -> String {
        guard let storeCode = storeCode else {
            return ""
        }
        return storeCode
    }
    
    func getMenuCode(indexPath: IndexPath) -> String {
        guard let data = data,
              let menuData = data[indexPath.section].items as? [MenuItem] else {
            return ""
        }
        return menuData[indexPath.row].menuCode
    }
    
    func getMenuDetail(indexPath: IndexPath) -> MenuDetail? {
        guard let data = data,
              let menuData = data[indexPath.section].items as? [MenuItem] else {
            return nil
        }
        return menuData[indexPath.row].menuDetail
    }
    
    func getMinPrice() -> Int {
        guard let minPrice = minPrice else {
            return 0
        }
        return minPrice
    }
    
    func getMenuTitle(indexPath: IndexPath) -> String {
        guard let data = data,
              let menuData = data[indexPath.section].items as? [MenuItem] else {
            return ""
        }
        return menuData[indexPath.row].title
    }
    
    func getDeliveryTip() -> Int {
        guard let deliveryTip = self.deliveryTip else { return 0 }
        return deliveryTip
    }
}
