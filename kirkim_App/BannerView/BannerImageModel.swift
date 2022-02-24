//
//  BannerImageModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/23.
//
import UIKit

struct Banner: Codable {
    let imageUrl: String
    let index: Int
}

struct BannerBundle: Codable {
    let bannersCount: Int
    let banners: [Banner]
    let updatedAt: String
}

struct BannerImageModel {
    private let manager = BannerImageManager.shared
    
    func getCount() -> Int {
        return manager.getCount()
    }
    
    func getImageByIndex(index: Int) -> UIImage {
        return manager.getImageByIndex(index: index)
    }
    
    func update(completion: @escaping () -> Void) {
        return manager.update(completion: completion)
    }
}

class BannerImageManager {
    static let shared = BannerImageManager()
    private let httpManager = BannerHttpManager()
    private init() { }
    private var bannerBundle: BannerBundle?
    private var bannerImages: [UIImage] = []
    
    func update(completion: @escaping () -> Void) {
        self.updateBannerBundle(completion: {
            let totalSize = self.getCount()
            self.bannerImages = [UIImage](repeating: UIImage(), count: totalSize)
            self.updateBannerImage(size: totalSize)
            completion()
        })
    }
    
    private func updateBannerBundle(completion: @escaping () -> Void) {
        httpManager.getFetch(type: .getBanner, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let dataModel = try JSONDecoder().decode(BannerBundle.self, from: data)
                    self.bannerBundle = dataModel
                    completion()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func updateBannerImage(size: Int) {
        guard let banners = self.bannerBundle?.banners else { return }
        let totalCount: Int = size
        var count: Int = 0
        while(count < totalCount) {
            var run = false
            self.httpManager.getFetch(type: .image(urlString: banners[count].imageUrl), completion: {
                result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    guard let image = UIImage(data: data) else { break }
                    self.bannerImages[count] = image
                    run = true
                }
            })
            while !run {
            }
            count += 1
        }
        print("cnt: ", count)
        print("images: ", self.bannerImages)
    }
    
//    private let images: [String] = ["1.png", "2.png", "3.png", "4.png"]
    func getCount() -> Int {
        return self.bannerBundle?.bannersCount ?? 0
    }
    
    func getImageByIndex(index: Int) -> UIImage {
//        guard let image = UIImage(named: self.images[index]) else { return UIImage() }
        return self.bannerImages[index]
    }
}
