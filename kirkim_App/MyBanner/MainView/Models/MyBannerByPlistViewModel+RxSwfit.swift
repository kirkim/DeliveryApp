//
//  MyBannerByPlistUsingRxSWiftViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa

struct MyBannerViewModel_RxSwfit {
    enum BannerType {
        case staticEvent
    }
    
    private var manager: MyBannerViewManager_RxSwfit
    init(type: BannerType) {
        manager = MyBannerViewManager_RxSwfit(type: .staticEvent)
    }
    
    // 배너이미지 갯수를 반환
    func getCount() -> Int {
        return manager.getCount()
    }
    
    func getSmallImageByIndex(index: Int) -> UIImage {
        return manager.getSmallImageByIndex(index: index)
    }
}

struct MyBannerViewManager_RxSwfit {
    private var contents: [BannerPlistContent] = []
    let shouldLoadResult: Observable<String>
    
    init(type: MyBannerByPlistViewModel.BannerType) {
        self.contents = getContents(type: type)
        self.shouldLoadResult =
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
