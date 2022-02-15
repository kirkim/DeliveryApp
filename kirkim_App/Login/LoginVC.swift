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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldID.setUI()
        textFieldPW.setUI()
    }
}
