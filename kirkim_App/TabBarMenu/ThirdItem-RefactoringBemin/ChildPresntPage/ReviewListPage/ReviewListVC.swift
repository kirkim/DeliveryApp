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

class ReviewListVC: UIViewController {
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    private let disposeBag = DisposeBag()
    private let viewModel = ReviewListViewModel()
    private let pickerSortTypeView = PickSortTypeView()
    
    init() {
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

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        let dataSource = viewModel.dataSource()
        viewModel.data
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        self.title = "\(viewModel.storeName) 리뷰"
        self.tableView.delegate = self
        let cellNib = UINib(nibName: "ReviewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ReviewCell")
    }

    private func layout() {
        [tableView, pickerSortTypeView].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ReviewListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let header = tableView.dequeueReusableHeaderFooterView(ReviewHeaderView.self)
//            header?.bind(viewModel.headerViewModel)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 1) {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
