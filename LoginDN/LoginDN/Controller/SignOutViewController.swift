//
//  SignOutViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 07/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage

class SignOutViewController: BaseViewController {
    
    @IBOutlet weak var userNameTextField: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    let colors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colorTop: colors.orange, colorBottom: colors.pink)
        
        guard let username = Auth.auth().currentUser?.displayName, !username.isEmpty else {
            let name = UserDefaults.standard.object(forKey: "username") as? String
            userNameTextField.text = name
            return
        }
        
        if let usernameImg = Auth.auth().currentUser?.photoURL {
            profileImage.sd_setImage(with: Auth.auth().currentUser?.photoURL, completed: nil)
        }
        userNameTextField.text = username
    }
    
    @IBAction func signOutTappedNews(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let loginManager = LoginManager()
            loginManager.logOut()
            self.dismiss(animated: true, completion: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.chooseStoryboardToOpen()
        }catch{
            print(error)
            
        }
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
