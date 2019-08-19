//
//  ResetPasswordViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 12/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var buttonReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        
    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
    
        resetpassword()
        
    }
    
    
    func resetPassword(email: String, OnSucess: @escaping() -> Void, onError: @escaping(_ erroMessage: String) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil{
                AlertController.showAlert(self, title: "Congratulations!!!", message: "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password")
            }else{
                AlertController.showAlert(self, title: "Attention!!!", message: "Please enter an email valid")
            }
        }
        
    }
    
    
    func resetpassword(){
        
        guard let email = emailTextField.text, email != "" else{
            AlertController.showAlert(self, title: "Attention!!!", message: "Please enter an email")
            return
        }
        resetPassword(email: email, OnSucess: {
            return
        }, onError: { (errorMessage) in
            return
        })
        
    }
    
    @IBAction func backSignIn(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
    
    }
}

extension ResetPasswordViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text! == "" {
            return false
        } else if textField == emailTextField {
            textField.resignFirstResponder()
              resetpassword()
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
