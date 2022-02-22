//
//  SideBarMenuVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/21.
//

import UIKit

class SideMenuVC: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    private let sideMenuCellModel = SideMenuCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self
        self.navigationItem.title = ""
        menuTableView.register(SideMenuHeaderView.self, forHeaderFooterViewReuseIdentifier: SideMenuHeaderView.identifier)
        registerCell()
        let nib = UINib(nibName: "TestView1-1", bundle: nil)
        self.menuTableView.register(nib, forCellReuseIdentifier: "TestView1-1")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellInfo = sideMenuCellModel.getCellInfoByIndexPath(indexPath: indexPath)
        let vc = UIViewController(nibName: cellInfo.identifier, bundle: nil)
        vc.navigationItem.title = cellInfo.mainTitle
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
