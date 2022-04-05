//
//  RxBannerViewDelegate.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/04.
//

import Foundation

protocol RxBannerViewDelegate {
    func handleBannerControlButton()
    func didSelectedBannerView(indexPath: IndexPath)
}
