//
//  StaticSectionModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/10.
//

import UIKit
import RxCocoa

struct StaticSectionModel {
    let deliveryListViewModel = DeliveryMenuViewModel()
    let itemSelected = PublishRelay<IndexPath>()
    let presentVC: Driver<UIViewController>
    let bannerSource: BannerSources
    
    init() {
        presentVC = itemSelected
            .map { indexPath in
                var startPage: Int {
                    switch indexPath.section {
                    case 0:
                        switch indexPath.row {
                        case 0:
                            return 0
                        default:
                            return 1
                        }
                    case 1:
                        return 2
                    case 2:
                        switch indexPath.row {
                        case 0:
                            return 3
                        default:
                            return 4
                        }
                    case 3:
                        return 5
                    case 4:
                        switch indexPath.row {
                        case 0:
                            return 6
                        case 1:
                            return 7
                        default:
                            return 8
                        }
                    default:
                        return 0
                    }
                }
                let vc = TopBarVCWithProfile(startPage: startPage)
                return vc
            }
            .asDriver(onErrorJustReturn: UIViewController())
        let BASE_URL = "https://kirkim.com/banner"
        bannerSource = BannerSources(
            bannerType: .event,
            title: "이벤트",
            subTitle: "지금 진행 중!",
            totalViewCellRatio: 0.5,
            sources: [
                BannerSource(bannerImage: BeminCellImage.urlImage(url: "\(BASE_URL)/1.png"), totalViewCellImage: BeminCellImage.urlImage(url: "\(BASE_URL)/1.png"), presentVC: EventPage1()),
                BannerSource(bannerImage: BeminCellImage.urlImage(url: "\(BASE_URL)/4.png"), totalViewCellImage: BeminCellImage.urlImage(url: "\(BASE_URL)/4.png"), presentVC: EventPage1()),
                BannerSource(bannerImage: BeminCellImage.urlImage(url: "\(BASE_URL)/2.png"), totalViewCellImage: BeminCellImage.urlImage(url: "\(BASE_URL)/2.png"), presentVC: EventPage1()),
                BannerSource(bannerImage: BeminCellImage.urlImage(url: "\(BASE_URL)/3.png"), totalViewCellImage: BeminCellImage.urlImage(url: "\(BASE_URL)/3.png"), presentVC: EventPage1()),
                BannerSource(bannerImage: BeminCellImage.urlImage(url: "\(BASE_URL)/4.png"), totalViewCellImage: BeminCellImage.urlImage(url: "\(BASE_URL)/4.png"), presentVC: EventPage1()),
            ])
    }
}
