//
//  MainBeminSubView.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/07.
//

import UIKit

class MainBeminSubVC: UIViewController {

    @IBOutlet weak var stackView_1: UIStackView!
    @IBOutlet weak var view_2: UIView!
    @IBOutlet weak var stackView_3: UIStackView!
    @IBOutlet weak var view_4: UIView!
    @IBOutlet weak var stackView_5: UIStackView!
    @IBOutlet weak var view_6: UIView!
    @IBOutlet weak var stackView_7: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setView()
    }
    
    private func setView() {
        setStackView_1()
    }
    
    private func setStackView_1() {
        stackView_1.alignment = .center
        stackView_1.distribution = .fillProportionally
        stackView_1.spacing = 5

        let view1 = FirstBeminCell()
        let view2 = FirstBeminCell()
        [view1, view2].forEach {
            stackView_1.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
    }
}

//SwiftUI를 활용한 미리보기
import SwiftUI

struct MainBeminSubVC_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = MainBeminSubVC()
            return vc
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        typealias UIViewControllerType = UIViewController
    }
}
