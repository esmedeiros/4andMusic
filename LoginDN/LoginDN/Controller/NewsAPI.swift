//
//  MusicAPI.swift
//  LoginDN
//
//  Created by Mac Pro on 16/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import Alamofire

class NewsAPI{
    
    func getNews(resultRequest: @escaping (_ result:[News]?, _ erro: NSError?) -> Void) -> Void{
        
        let url = "https://www.vagalume.com.br/news/index.js"
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.response?.statusCode == 200{
                print("Legal, API consumida!!! \(response.result.value)")
                
                guard let dataJSON = response.data else {
                    resultRequest(nil,NSError())
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let resultJSON = try decoder.decode(NewsRequest.self, from: dataJSON)
                    resultRequest(resultJSON.news,nil)
                }catch {
                    resultRequest(nil,NSError())
                }
             
            } else {
                resultRequest(nil, response.error as NSError?)
            }
        }

        
        
//        Alamofire.request(url, method: .get).responseJSON { (response) in
//            if response.response?.statusCode == 200{
//                print("Legal, API consumida!!! \(response.result.value)")
//
//                guard let dataJSON = response.data else {
//                    resultRequest(nil,NSError())
//                    return
//                }
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let resultJSON = try? JSONDecoder().decode(NewsRequest.self, from: (dataJSON as? Data)!)
//                resultRequest(resultJSON?.news,nil)
//            }else {
//                print(response.response?.statusCode)
//            }
//        }
        
    }
    
}

