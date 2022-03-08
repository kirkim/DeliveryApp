//
//  BeminVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/07.
//

import UIKit
import SwiftUI
import SnapKit

class BeminVC: BaseVC {

    @IBOutlet weak var contentStackView: UIStackView! {
        didSet {
            addContentsView()
            let view1 = UIView()
            view1.translatesAutoresizingMaskIntoConstraints = false
            view1.heightAnchor.constraint(equalToConstant: 400).isActive = true
            view1.backgroundColor = .red
            
            let view2 = UIView()
            view2.translatesAutoresizingMaskIntoConstraints = false
            view2.heightAnchor.constraint(equalToConstant: 400).isActive = true
            view2.backgroundColor = .orange
            
            let view3 = UIView()
            view3.translatesAutoresizingMaskIntoConstraints = false
            view3.heightAnchor.constraint(equalToConstant: 400).isActive = true
            view3.backgroundColor = .blue
            
            [view1, view2, view3].forEach {
                contentStackView.addArrangedSubview($0)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func addContentsView() {
        let vc = MainBeminSubVC(nibName: "MainBeminSubVC", bundle: nil)
        addChild(vc)
        contentStackView.addArrangedSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height)
            $0.width.equalToSuperview()
        }
    }
}

struct BeminVC_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Container().edgesIgnoringSafeArea(.all)
        }
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let beminVC = BeminVC()
            beminVC.dev_Mode = true
            return UINavigationController(rootViewController: beminVC)
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        typealias UIViewControllerType = UIViewController
    }
}
