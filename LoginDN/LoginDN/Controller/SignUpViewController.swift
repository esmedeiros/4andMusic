//
//  ViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 07/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        
        self.hiddenLoadingAnimation()
    }
    
    private func configureTextFields(){
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    

    
    
    func performSignUp(){
        
        self.showLoadingAnimation()
        
        guard let username = userNameTextField.text,
            username != "",
            let email = emailTextField.text,
            email != "",
            let password = passwordTextField.text,
            password != ""
            else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all fields")
                self.hiddenLoadingAnimation()
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                self.hiddenLoadingAnimation()
                return
            }
          
            UserDefaults.standard.set(username, forKey: "username")
        
            self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            
        }
    }
    
    @IBAction func registerBtTapped(_ sender: Any) {
        performSignUp()

        UNUserNotificationCenter.current().requestAuthorization(options: options) { (didAllow, error) in
            if error != nil{
                print("Notificação Negada")
            }else{
                print("Notificação Autorizada")
            }
        }
        
    }
    
    
    @IBAction func backSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text! == "" {
            return false
        } else if textField == userNameTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            return true
        } else if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField == passwordTextField{
            textField.resignFirstResponder()
            performSignUp()
            return true
        }else {
            return false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
}
