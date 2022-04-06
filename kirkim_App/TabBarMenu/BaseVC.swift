//
//  BaseVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class BaseVC: UIViewController {
    let userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func makeSideBarMenuButtonUI() {
        let userName = self.userModel.info?.data.name ?? "User"
        let customButton = SimpleProfileView(userName: userName)
        customButton.addTarget(self, action: #selector(handleSideBarMenuButton), for: .touchUpInside)
        let sideBarMenuButton = UIBarButtonItem(customView: customButton)
        self.navigationItem.rightBarButtonItem = sideBarMenuButton
    }
    
    @objc private func handleSideBarMenuButton() {
        let sideBarMenuNavi = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuNavi")
        sideBarMenuNavi.modalPresentationStyle = .fullScreen
        self.present(sideBarMenuNavi, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin(completion: {
            makeSideBarMenuButtonUI()
            self.navigationItem.title = "\(userModel.info!.data.name)님 반갑습니다!"
        })
    }
    
    func checkLogin(completion: () -> Void) {
        if (self.userModel.isLogin == false) {
            let loginVC = LoginPageVC()
            let nav = UINavigationController(rootViewController: loginVC)
            loginVC.title = "로그인"
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
        } else {
            completion()
        }
    }
}
