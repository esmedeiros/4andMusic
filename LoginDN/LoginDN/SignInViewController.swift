//
//  SignInViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 07/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var logginFBButton: FBLoginButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.emailTF.text = "euclides.sena@hotmail.com"
        self.passwordTF.text = "12345678"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
     
        
        loading.isHidden = true
        loading.stopAnimating()
        emailTF.delegate = self
        passwordTF.delegate = self
        logginFBButton.delegate = self
    }
    
    deinit {

        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    @objc func keyboardWillChange (notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue) ")
        
        view.frame.origin.y = -300
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        emailTF.text = ""
//        passwordTF.text = ""
     
    }
    
    func performSignIn(){
        guard let email = emailTF.text,
            email != "",
            let password = passwordTF.text,
            password != ""
            else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all required fields")
                return
                
        }
        self.showLoadingAnimation()
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
               self.hiddenLoadingAnimation()
                return
            }
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
        }
        
    }
    @IBAction func singInTapped(_ sender: Any) {
        
        
        performSignIn()
        view.frame.origin.y = 0
    }
}


extension SignInViewController: LoginButtonDelegate {

    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loginButtonDidLogOut")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        
        guard let curr = AccessToken.current else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: curr.tokenString)
        
        print("------------------------------------ \(credential) ")
        self.showLoadingAnimation()
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                self.hiddenLoadingAnimation()
                return
            } else {
                print("------ Usuário autenticado com sucesso!!!!")
                self.showLoadingAnimation()
                
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }
    }
    
    
}
extension SignInViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         if textField.text! == "" {
            return false
        } else if textField == emailTF {
            textField.resignFirstResponder()
            passwordTF.becomeFirstResponder()
            return true
        } else if textField == passwordTF {
            textField.resignFirstResponder()
            view.frame.origin.y = 0
            performSignIn()
            return true
        }else {
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        view.frame.origin.y = 0
    }
}
