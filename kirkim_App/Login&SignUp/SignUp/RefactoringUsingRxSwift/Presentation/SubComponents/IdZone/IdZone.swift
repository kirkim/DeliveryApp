//
//  IdTextZone.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class IdZone: UIView {
    private let idTextField = SimpleTextField(type: .normal)
    private let idErrorMessage = SignUpErrorLabel()
    private let checkIdButton = ChekcIdButton()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - init function
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - bind function
    func bind(_ viewModel: IdZoneViewModel) {
        let checkIdButtonViewModel = viewModel.checkIdButtonViewModel
        self.checkIdButton.bind(checkIdButtonViewModel)
        let idTextObservable = idTextField.rx.text.orEmpty.share()
        
        idTextObservable
            .bind(to: viewModel.idText)
            .disposed(by: disposeBag)
        
        viewModel.isValidId
            .emit { isValid in
                self.checkIdButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)
        
        Signal.combineLatest(
            viewModel.isValidId,
            viewModel.isValid) { [weak self] validId, checkId -> Bool in
                if (validId && checkId) {
                    return true
                } else if (!validId) {
                    self?.idErrorMessage.text = "유효한 아이디를 입력해 주세요"
                    return false
                } else {
                    self?.idErrorMessage.text = "아이디 중복체크를 해주세요"
                    return false
                }
            }
            .emit { [weak self] isValid in
                self?.idErrorMessage.isHidden = isValid
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        idErrorMessage.text = "유효한 아이디를 입력해 주세요"
        self.idTextField.placeholder = "ID"
    }
    
    private func layout() {
        [idTextField, idErrorMessage, checkIdButton].forEach {
            self.addSubview($0)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        idErrorMessage.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        checkIdButton.snp.makeConstraints {
            $0.top.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField).multipliedBy(0.9)
        }

        self.snp.makeConstraints {
            $0.bottom.equalTo(idErrorMessage.snp.bottom)
        }
    }
}
