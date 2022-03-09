//
//  BeminCollectionVC.swift
//  Bemin_0307
//
//  Created by 김기림 on 2022/03/09.
//

import UIKit

class BeminCollectionVC: UICollectionViewController {
    private static let STATIC_COUNT = StaticCollection.Section.allCases.count
    init() {
        super.init(collectionViewLayout: BeminCollectionVC.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if (sectionNumber < STATIC_COUNT) {
                return StaticCollection.staticSectionLayout(sectionNumber: sectionNumber)
            } else {
                return StaticCollection.mainSection()
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BeminCollectionVC.STATIC_COUNT
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section < BeminCollectionVC.STATIC_COUNT) {
            return StaticCollection.numberOfStaticItem(section: section)
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.title = "xxxx xxxx"
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}


import SwiftUI

struct BeminCollectionVC_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: BeminCollectionVC())
        }
        typealias UIViewControllerType = UIViewController
    }
}
