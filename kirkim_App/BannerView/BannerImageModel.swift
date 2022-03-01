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
    private var bannerImages: [UIImage]?
    
    func update(completion: @escaping () -> Void) {
        self.updateBannerBundle(completion: {
            let totalCount = self.getCount()
            Task {
                await self.updateBannerImageAsync(totalCount: totalCount)
                completion()
            }
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
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func saveImage(result: Result<Data, CustomError>, index: Int) {
        switch result {
        case .failure(let error):
            print(error)
        case .success(let data):
            guard let image = UIImage(data: data) else { break }
            self.bannerImages?[index] = image
        }
    }
    
    private func updateBannerImageAsync(totalCount: Int) async {
        self.bannerImages = Array.init(repeating: UIImage(), count: totalCount)
        guard let banners = self.bannerBundle?.banners else { return }
        await self.httpManager.getFetchAsync(type: .image(urlString: banners[0].imageUrl), completion: { result in
            self.saveImage(result: result, index: 0)
        })
        for i in 1..<totalCount {
            self.httpManager.getFetch(type: .image(urlString: banners[i].imageUrl), completion: { result in
                self.saveImage(result: result, index: i)
            })
        }
    }
    
    func getCount() -> Int {
        return self.bannerBundle?.bannersCount ?? 0
    }
    
    func getImageByIndex(index: Int) -> UIImage {
        guard let images = self.bannerImages else { return UIImage() } // 로딩이 안됐을 때 이미지를 리턴해주면 될듯
        return images[index]
    }
}
