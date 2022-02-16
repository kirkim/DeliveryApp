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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
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
    
    @IBAction func seeAllUsers__Dev(_ sender: UIButton) {
        print("seeAllUsers__Dev called! ------")
        let httpClient = HttpClient()
        httpClient.fetch(httpAction: .getUsers__Dev, body: nil, completion: { data in
            print(data)
            guard let data = data as? Data else { return }
            do {
                let dataModel = try JSONDecoder().decode([UserDataMaster].self, from: data)
                print(dataModel)
            } catch {
                print(error)
            }
            
        })
    }
}

//MARK: -
extension LoginPageVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("화면이 터치 됐다")
        UIView.transition(with: self.view, duration: 1, options: .autoreverse, animations: {
            self.view.endEditing(true)
        }, completion: nil)
        return true
    }
}
