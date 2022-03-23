//
//  signUpPageVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import UIKit

class SignUpPageVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var idTextField: SimpleTextField!
    @IBOutlet weak var passwordTextField: SimpleTextField!
    @IBOutlet weak var confirmPasswordTextField: SimpleTextField!
    @IBOutlet weak var nameTextField: SimpleTextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    private var constant: CGFloat = 0
    private var activeTextfieldY: CGFloat = 0
    private let signupUserModel = SignUpPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
        initUI()
        idTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nameTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func initUI() {
        idTextField.setUI(type: .normal)
        passwordTextField.setUI(type: .password)
        confirmPasswordTextField.setUI(type: .password)
        nameTextField.setUI(type: .normal)
        UIView.animate(withDuration: 0.5) {
            self.contentView.layoutIfNeeded()
        }
        self.constant = bottomConstraint.constant
    }

    @IBAction func handleJoinButton(_ sender: UIButton) {
        guard let userID = idTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              let name = nameTextField.text else { return }
        
        let userData = SignupUser(userID: userID, password: password, confirmPassword: confirmPassword, name: name)
        
        signupUserModel.signup(signupData: userData, completion: { validatorResult in
            if (validatorResult != .success ) {
                switch validatorResult {
                case .wrongID:
                    TextAnimation.shakeTextFiled(textField: self.idTextField, count: 2, withDuration: 0.1, withWidth: 10)
                case .wrongPW:
                    TextAnimation.shakeTextFiled(textField: self.passwordTextField, count: 2, withDuration: 0.1, withWidth: 10)
                case .wrongConfimPW:
                    TextAnimation.shakeTextFiled(textField: self.passwordTextField, count: 2, withDuration: 0.1, withWidth: 10)
                    TextAnimation.shakeTextFiled(textField: self.confirmPasswordTextField, count: 2, withDuration: 0.1, withWidth: 10)
                case .wrongName:
                    TextAnimation.shakeTextFiled(textField: self.nameTextField, count: 2, withDuration: 0.1, withWidth: 10)
                default:
                    break
                }
                let alert = UIAlertController(title: nil, message: validatorResult.message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}

// SignUpPageVC: UITextFieldDelegate + 키보드에 따른 텍스트필드 위치조정 메서드
extension SignUpPageVC: UITextFieldDelegate {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let adjustmentHeight = keyboardFrame.height - self.activeTextfieldY
        if noti.name == UIResponder.keyboardWillShowNotification {
            bottomConstraint.constant = adjustmentHeight
        } else {
            bottomConstraint.constant = self.constant
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // when user select a textfield, this method will be called
     func textFieldDidBeginEditing(_ textField: UITextField) {
       // set the activeTextField to the selected textfield
         switch textField {
         case self.idTextField:
             self.activeTextfieldY = 100
         case self.passwordTextField:
             self.activeTextfieldY = 80
         case self.confirmPasswordTextField:
             self.activeTextfieldY = 60
         case self.nameTextField:
             self.activeTextfieldY = 40
         default:
             self.activeTextfieldY = 0
         }
     }
       
     // when user click 'done' or dismiss the keyboard
     func textFieldDidEndEditing(_ textField: UITextField) {
         self.activeTextfieldY = 0
     }
}
