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
        let httpClient = HttpClient()
    
        if (checkUserData(userID, password, confirmPassword, name) != .success) { return }
        
        let userData = UserData(userID: userID, password: password, name: name)
        httpClient.fetch(httpAction: .postSignUp, body: userData, completion: { _ in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    // TODO: MVVM패턴 적용을 위해 뷰모델에서 처리하도록 만들자 [before]
    // 새로운 유저아이디를 생성하기 전에 유효한 값인지 체크하는 메서드
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
