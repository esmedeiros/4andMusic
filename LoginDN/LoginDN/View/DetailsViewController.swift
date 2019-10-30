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
        
        guard let news = newsURL, let url = URL(string: news) else {
            AlertController.showAlert(self, title: "Error", message: "Não foi possível abrir a notícia")
            return
        }
        detailsWebKit.load(URLRequest(url: url))
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = detailsWebKit.title
    }
}
