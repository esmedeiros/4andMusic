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
    
//    required public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        news = try values.decode([News].self, forKey: .news)
//    }

}

