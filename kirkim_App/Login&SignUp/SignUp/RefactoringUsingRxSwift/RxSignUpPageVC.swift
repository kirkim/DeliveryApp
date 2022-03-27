//
//  RxSwignUpPageVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxSignUpPageVC: UIViewController {
    // UI
    let titleLabel = UILabel()
    let idTextField = SimpleTextField(type: .normal)
    let idErrorMessage = UILabel()
    let checkIdButton = UIButton(type: .system)
    let pwTextField = SimpleTextField(type: .password)
    let pwErrorMessage = UILabel()
    let confirmPwTextField = SimpleTextField(type: .password)
    let confirmPwErrorMessage = UILabel()
    let nameTextField = SimpleTextField(type: .normal)
    let nameErrorMessage = UILabel()
    let joinButton = UIButton(type: .system)
    // RxCocoa
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        attribute()
        bind(RxSignUpPageViewModel())
        initKeyboardEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - bind function
    
    func bind(_ viewModel: RxSignUpPageViewModel) {
        idTextField.rx.text.orEmpty
            .bind(to: viewModel.idText)
            .disposed(by: disposeBag)

        pwTextField.rx.text.orEmpty
            .bind(to: viewModel.pwText)
            .disposed(by: disposeBag)
        
        confirmPwTextField.rx.text.orEmpty
            .bind(to: viewModel.confirmPwText)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.nameText)
            .disposed(by: disposeBag)
        
        checkIdButton.rx.tap
            .bind { self.test() }
            .disposed(by: disposeBag)
        
        viewModel.isValidId
            .bind {
                self.idErrorMessage.isHidden = $0
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidPw
            .bind {
                self.pwErrorMessage.isHidden = $0
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidConfimPw
            .bind {
                self.confirmPwErrorMessage.isHidden = $0
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidName
            .bind {
                self.nameErrorMessage.isHidden = $0
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidSignUp
            .bind {
                self.joinButton.isEnabled = $0
            }
            .disposed(by: disposeBag)
    }
    
    func test() {
        print("click!")
        idTextField.snp.makeConstraints {
            $0.top.equalTo(20)
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: - attribute()
    private func attribute() {
        self.view.backgroundColor = .white
        
        //MARK: Simple layout
        titleLabel.text = "회원가입"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        idTextField.placeholder = "ID"
        
        checkIdButton.setTitle(" 중복확인 ", for: .normal)
        checkIdButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        checkIdButton.tintColor = .white
        checkIdButton.layer.cornerRadius = 5
        checkIdButton.backgroundColor = .brown
        
        pwTextField.placeholder = "비밀번호"
        
        confirmPwTextField.placeholder = "비밀번호 확인"
        
        nameTextField.placeholder = "이름"
        
        joinButton.setTitle("JOIN", for: .normal)
        joinButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        joinButton.isEnabled = false
        
        //MARK: Error massage layout
        [idErrorMessage, pwErrorMessage, confirmPwErrorMessage, nameErrorMessage].forEach {
            $0.textColor = .systemRed
            $0.font = .systemFont(ofSize: 13, weight: .light)
        }
        idErrorMessage.text = "유효한 아이디를 입력해 주세요"
        pwErrorMessage.text = "유효한 비밀번호를 입력해 주세요"
        confirmPwErrorMessage.text = "유효한 확인비밀버호를 입력해 주세요"
        nameErrorMessage.text = "유효한 이름을 입력해 주세요"
    }
    
    //MARK: - layout
    private func layout() {
        let SIDE_MARGIN = 20
        let LINE_SPACE = 30
        
        //MARK: Simple layout
        [titleLabel, idTextField, checkIdButton, pwTextField, confirmPwTextField, nameTextField, joinButton].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(LINE_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        checkIdButton.snp.makeConstraints {
            $0.top.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField).multipliedBy(0.9)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(LINE_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        confirmPwTextField.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(LINE_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(confirmPwTextField.snp.bottom).offset(LINE_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(LINE_SPACE)
            $0.centerX.equalToSuperview()
        }
        
        //MARK: Error massage layout
        [idErrorMessage, pwErrorMessage, confirmPwErrorMessage, nameErrorMessage].forEach {
            self.view.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(SIDE_MARGIN)
                $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
            }
        }
        
        idErrorMessage.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(5)
        }
        
        pwErrorMessage.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(5)
        }
        
        confirmPwErrorMessage.snp.makeConstraints {
            $0.top.equalTo(confirmPwTextField.snp.bottom).offset(3)
        }
        
        nameErrorMessage.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(3)
        }

    }
}

//MARK: - RxSignUpPageVC: UITextFieldDelegate + 키보드에 따른 텍스트필드 위치조정 메서드
extension RxSignUpPageVC {
    func initKeyboardEvent() {
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func showKeyBoard(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let correctHeight = UIScreen.main.bounds.height - keyboardFrame.height - joinButton.frame.origin.y - joinButton.frame.height
        if noti.name == UIResponder.keyboardWillShowNotification {
            if (correctHeight < 0) {
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.view.window?.frame.origin.y = correctHeight
                }, completion: nil)
            }
        }
    }
    @objc func hideKeyBoard() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.window?.frame.origin.y = 0
        }, completion: nil)
    }
}
