//
//  MyBannerViewDelegate.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/08.
//

import Foundation

protocol MyBannerViewDelegate {
    func handleBannerControlButton()
    func didSelectedBannerView(indexPath: IndexPath)
}
