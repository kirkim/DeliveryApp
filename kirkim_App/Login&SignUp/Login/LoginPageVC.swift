//
//  Login.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/14.
//

import UIKit

class LoginPageVC: UIViewController {
    
    @IBOutlet weak var idTextField: SimpleTextField!
    @IBOutlet weak var passwordTextField: SimpleTextField!
    private let loginUserModel = LoginUserModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
    }

    private func initUI() {
        idTextField.setUI(type: .normal)
        passwordTextField.setUI(type: .password)
        passwordTextField.isSecureTextEntry = true
    }
    
    //MARK: - @IBAction function
    @IBAction func handleLoginButton(_ sender: UIButton) {
        guard let userID = idTextField.text,
              let password = passwordTextField.text else { return }
        loginUserModel.logIn(userID: userID, password: password, completion: { loginStatus in
            DispatchQueue.main.async {
                switch loginStatus {
                case .success:
                    self.dismiss(animated: true, completion: nil)
                case .fail:
                    let alert = UIAlertController(title: nil, message: loginStatus.message, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func seeAllUsers__Dev(_ sender: UIButton) {
        print("seeAllUsers__Dev called! ------")
        let httpClient = UserHttpManager()
        httpClient.getFetch(type: .usersData__Dev, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let dataModel = try JSONDecoder().decode([User].self, from: data)
                    print(dataModel)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
