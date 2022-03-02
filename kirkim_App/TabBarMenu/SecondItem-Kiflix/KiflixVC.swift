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
        let detailVC = KiflixDetailVC(nibName: "KiflixDetailVC", bundle: nil)
        print(detailVC)
        self.present(detailVC, animated: true, completion: nil)
    }
}

////MARK: - UICollectionViewDelegateFlowLayout
//extension KiflixVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let spacing: CGFloat = 8
//        let margin: CGFloat = 8
//        let width: CGFloat = (self.collectionView.frame.width - (spacing * 2) - (margin * 2)) / 3
//        let height: CGFloat = width * (10/7)
//        return CGSize(width: width, height: height)
//    }
//        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
