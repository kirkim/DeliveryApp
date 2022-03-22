//
//  TotalButtonViewModel.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

struct RxBannerButtonViewModel {
    let buttonTapped = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    let nowPage: BehaviorSubject<Int>
    let totalPage: Int
    
    var title: Observable<String> {
        return nowPage
            .map { page in
                return "\(page + 1) / \(self.totalPage) 모두보기"
            }
    }
    
    init(bannerPageSubject nowPage: BehaviorSubject<Int>, totalPage: Int) {
        self.nowPage = nowPage
        self.totalPage = totalPage
    }
    
    func buttonTap(_ viewController: UIViewController) {
        let vc = TextVC()
        viewController.present(vc, animated: true)
    }
    
}
