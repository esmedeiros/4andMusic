//
//  NewsController.swift
//  LoginDN
//
//  Created by Alexandre Aun on 23/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import UserNotifications

class NewsController{
    
    let newsApi = NewsAPI()
    var arrayNews: [News] = []
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]

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
    
    func requestAuthorization(completion: @escaping (Bool) -> Void){
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (didAllow, error) in
            if error != nil || !didAllow{
                completion(false)
            }else{
                completion(true)
            }
        }
    }
}
