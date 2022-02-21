//
//  ViewController.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/11.
//

import UIKit

class MainVC: UIViewController {
        
    private var userModel = LoginUserModel()
    @IBOutlet weak var sideBarMenuButton: UIBarButtonItem!
    @IBOutlet weak var greetingMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func makeSideBarMenuButtonUI() {
        if (self.userModel.isLogin) {
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (checkLogin()) {
            makeSideBarMenuButtonUI()
            self.greetingMessage.text = "\(userModel.user!.data.name)님 반갑습니다!"
        }
    }
    
    func checkLogin() -> Bool {
        if (self.userModel.isLogin == false) {
            let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginPageVC
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    @IBAction func handleLogoutButton(_ sender: UIButton) {
        self.userModel.logOut()
        let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginPageVC
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
}
