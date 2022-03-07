//
//  TestVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/07.
//

import UIKit

class TestVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = MainBeminSubVC(nibName: "MainBeminSubVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
