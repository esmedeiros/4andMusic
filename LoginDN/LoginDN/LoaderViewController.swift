//
//  LoaderViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 14/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import Lottie


class LoaderViewController: UIViewController {
    
    
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimating()
        
            
    }
    
    
    func startAnimating(){

        animationView.animation =  Animation.named("loader")
        animationView.contentMode = .scaleAspectFit

        animationView.loopMode = .loop
        animationView.play()
    }
}
