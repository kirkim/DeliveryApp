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
    private let httpManager = MagnetReviewHttpManager.shared
    private var reviewImageStorage: [String : UIImage] = [:]
    let storeName: String
    
    init() {
        storeName = httpManager.storeName
    }
    
    func makeReviewImage(index: Int, url: String?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        
        if (reviewImageStorage[url] != nil) {
            return reviewImageStorage[url]!
        } else {
            let imageUrl = URL(string: url)
            let data = try? Data(contentsOf: imageUrl!)
            let image = UIImage(data: data!)
            if let image = image { self.reviewImageStorage.updateValue(image, forKey: url) }
            return image ?? UIImage()
        }
    }
    
    func getData(hasPhoto: Bool, sortType: ReViewSortType) -> [MagnetReviewSectionModel] {
        guard let totalRatingData = self.httpManager.totalRatingData,
              let reviewData = self.httpManager.reviewData else { return [] }
        var items = (reviewData.items as! [ReviewItem])
        
        items.sort(by: sortLatest(a:b:))
        switch sortType {
        case .latestOrder:
            break;
        case .highStarRating:
            items.sort(by: self.sortHighRating(a:b:))
        case .lowStarRating:
            items.sort(by: self.sortLowRating(a:b:))
        }
        
        guard hasPhoto == true else { return [totalRatingData, MagnetReviewSectionModel.reviewSection(items: items)] }
        
        let photoItems = items.filter { item in
            return item.photoUrl != nil
        }
        
        return [totalRatingData, MagnetReviewSectionModel.reviewSection(items: photoItems)]
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
