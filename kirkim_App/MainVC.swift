//
//  ViewController.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/11.
//

import UIKit

class MainVC: UIViewController {
        
    private var userModel = UserModel()
    @IBOutlet weak var greetingMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    func checkLogin() {
        if (self.userModel.isLogin == false) {
            let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginPageVC
            loginVC.myHttpDelegate = self
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        } else {
            return
        }
    }
    @IBAction func handleLogoutButton(_ sender: UIButton) {
        self.userModel.logOut()
        let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginPageVC
        loginVC.myHttpDelegate = self
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
}

//MARK: - HttpDelegate
extension MainVC: HttpDelegate{
    func getUserByLogin(user: UserDataMaster) {
        self.userModel.setUser(user: user)
        DispatchQueue.main.async {
            self.greetingMessage.text = "\(user.data.name)님 반갑습니다!"
        }
    }
}
