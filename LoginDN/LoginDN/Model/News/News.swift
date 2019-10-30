//
//  News.swift
//  LoginDN
//
//  Created by Mac Pro on 16/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

class News: Codable{
    
    var headline: String
    var url: String
    var inserted: String
    var picSrc: String
    var featured: String
    
}

class NewsRequest: Codable{
    var news: [News]
}

