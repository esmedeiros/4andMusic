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

class SignUpViewController: BaseViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
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
        
        
//        let ref = Database.database().reference()
//
//        let postObject = ["username": userNameTextField.text ?? "",
//                          "email": emailTextField.text ?? ""]
//
//        ref.child("user/profile").child(userNameTextField.text ?? "").setValue(postObject) { (erro, ref) in
//            if erro == nil{
//                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
//            }else{
//                print("Deu ruim")
//            }
//        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                self.hiddenLoadingAnimation()
                return
        }
            //print(Auth.auth().currentUser?.displayName)
            self.performSegue(withIdentifier: "signUpSegue", sender: nil)
        }
    }
    
    @IBAction func registerBtTapped(_ sender: Any) {
        performSignUp()
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
