//
//  Login.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/14.
//

import UIKit

class LoginPageVC: UIViewController {
    
    @IBOutlet weak var idTextField: MyTextField!
    @IBOutlet weak var passwordTextField: MyTextField!
    var myHttpDelegate: HttpDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    private func initUI() {
        idTextField.setUI(type: .normal)
        passwordTextField.setUI(type: .password)
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func handleLoginButton(_ sender: UIButton) {
        guard let userID = idTextField.text,
              let password = passwordTextField.text else { return }
        let httpClient = HttpClient()
        let user = User(userID: userID, password: password)
        
        httpClient.fetch(httpAction: .postLogin, body: user, completion: { data in
            guard let data = data as? Data else {
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(UserDataMaster.self, from: data)
                self.myHttpDelegate?.getUserByLogin(user: dataModel)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                print(dataModel)
            } catch {
                print(error)
            }
        })
    }
}
