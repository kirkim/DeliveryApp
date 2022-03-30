//
//  TestVC.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxSignUpPageVC: UIViewController {
    private let titleLabel = UILabel()
    private let idView = IdZone()
    private let pwView = PasswordZone()
    private let nameView = NameZone()
    private let joinButton = JoinButton()
    private let disposeBag = DisposeBag()

    //MARK: - init function
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - bind function
    func bind(_ viewModel: RxSignUpPageViewModel) {
        let idZoneViewModel = viewModel.idZoneViewModel
        let joinButtonModel = viewModel.joinButtonModel
        self.idView.bind(idZoneViewModel)
        self.pwView.bind(viewModel.pwZoneViewModel)
        self.nameView.bind(viewModel.nameZoneViewModel)
        self.joinButton.bind(joinButtonModel)
        
        viewModel.presentAlert
            .subscribe(onNext: { [weak self] message in
                let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        joinButtonModel.presentSucceedAlert
            .subscribe(onNext: { [weak self] message in
                let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: {_ in 
                    self?.dismiss(animated: true)
                })
                alert.addAction(action)
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        self.view.backgroundColor = .white
        
        titleLabel.text = "회원가입"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
    
    private func layout() {
        let SIDE_MARGIN = 20
        let SUBCOMPONENT_SPACE = 20

        [titleLabel, idView, pwView, nameView, joinButton].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        idView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SUBCOMPONENT_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        pwView.snp.makeConstraints {
            $0.top.equalTo(idView.snp.bottom).offset(SUBCOMPONENT_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(pwView.snp.bottom).offset(SUBCOMPONENT_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
        }

        joinButton.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(SUBCOMPONENT_SPACE)
            $0.leading.equalToSuperview().offset(SIDE_MARGIN)
            $0.trailing.equalToSuperview().inset(SIDE_MARGIN)
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
