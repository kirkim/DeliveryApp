//
//  SideBarMenuVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit
import RxSwift

class SideMenuVC: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    private let user = MainUser()
    private let sideMenuCellModel = SideMenuCellModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self
        self.navigationItem.title = ""
        menuTableView.register(SideMenuHeaderView.self, forHeaderFooterViewReuseIdentifier: SideMenuHeaderView.identifier)
        menuTableView.register(SideMenuFooterView.self, forHeaderFooterViewReuseIdentifier: SideMenuFooterView.identifier)
        registerCell()
        
    }
    
    private func registerCell() {
        for cell in sideMenuCellModel.getAllCells() {
            guard let id = cell.identifier else { return }
            let nib = UINib(nibName: id, bundle: nil)
            self.menuTableView.register(nib, forCellReuseIdentifier: id)
        }
    }
    
    @IBAction func handleCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuCellModel.getSectionCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuCellModel.getCellsBySection(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sideMenuCellModel.getCellByIndexPath(indexPath: indexPath)
    }
}

//MARK: - UITableViewDelegate
extension SideMenuVC: UITableViewDelegate {
    //MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SideMenuHeaderView.identifier)
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
        if (section == sideMenuCellModel.getSectionCount()-1) {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SideMenuFooterView.identifier) as! SideMenuFooterView
            footer.logoutButtonTapped
                .subscribe(onNext: {
                    self.user.logOut()
                    self.dismiss(animated: false, completion: nil)
                })
                .disposed(by: disposeBag)
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == sideMenuCellModel.getSectionCount()-1) {
            return SideMenuSize.headerHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellInfo = sideMenuCellModel.getCellInfoByIndexPath(indexPath: indexPath)
        let vc = UIViewController(nibName: cellInfo.identifier, bundle: nil)
        vc.navigationItem.title = cellInfo.mainTitle
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
