//
//  MusicInfo.swift
//  LoginDN
//
//  Created by Mac Pro on 15/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

struct Music: Codable {
    
    let id: String
    let title, artURL, date: String
    let dateFmt: String
    let link: String
    let descr: String
    let picSrc, artPicSrc: String
    let picWidth, picHeight, colors, type: String
    let musicID, musTitle, musURL: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artURL = "artUrl"
        case date
        case dateFmt = "date_fmt"
        case link, descr
        case picSrc = "pic_src"
        case artPicSrc = "art_pic_src"
        case picWidth = "pic_width"
        case picHeight = "pic_height"
        case colors, type, musicID, musTitle
        case musURL = "musUrl"
    }
    
}


