//
//  signUpPageVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import UIKit

class SignUpPageVC: UIViewController {

    @IBOutlet weak var idTextField: MyTextField!
    @IBOutlet weak var passwordTextField: MyTextField!
    @IBOutlet weak var confirmPasswordTextField: MyTextField!
    @IBOutlet weak var nameTextField: MyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
    }
    
    private func initUI() {
        idTextField.setUI(type: .normal)
        passwordTextField.setUI(type: .password)
        confirmPasswordTextField.setUI(type: .password)
        nameTextField.setUI(type: .normal)
    }
    
    @IBAction func handleJoinButton(_ sender: UIButton) {
        guard let userID = idTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              let name = nameTextField.text else { return }
        let httpClient = HttpClient()
    
        if (checkUserData(userID, password, confirmPassword, name) != .success) { return }
        
        let userData = UserData(userID: userID, password: password, name: name)
        httpClient.fetch(httpAction: .postSignUp, body: userData, completion: { _ in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    private func checkUserData(_ userID: String, _ password: String, _ confirmPassword: String, _ name: String) -> UserManager.ValidatorResult {
        let originalUserData = OriginalUserData(userID: userID, password: password, confirmPassword: confirmPassword, name: name)
        let validatorResult = UserManager.shared.validator(originalUserData: originalUserData)
        var message: String = ""
        
        if (validatorResult != .success ) {
            switch validatorResult {
            case .wrongID:
                TextAnimation.shakeTextFiled(textField: self.idTextField, count: 2, withDuration: 0.1, withWidth: 10)
                message = "유효한 아이디를 입력해주세요"
            case .wrongPW:
                TextAnimation.shakeTextFiled(textField: self.passwordTextField, count: 2, withDuration: 0.1, withWidth: 10)
                message = "유효한 비밀번호를 입력해주세요"
            case .wrongConfimPW:
                TextAnimation.shakeTextFiled(textField: self.passwordTextField, count: 2, withDuration: 0.1, withWidth: 10)
                TextAnimation.shakeTextFiled(textField: self.confirmPasswordTextField, count: 2, withDuration: 0.1, withWidth: 10)
                message = "동일한 비밀번호를 입력해주세요"
            default:
                message = ""
            }
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        return validatorResult
    }
}
