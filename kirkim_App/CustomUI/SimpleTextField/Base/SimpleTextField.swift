//
//  MyTextField.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/15.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SimpleTextField: UITextField {
    private var textType: TextFieldType = .normal
    private let underLine = UIView()
    private var viewModel: SimpleTextFieldViewModel?
    private let disposeBag = DisposeBag()
    
    //MARK: - init function
    init(type: TextFieldType?, maxLength: Int = 16) {
        viewModel = SimpleTextFieldViewModel(maxLength: maxLength)
        super.init(frame: CGRect.zero)
        self.textType = type ?? .normal
        attribute()
        layout()
        bind(viewModel!)
    }
    
    //이 클래스는 frame을 지정해줘도 의미가 없도록 구현, frame을 입력해도 커스텀 init함수를 호출하도록함
    override init(frame: CGRect) {
        self.init()
    }
    
    //coder용 자식클래스를 위해 만든 init함수
    init?(coder: NSCoder, type: TextFieldType?, maxLength: Int = 6) {
        viewModel = SimpleTextFieldViewModel(maxLength: maxLength)
        super.init(coder: coder)
        self.textType = type ?? .normal
        attribute()
        layout()
        bind(viewModel!)
    }
    
    //SimpleTextField 자체로는 coder로 생성 불가
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - bind function
    func bind(_ viewModel: SimpleTextFieldViewModel) {
        self.rx.text.orEmpty
            .bind(to: viewModel.text)
            .disposed(by: disposeBag)
        
        viewModel.isEditable
            .emit { value in
                if !value {
                    self.text = String(self.text?.dropLast() ?? "")
                }
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - attribute, layout function
    private func attribute() {
        self.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.textColor = UIColor.black
        self.borderStyle = .none
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        
        underLine.backgroundColor = UIColor.brown
        
        switch self.textType {
        case .normal:
            break
        case .password:
            self.isSecureTextEntry = true
        }
    }
    
    private func layout() {
        self.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(2)
            $0.height.equalTo(2)
        }
    }
}
