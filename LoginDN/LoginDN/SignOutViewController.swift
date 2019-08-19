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

class SignOutViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil{
            print("eh diff de nil")
            print(Auth.auth().currentUser?.email)
            print(Auth.auth().currentUser?.displayName)
            
        }
        guard let username = Auth.auth().currentUser?.displayName else {return}

        userNameTextField.text = "Hello: \(username)"
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
  
        do{
            try Auth.auth().signOut()
            let loginManager = LoginManager()
            loginManager.logOut()
            self.dismiss(animated: true, completion: nil)
//            performSegue(withIdentifier: "signOutSegue", sender: nil)
        }catch{
            print(error)
        }
    }
}
