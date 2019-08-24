//
//  SignUpController.swift
//  LoginDN
//
//  Created by Alexandre Aun on 23/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import Firebase


class SignUpController{
    
    let signUpController = SignInController()

    
    func getSignUp(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                completion(false)
                return
            }
            completion(true)
        }
    }
}
