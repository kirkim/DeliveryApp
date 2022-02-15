//
//  ViewController.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/11.
//

import UIKit

class ViewController: UIViewController {
    private var isLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    func checkLogin() {
        if (self.isLogin == false) {
            let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        } else {
            return
        }
    }


}

