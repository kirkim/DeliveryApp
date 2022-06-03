//
//  ReviewListModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit
import RxSwift
import RxCocoa



class BasicReviewModel {
    private let disposeBag = DisposeBag()
    private let httpManager = BasicReviewHttpManager.shared
    private var reviewImageStorage: [String : UIImage] = [:]
    private let cellDatas = PublishRelay<[ReviewSectionModel]>()
    
    //
    private var totalReviewCount: Int = 0
    
    init(id: String) {
        updata(id: id)
    }
    
    func updata(id: String, completion: (() -> ())? = nil) {
        httpManager.load(id: id) { [weak self] items in
            let sectionDatas = ReviewSectionModel(items: items)
            self?.cellDatas.accept([sectionDatas])
            self?.totalReviewCount = items.count
            guard let completion = completion else {
                return
            }
            completion()
        }
    }
    
    // Public function
    func getCellDatas() -> Driver<[ReviewSectionModel]> {
        return self.cellDatas.share().asDriver(onErrorJustReturn: [])
    }
    
    func getTotalReviewCount() -> Int {
        return self.totalReviewCount
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
    
}
