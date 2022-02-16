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
        
        if (password != confirmPassword) {
            print("패스워드가 다르다")
            return
        }
        
        let userData = UserData(userID: userID, password: password, name: name)
        
        httpClient.fetch(httpAction: .postSignUp, body: userData, completion: { data in
            guard let data = data as? Data else {
                return
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}
