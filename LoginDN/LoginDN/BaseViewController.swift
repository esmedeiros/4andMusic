//
//  BaseViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 20/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import FSnapChatLoading

class BaseViewController: UIViewController {
    


    let loadingView = FSnapChatLoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func hiddenLoadingAnimation() {
        
        loadingView.hide()
    
    }
    
    func showLoadingAnimation() {
        
        loadingView.show(view: self.view, color: UIColor(red: 192.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0))
                
    }

}
