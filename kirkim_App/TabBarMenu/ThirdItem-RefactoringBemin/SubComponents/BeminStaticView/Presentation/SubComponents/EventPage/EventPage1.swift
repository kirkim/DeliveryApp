//
//  EventPage1.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/23.
//

import UIKit

class EventPage1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

import SwiftUI

struct EventPage1_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: EventPage1())
        }
        typealias UIViewControllerType = UIViewController
    }
}
