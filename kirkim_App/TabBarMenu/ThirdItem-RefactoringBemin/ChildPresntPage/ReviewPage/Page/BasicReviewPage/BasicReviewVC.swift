//
//  ReviewListVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/05/22.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources
import RxCocoa

enum BasicReviewType {
    case me(userInfo: UserInfo)
    case other(userInfo: UserInfo)
    var id: String {
        switch self {
        case .me(let info):
            return info.id
        case .other(let info):
            return info.id
        }
    }
}

class BasicReviewVC: UIViewController {
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let disposeBag = DisposeBag()
    private let viewModel: BasicReviewViewModel
    private let type: BasicReviewType
    
    init(type: BasicReviewType) {
        viewModel = BasicReviewViewModel(id: type.id)
        self.type = type
        super.init(nibName: nil, bundle: nil)
        self.attribute()
        self.layout()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        let navigationBarAppearace = UINavigationBarAppearance()
        navigationBarAppearace.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearace
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearace
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        let dataSource = viewModel.dataSource()
        viewModel.getDataObservable()
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        switch self.type {
        case .me(userInfo: _):
            self.title = "리뷰관리"
        case .other(let info):
            self.title = "\(info.name)님의 리뷰"
        }
        self.view.backgroundColor = .white
        self.tableView.delegate = self
        let cellNib = UINib(nibName: "ReviewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ReviewCell")
        tableView.register(headerFooterViewType: ReviewByMeHeaderView.self)
        tableView.register(headerFooterViewType: ReviewByOtherHeaderView.self)
        
        self.tableView.sectionHeaderTopPadding = 10
    }

    private func layout() {
        [tableView].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension BasicReviewVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch self.type {
        case .me(_):
            let header =  tableView.dequeueReusableHeaderFooterView(ReviewByMeHeaderView.self)
            header?.setData(totalCount: viewModel.getTotalReviewsCount())
            return header
        case .other(let info):
            let header = tableView.dequeueReusableHeaderFooterView(ReviewByOtherHeaderView.self)
            header?.setData(totalCount: viewModel.getTotalReviewsCount(), name: info.name)
            return header
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
