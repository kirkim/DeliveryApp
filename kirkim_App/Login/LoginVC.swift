//
//  Login.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/14.
//

import UIKit

class LoginVC:UIViewController {
    
    @IBOutlet weak var textFieldID: MyTextField!
    @IBOutlet weak var textFieldPW: MyTextField!
    var myHttpDelegate: HttpDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    private func initUI() {
        textFieldID.setUI()
        textFieldPW.setUI()
        textFieldPW.isSecureTextEntry = true
    }
    
    @IBAction func handleLoginButton(_ sender: UIButton) {
        guard let userID = textFieldID.text,
              let password = textFieldPW.text
        else { return }
        let httpClient = HttpClient()
        let user = User(userID: userID, password: password)
        
        httpClient.fetch(httpAction: .postLogin, body: user, completion: { data in
            guard let data = data as? Data else {
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(UserDataMaster.self, from: data)
                self.myHttpDelegate?.getUserModelDelegate(user: dataModel)
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
