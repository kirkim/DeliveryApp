//
//  MagnetReviewView.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/18.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources
import RxCocoa

class MagnetReviewVC: UIViewController {
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    private let disposeBag = DisposeBag()
    private let row: Int?
    private let viewModel = MagnetReviewViewModel()
    private let pickerSortTypeView = PickSortTypeView()
    
    private let PICKERVIEW_HEIGHT = 200.0
    private let tapBackgroundView = UIButton()
    
    init(row: Int?) {
        self.row = row
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (row != nil) {
            self.tableView.scrollToRow(at: IndexPath(row: row!, section: 1), at: .top, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        pickerSortTypeView.bind(viewModel.pickSortTypeViewModel)
        let dataSource = viewModel.dataSource()
        viewModel.getStoreNameObservable()
            .map { storeName -> String in
                return "\(storeName) 리뷰"
            }
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.getDataObservable()
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.movingSortTypeView
            .bind { isPop in
                if (isPop == true) {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.pickerSortTypeView.frame.origin.y = self.view.frame.height - self.PICKERVIEW_HEIGHT
                    }, completion: { _ in
                        self.tapBackgroundView.isHidden = false
                    })
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.tapBackgroundView.isHidden = true
                        self.pickerSortTypeView.frame.origin.y = self.view.frame.height
                    }, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        
        tapBackgroundView.rx.tap
            .bind {
                UIView.animate(withDuration: 0.5, animations: {
                    self.tapBackgroundView.isHidden = true
                    self.pickerSortTypeView.frame.origin.y = self.view.frame.height
                }, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.presentUserReviewList
            .emit(onNext: { userInfo in
                let basicReviewVC = BasicReviewVC(type: .other(userInfo: userInfo))
                self.navigationController?.pushViewController(basicReviewVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
//        self.title = "\(viewModel.getStoreName()) 리뷰"
        self.tableView.delegate = self
        let cellNib = UINib(nibName: "MagnetReviewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "MagnetReviewCell")
        let noImageCellNib = UINib(nibName: "MagnetReviewNoImageCell", bundle: nil)
        tableView.register(noImageCellNib, forCellReuseIdentifier: "MagnetReviewNoImageCell")
        tableView.register(headerFooterViewType: MagnetReviewHeaderCell.self)
        tableView.register(cellType: MagnetReviewTotalRatingCell.self)
        
        self.tapBackgroundView.isHidden = true
        self.tapBackgroundView.backgroundColor = .clear
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        DispatchQueue.global().async {
            self.viewModel.update {
                sleep(1) // 임시로 지연시간 1초 주기
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }

    private func layout() {
        [tableView, pickerSortTypeView, tapBackgroundView].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pickerSortTypeView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: PICKERVIEW_HEIGHT)
        
        tapBackgroundView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-PICKERVIEW_HEIGHT)
    }
}

extension MagnetReviewVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 1) {
            let header = tableView.dequeueReusableHeaderFooterView(MagnetReviewHeaderCell.self)
            header?.bind(viewModel.headerViewModel)
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
        if (indexPath.section == 0) {
            return 100
        } else {
            return 500
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 100
        } else {
            return UITableView.automaticDimension
        }
    }
}
