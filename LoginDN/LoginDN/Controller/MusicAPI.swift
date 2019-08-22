//
//  MusicAPI.swift
//  LoginDN
//
//  Created by Mac Pro on 16/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import Alamofire

class MusicAPI{
    
    func getMusic(resultRequest: @escaping (_ result:[Music]?, _ erro: NSError?) -> Void) -> Void{
        
        let url = "https://api.vagalume.com.br/hotspots.php?apikey=660a4395f992ff67786584e238f501aa"
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.response?.statusCode == 200{
                print("Legal, API consumida!!! \(response.result.value)")
                
                guard let dataJSON = response.data else {
                    resultRequest(nil,NSError())
                    return
                }
                
                do {
                    let resultJSON = try? JSONDecoder().decode(MusicRequest.self, from: dataJSON)
                    
                    resultRequest(resultJSON?.hotspots,nil)
                }catch {
                    resultRequest(nil,NSError())
                }

                
                
            }else {
                print(response.response?.statusCode)
            }
        }
        
    }
    
}
