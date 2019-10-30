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
    }
    
    func hiddenLoadingAnimation() {
        loadingView.hide()    
    }
    
    func showLoadingAnimation() {
        loadingView.show(view: self.view, color: .orange)
    }

    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
