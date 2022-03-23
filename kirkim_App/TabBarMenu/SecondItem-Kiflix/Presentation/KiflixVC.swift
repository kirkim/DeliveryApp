//
//  KiflixVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/01.
//

import UIKit

class KiflixVC: BaseVC {
    let kiflixModel = KiflixViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: KiflixCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.setCollectionViewUI(itemSpacing: 7, margin: 3)
    }
}

//MARK: - KiflixVC: UISearchBarDelegate
extension KiflixVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        collectionView.update(text: searchText)
    }
}

//MARK: - UICollectionViewDelegate
extension KiflixVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.kiflixModel.data[indexPath.row]
        let detailVC = KiflixDetailVC(movieData: data)
        self.present(detailVC, animated: true, completion: nil)
    }
}
