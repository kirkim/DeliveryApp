//
//  MagnetReviewModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/28.
//

import UIKit
import RxSwift
import RxCocoa

class MagnetReviewModel {
    private let disposeBag = DisposeBag()
    private var reviewImageStorage: [String : UIImage] = [:]
    private let httpManager = MagnetReviewHttpManager.shared
    private let dataObservable = BehaviorRelay<[MagnetReviewSectionModel]>(value: [])
    private let storeNameObservable = BehaviorRelay<String>(value: "")
    private var hasPhoto: Bool = false
    private var sortType: ReViewSortType = .latestOrder
    
    init() {
    }
    
    func makeReviewImage(url: String?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        
        if (reviewImageStorage[url] != nil) {
            return reviewImageStorage[url]!
        } else {
            let imageUrl = URL(string: url)
            let data = try? Data(contentsOf: imageUrl!)
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                if let image = image { self.reviewImageStorage.updateValue(image, forKey: url) }
            }
            return image ?? UIImage()
        }
    }
    
    func getDataObservable() -> Observable<[MagnetReviewSectionModel]> {
        return self.dataObservable.share()
    }
    
    func getStoreNameObservable() -> Observable<String> {
        return storeNameObservable.share()
    }
    
    func updateByoptionChanged(hasPhoto: Bool, sortType: ReViewSortType) {
        self.hasPhoto = hasPhoto
        self.sortType = sortType
        update()
    }
    
    func update(completion: (() -> ())? = nil) {
        MagnetReviewHttpManager.shared.load(storeCode: DetailStoreHttpManager.shared.getStoreCode()) { jsonData in
            self.storeNameObservable.accept( jsonData.storeInfo.storeName )
            var items = jsonData.reviews
            let totalRatingData = MagnetReviewSectionModel.totalRatingSection(items: [TotalRatingItem(totalCount: items.count, averageRating: jsonData.averageRating)])
            
            items.sort(by: sortLatest(a:b:))
            switch self.sortType {
            case .latestOrder:
                break;
            case .highStarRating:
                items.sort(by: sortHighRating(a:b:))
            case .lowStarRating:
                items.sort(by: sortLowRating(a:b:))
            }
            
            guard self.hasPhoto == true else {
                self.dataObservable.accept( [totalRatingData, MagnetReviewSectionModel.reviewSection(items: items)] )
                completion?()
                return
            }
            
            let photoItems = items.filter { item in
                return item.photoUrl != nil
            }
            
            self.dataObservable.accept( [totalRatingData, MagnetReviewSectionModel.reviewSection(items: photoItems)] )
            completion?()
        }
        
        func sortLatest(a: ReviewItem, b: ReviewItem) -> Bool {
            return a.createAt > b.createAt
        }
        
        func sortHighRating(a: ReviewItem, b: ReviewItem) -> Bool {
            return a.rating > b.rating
        }
        
        func sortLowRating(a: ReviewItem, b: ReviewItem) -> Bool {
            return a.rating < b.rating
        }
    }
    
}
