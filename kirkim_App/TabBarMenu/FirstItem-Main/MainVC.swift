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
        self.bannerView.delegate = self
    }
    
    @IBAction func handleRefreshButton(_ sender: Any) {
        self.bannerView.refresh()
    }
    @IBAction func sdf(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - MainVC MyBannerViewDelegate, MyBannerViewDataSource
extension MainVC: MyBannerViewDelegate {
    func handleBannerControlButton() {
        print("click!!")
    }
}
