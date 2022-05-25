//
//  SideBarMenuVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture

class SideMenuVC: UIViewController {
    private let backbuttonLabel = UILabel()
    private let menuTableView = UITableView(frame: CGRect.zero, style: .plain)
    
    private let user = UserModel()
    private let viewModel = SideMenuViewModel()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        layout()
        attribute()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        self.backbuttonLabel.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.presentDetailProfileVC
            .emit(onNext: {
                let detailProfileVC = DetailProfileVC()
                self.navigationController?.pushViewController(detailProfileVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.logoutButtonTapped
            .emit(onNext: {
                self.user.logOut()
                self.dismiss(animated: false, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.copyrightButtonTapped
            .emit(onNext: {
                let directorBlogPage = DirectorBlogWebkitView()
                self.navigationController?.pushViewController(directorBlogPage, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.navigationItem.title = ""
        self.view.backgroundColor = .systemGray
        self.menuTableView.backgroundColor = .clear
        
        // backbutton UI
        self.backbuttonLabel.text = "X"
        self.backbuttonLabel.font = .systemFont(ofSize: 25, weight: .bold)
        let backbuttonContainer = UIBarButtonItem(customView: backbuttonLabel)
        self.navigationItem.leftBarButtonItem = backbuttonContainer
        
        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self
        self.menuTableView.rowHeight = 60
        menuTableView.register(headerFooterViewType: SideMenuHeaderView.self)
        menuTableView.register(SideMenuFooterView.self, forHeaderFooterViewReuseIdentifier: SideMenuFooterView.identifier)
        registerCell()
    }
    
    private func registerCell() {
//        for cell in viewModel.getAllCells() {
//            switch cell.uiType {
//            case .xib:
//                guard let id = cell.identifier else { return }
//                let nib = UINib(nibName: id, bundle: nil)
//                self.menuTableView.register(nib, forCellReuseIdentifier: id)
//            case .onlyCode(let className):
//                guard let id = cell.identifier else { return }
//                self.menuTableView.register(className.self, forCellReuseIdentifier: id)
//            }
//        }
    }
    
    private func layout() {
        [menuTableView].forEach {
            self.view.addSubview($0)
        }
        
        menuTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellsBySection(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCellByIndexPath(indexPath: indexPath)
    }
}

//MARK: - UITableViewDelegate
extension SideMenuVC: UITableViewDelegate {
    //MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let header = tableView.dequeueReusableHeaderFooterView(SideMenuHeaderView.self)
            header?.bind(viewModel.headerViewModel)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return SideMenuSize.headerHeight
        }
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == viewModel.getSectionCount()-1) {
            let footer = tableView.dequeueReusableHeaderFooterView(SideMenuFooterView.self)
            footer?.bind(viewModel.footerViewModel)
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == viewModel.getSectionCount()-1) {
            return SideMenuSize.headerHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellInfo = viewModel.getCellInfoByIndexPath(indexPath: indexPath)
        var vc: UIViewController?
        switch cellInfo.uiType {
        case .xib:
            vc = UIViewController(nibName: cellInfo.identifier, bundle: nil)
        case .onlyCode(className: let className):
            vc = className
        }
        guard let vc = vc else {
            return
        }
        vc.navigationItem.title = cellInfo.mainTitle
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
