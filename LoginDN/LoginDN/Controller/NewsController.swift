//
//  NewsController.swift
//  LoginDN
//
//  Created by Alexandre Aun on 23/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

class NewsController{
    
    let newsApi = NewsAPI()
    var arrayNews: [News] = []
    
    func getNewsApi(completion: @escaping (Bool) -> Void){
        
        newsApi.getNews { (news, erro) in
            if erro != nil{
                completion(false)
            }else{
                self.arrayNews = news ?? []
                completion(true)
            }
         }
    }
    
    func getArraySize() -> Int{
        return arrayNews.count
    }
    
    func getElementAt(index: Int)-> News{
        return arrayNews[index]
    }
}
