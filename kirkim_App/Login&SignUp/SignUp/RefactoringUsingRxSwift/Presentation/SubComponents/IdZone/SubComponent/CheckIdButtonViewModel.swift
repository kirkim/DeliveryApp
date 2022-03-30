//
//  CheckIdButtonViewModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/29.
//

import Foundation
import RxSwift
import RxCocoa

class CheckIdButtonViewModel {
    let disposeBag = DisposeBag()
    let httpManager = RxUserHttpManager()
    //View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    let checkValue = PublishRelay<String>()
    
    //ViewModel -> View
    let presentAlert = PublishRelay<String>()
    let isValidButton = PublishRelay<Bool>()
    private var currentId = "" // 단순히 id에 커서가 올려갔을때 Join버튼이 비활성화 되는 것을 방지하기 위함
    
    init() {
        let idValue = checkValue.share()
        
        buttonTapped
            .withLatestFrom(idValue) { $1 }
            .bind(onNext: self.checkId)
            .disposed(by: disposeBag)
        
        // 아래처럼 weak self 처리를 해줘야할 필요가 있음
        idValue
            .bind { [weak self] value in
                if (value.lowercased() != self?.currentId) {
                    self?.isValidButton.accept(false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func checkId(id: String) {
        guard id != "" else {
            self.presentAlert.accept("아이디를 입력하세요.")
            self.isValidButton.accept(false)
            return
        }
        let id = id.lowercased()
        self.currentId = id
        httpManager.checkUserId(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                switch result {
                case .success(let data):
                    do {
                        let json = try JSONDecoder().decode(Bool.self, from: data)
                        let message = json ? "사용가능한 아이디 입니다." : "이미 있는 아이디 입니다."
                        self.isValidButton.accept(json)
                        self.presentAlert.accept(message)
                    } catch {
                        print("catch error: ", error.localizedDescription)
                        self.presentAlert.accept("catch error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("fail error: ", error.localizedDescription)
                    self.presentAlert.accept("fail error: \(error.localizedDescription)")
                }
            } onFailure: { error in
                self.presentAlert.accept("fail!")
            } onDisposed: {
                print("disposed!")
            }
            .disposed(by: disposeBag)
    }
}
