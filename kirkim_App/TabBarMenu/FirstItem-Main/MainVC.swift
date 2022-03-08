//
//  MainVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit
import SnapKit

class MainVC: BaseVC {
    
    @IBOutlet weak var bannerView: MyBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - MainVC MyBannerViewDelegate, MyBannerViewDataSource
extension MainVC: MyBannerViewDelegate {
    func handleBannerControlButton() {
        print("click!!")
    }
}
