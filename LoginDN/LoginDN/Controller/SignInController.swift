//
//  SignInController.swift
//  LoginDN
//
//  Created by Alexandre Aun on 23/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit



class SignInController{
    
    func getSignin(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func getSigninFaceBook(completion: @escaping (Bool) ->Void){
        guard let curr = AccessToken.current else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: curr.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
               completion(false)
                return
            } else {
                print("------ Usuário autenticado com sucesso!!!!")
                completion(true)
            }
        }
    }
}
