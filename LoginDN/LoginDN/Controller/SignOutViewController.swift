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
        setupView()
    }
    
    func setupView() {
        setGradientBackground(colorTop: .orange, colorBottom: .pink)
        guard let username = Auth.auth().currentUser?.displayName, !username.isEmpty else {
            let name = UserDefaults.standard.object(forKey: "username") as? String
            userNameTextField.text = name
            return
        }
        
        if (Auth.auth().currentUser?.photoURL) != nil {
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
            AlertController.showAlert(self, title: "Error", message: "Não foi possivel realizar o Logout")
        }
    }    
}
