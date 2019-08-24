//
//  ResetPasswordViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 12/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var buttonReset: UIButton!
    
    let resetController = ResetController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
    }
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        resetpassword()
    }
    
    
    func resetpassword(){
        guard let email = emailTextField.text, email != "" else{
            AlertController.showAlert(self, title: "Attention!!!", message: "Please enter an email")
            return
        }
        self.showLoadingAnimation()
        
        resetController.resetPassword(email: email) { (success) in
            if success{
                AlertController.showAlert(self, title: "Congratulations!!!", message: "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password")
                self.hiddenLoadingAnimation()
            }else{
                AlertController.showAlert(self, title: "Attention!!!", message: "Please enter an email valid")
                self.hiddenLoadingAnimation()
            }
        }
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
