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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pink: UIColor = UIColor(red: 205/255, green: 99/255, blue: 69/255, alpha: 1.0)
        
        let orange: UIColor = UIColor(red: 192/255, green: 51/255, blue: 98/255, alpha: 1.0)
        
        setGradientBackground(colorTop: orange, colorBottom: pink)
        if Auth.auth().currentUser != nil{
            print("eh diff de nil")
            print(Auth.auth().currentUser?.email)
            print(Auth.auth().currentUser?.displayName)
            
        }
        
        
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

        print("tapped")
        do{
            try Auth.auth().signOut()
            let loginManager = LoginManager()
            loginManager.logOut()
            self.dismiss(animated: true, completion: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.chooseStoryboardToOpen()
            print("button acionado")
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
