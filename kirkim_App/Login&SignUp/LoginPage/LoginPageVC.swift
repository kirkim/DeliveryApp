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
    private let titleLabel = UILabel()
    private let basicLoginView = BasicLoginView()
    private let viewModel = LoginPageViewModel() // 로그인 페이지는 어느 페이지에서나 열릴 수 있기 때문에 viewModel을 직접 가지고 있는다
    private let createButton = CreateUserButton()
    
    private let disposeBag = DisposeBag()
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        attribute()
        bind(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func bind(_ viewModel: LoginPageViewModel) {
        let createUserButtonViewModel = viewModel.createUserButtonViewModel
        self.basicLoginView.bind(viewModel.basicLoginViewModel)
        self.createButton.bind(createUserButtonViewModel)
        
        createUserButtonViewModel.presentVC
            .emit { [weak self] createVC in
                self?.navigationController?.pushViewController(createVC, animated: true)
                self?.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: disposeBag)
        
        viewModel.clickedLoginButton
            .emit(onNext: { [weak self] isLoginSucceed in
                switch isLoginSucceed {
                case .success:
                    self?.dismiss(animated: true)
                case .fail(message: let message):
                    let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
        
        titleLabel.text = "로그인"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        createButton.setTitle(" 회원가입 → ", for: .normal)
        createButton.setTitleColor(.brown, for: .normal)
        createButton.clipsToBounds = true
        createButton.layer.cornerRadius = 5
    }
    
    private func layout() {
        [titleLabel, basicLoginView, createButton].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        basicLoginView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        createButton.snp.makeConstraints {
            $0.top.equalTo(basicLoginView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
}
