//
//  MagnetInfoCollectionModel.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/18.
//

import UIKit
import RxCocoa
import RxSwift

class MagnetSummaryReviewModel {
    let data = PublishRelay<[SummaryReviewData?]>()

    private let httpManager = DeliveryHttpManager.shared
    private let storeHttpManager = HttpModel.shared
    private let disposeBag = DisposeBag()
    private var summaryReviewImageStorage: [Int : UIImage] = [:]
    var dataCount: Int?
    
    init() {
        httpManager.getFetch(type: .summaryReviews(storeCode: storeHttpManager.getStoreCode(), count: 3))
            .subscribe { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode([ReviewItem].self, from: data)
                        var summaryReviews: [SummaryReviewData?] = []
                        dataModel.forEach { item in
                            let summaryReview = SummaryReviewData(thumbnail: item.photoUrl ?? "", review: item.description, rating: item.rating)
                            summaryReviews.append(summaryReview)
                        }
                        summaryReviews.append(nil)
                        self?.dataCount = summaryReviews.count - 1
                        self?.data.accept(summaryReviews)
                    } catch {
                        print("decoding error: ", error.localizedDescription)
                    }
                case .failure(let error):
                    print("fail: ", error.localizedDescription)
                }
            } onFailure: { error in
                print("error: ", error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func setData(coView: UICollectionView) {
        self.data
            .bind(to: coView.rx.items) { collectionView, row, data in
                if (row == self.dataCount ?? 0) {
                    let cell = collectionView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: MagnetInfoMoreButtonCell.self)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: MagnetInfoReviewCell.self)
                    guard let data = data else { return cell }
                    cell.setData(data: data, image: self.makeSummryReviewImage(index: row, url: data.thumbnail))
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }

    private func makeSummryReviewImage(index: Int, url: String) -> UIImage {
        if (summaryReviewImageStorage[index] != nil) {
            return summaryReviewImageStorage[index]!
        } else {
            let url = URL(string: url)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            if let image = image { self.summaryReviewImageStorage.updateValue(image, forKey: index) }
            return image ?? UIImage()
        }
    }
}
