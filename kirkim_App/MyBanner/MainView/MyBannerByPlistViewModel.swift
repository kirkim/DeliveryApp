//
//  MyBannerByPlistViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/11.
//

import UIKit

struct MyBannerByPlistViewModel {
    enum BannerType {
        case staticEvent
    }
    private var manager: MyBannerViewByPlistManager
    init(type: BannerType) {
        manager = MyBannerViewByPlistManager(type: .staticEvent)
    }
    
    // 배너이미지 갯수를 반환
    func getCount() -> Int {
        return manager.getCount()
    }
    
    func getSmallImageByIndex(index: Int) -> UIImage {
        return manager.getSmallImageByIndex(index: index)
    }
}

class MyBannerViewByPlistManager {
    private var contents: [BannerPlistContent] = []
    
    init(type: MyBannerByPlistViewModel.BannerType) {
        self.contents = getContents(type: type)
    }
    
    private func getContents(type: MyBannerByPlistViewModel.BannerType) -> [BannerPlistContent] {
        switch type {
        case .staticEvent:
            guard let path = Bundle.main.path(forResource: StaticEventContent.plistName, ofType: "plist"),
                  let data = FileManager.default.contents(atPath: path),
                  let list = try? PropertyListDecoder().decode([StaticEventContent].self, from: data)
            else { return [] }
            return list
        }
    }
    
    func getCount() -> Int {
        return self.contents.count
    }
    
    func getSmallImageByIndex(index: Int) -> UIImage {
        guard index <= contents.count else { return UIImage() }
        let image = self.contents[index].smllImage

        return image
    }
}

