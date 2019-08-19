//
//  NewsViewController.swift
//  LoginDN
//
//  Created by Mac Pro on 16/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {

    @IBOutlet weak var topoNewsIV: UIImageView!
    @IBOutlet weak var headlineNewsLb: UILabel!
    @IBOutlet weak var urlNewsLb: UILabel!
    @IBOutlet weak var insertedNewsLb: UILabel!
    @IBOutlet weak var featuredLb: UILabel!
    
    func setCellNews(news: News){
        
        topoNewsIV.sd_setImage(with:URL(string: "https://www.vagalume.com.br/\(news.picSrc)"), completed: nil)
        headlineNewsLb.text = news.headline
        urlNewsLb.text = news.url
        insertedNewsLb.text = news.inserted
        featuredLb.text = news.featured
        
    }
    
}
