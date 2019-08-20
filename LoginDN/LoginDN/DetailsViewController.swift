//
//  DetailsViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 20/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var detailsWebKit: WKWebView!
        
    var newsURL: String?
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let url = URL(string: newsURL ?? "")!
        detailsWebKit.load(URLRequest(url: url))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: detailsWebKit, action: #selector(detailsWebKit.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
    }
    

    override func loadView() {
        detailsWebKit = WKWebView()
        detailsWebKit.navigationDelegate = self
        view = detailsWebKit
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = detailsWebKit.title
    }

    
    
}
