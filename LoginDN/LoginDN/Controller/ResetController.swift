//
//  ResetController.swift
//  LoginDN
//
//  Created by Alexandre Aun on 23/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import Firebase

class ResetController{
    
    func resetPassword(email: String, completion: @escaping (Bool) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil{
                completion(true)
                return
            }else{
                completion(false)
                return
            }
        }
    }
    
    func teste() {
        print("Nadilson")
    }
}
