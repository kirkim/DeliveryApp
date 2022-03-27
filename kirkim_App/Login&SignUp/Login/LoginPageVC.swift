//
//  LoginPageVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginPageVC: UIViewController {
    let titleLabel = UILabel()
    let idTextField = SimpleTextField(type: .normal)
    let idErrorLabel = UILabel()
    let passwordTextField = SimpleTextField(type: .password)
    let pwErrorLabel = UILabel()
    let loginButton = UIButton()
    let createButton = UIButton()
    private let loginUserModel = MainUser()
    private let disposeBag = DisposeBag()
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        attribute()
        bind(LoginPageViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: LoginPageViewModel) {
        self.idTextField.rx.text
            .bind(to: viewModel.idText)
            .disposed(by: disposeBag)
        
        self.passwordTextField.rx.text
            .bind(to: viewModel.pwText)
            .disposed(by: disposeBag)
        
        viewModel.isValidId
            .emit(onNext: {
                self.idErrorLabel.isHidden = $0
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidPw
            .emit(onNext: {
                self.pwErrorLabel.isHidden = $0
            })
            .disposed(by: disposeBag)
        
        self.loginButton.rx.tap
            .withLatestFrom(viewModel.isValidLogin) { $1 }  // 백엔드에서도 유효성검사를 하지만, 앱에서도 유효성검사를 한번 더해줌 => 불필요한 네트워크통신을 막음
            .bind { isValidLogin in
                if (isValidLogin) {
                    self.handleLoginButton() // 이 곳에서 백엔드에 통신하며 유효성검사를 하게됨
                }
            }
            .disposed(by: disposeBag)
        
        self.createButton.rx.tap
            .bind { self.handleCreateUserButton() }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        passwordTextField.isSecureTextEntry = true
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
        
        titleLabel.text = "로그인"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        idTextField.placeholder = "아이디"
        passwordTextField.placeholder = "비밀번호"
        
        idErrorLabel.text = "아이디를 입력하세요"
        pwErrorLabel.text = "비밀번호를 입력하세요"
        [idErrorLabel, pwErrorLabel].forEach {
            $0.textColor = .systemRed
            $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        }
        
        loginButton.setTitle(" 로그인 ", for: .normal)
        loginButton.backgroundColor = .brown
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5
        
        createButton.setTitle(" 회원가입 → ", for: .normal)
        createButton.setTitleColor(.brown, for: .normal)
        createButton.clipsToBounds = true
        createButton.layer.cornerRadius = 5
    }
    
    private func layout() {
        [
            titleLabel,
            idTextField, idErrorLabel,
            passwordTextField, pwErrorLabel,
            loginButton,
            createButton
        ].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        idErrorLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idErrorLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        pwErrorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwErrorLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(60)
        }
        
        createButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }
    }
    
    //MARK: - @IBAction function
    private func handleLoginButton() {
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
        
    private func handleCreateUserButton() {
        let vc = SignUpPageVC(nibName: "SignUpPageVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
}
