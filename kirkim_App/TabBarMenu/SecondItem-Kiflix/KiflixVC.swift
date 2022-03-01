//
//  KiflixVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class KiflixVC: BaseVC {
    let kiflixModel = KiflixModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: KiflixCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}

//MARK: - KiflixVC: UISearchBarDelegate
extension KiflixVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        collectionView.update(text: searchText)
    }
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else { return }
//        collectionView.update(text: text)
//    }
}
