//
//  ViewController.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/11.
//

import UIKit

class MainVC: UIViewController {
        
    private var userModel = LoginUserModel.shared
    
    // 베너뷰 추가
    private var bannerView:BannerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.bannerView = BannerView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 260))
            self.view.addSubview(self.bannerView!)
        }
    }
    
    private func makeSideBarMenuButtonUI() {
        let userName = self.userModel.user?.data.name ?? "User"
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
//        checkLogin(completion: {
//            makeSideBarMenuButtonUI()
//            self.navigationItem.title = "\(userModel.user!.data.name)님 반갑습니다!"
//        })
    }
    
    func checkLogin(completion: () -> Void) {
        if (self.userModel.isLogin == false) {
            let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginPageVC
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
        } else {
            completion()
        }
    }
    
    // TODO: sidebar클래스로 옮겨야됨 [ ]
    @IBAction func handleLogoutButton(_ sender: UIButton) {
        self.userModel.logOut()
        let loginVC = UIStoryboard(name: "LoginPage", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginPageVC
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
}
