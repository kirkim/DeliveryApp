//
//  DirectorBlogWebkit.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/04/06.
//

import UIKit
import SnapKit
import WebKit

class DirectorBlogWebkitView: UIViewController {
    let webView = WKWebView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigationBarAppearace = UINavigationBarAppearance()
        navigationBarAppearace.backgroundColor = .systemGray4
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearace
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearace
        self.navigationController?.navigationBar.compactAppearance = navigationBarAppearace
    }
    
    private func attribute() {
        self.title = "Kirkim 기술블로그"
        let request = URLRequest(url: URL(string: "https://kirkim.github.io/")!)
        webView.load(request)
        
        
    }
    
    private func layout() {
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
