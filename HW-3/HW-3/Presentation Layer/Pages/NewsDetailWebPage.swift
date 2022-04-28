//
//  NewsDetailWebPage.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/28/22.
//

import UIKit
import WebKit


class NewsDetailWebPage: UIViewController {
    
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        configureUI()
    }
    
    private func layoutUI() {
        title = "News Detail"
        view.addSubview(webView)
        
        configureNavBar()
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
}
