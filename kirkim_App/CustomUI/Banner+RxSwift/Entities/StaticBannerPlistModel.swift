//
//  PlistManager.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/22.
//

import UIKit
import RxSwift
import RxCocoa

struct StaticBannerPlistModel {
    enum BannerType {
        case staticEvent
    }
    private var contents: [BannerContent] = []
    
    init(type: BannerType) {
        self.contents = getContents(type: type)
    }
    
    private func getContents(type: StaticBannerPlistModel.BannerType) -> [BannerContent] {
        switch type {
        case .staticEvent:
            guard let path = Bundle.main.path(forResource: StaticBannerContent.plistName, ofType: "plist"),
                  let data = FileManager.default.contents(atPath: path),
                  let list = try? PropertyListDecoder().decode([StaticBannerContent].self, from: data)
            else { return [] }
            return list
        }
    }
    
    func getCount() -> Int {
        return self.contents.count
    }

    func getSmallImageByIndex(index: Int) -> UIImage {
        guard index <= contents.count else { return UIImage() }
        let image = self.contents[index].smallImage

        return image
    }
    
    func getAllImageName() -> [String] {
        return contents.map { content in
            return content.smallImageName ?? ""
        }
    }
}
