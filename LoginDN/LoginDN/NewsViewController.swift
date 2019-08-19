//
//  ViewController.swift
//  MovieList
//
//  Created by Mac Pro on 02/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var arrayNews: [News] = []{
        didSet{
            tableview.reloadData()
        }
    }
    
    var getMusicHotSpot: NewsAPI = NewsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "cellNews")
        
        getMusicHotSpot.getNews { (news, erro) in
            if erro != nil{
                
                if let array = news{
                }
                print("Deu Erro ao carregar as noticias \(erro)")
            }else{
                print("Show de bola!!! \(news)")
                
                self.arrayNews = news ?? []
                self.tableview.reloadData()
                
            }
        }
        
    }
    
    
}

extension NewsViewController: UITableViewDataSource{
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "cellNews", for: indexPath) as? NewsCell{
            
            cell.setCellNews(news: arrayNews[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayNews.count
    }
    
    
}

extension NewsViewController: UITableViewDelegate{
    
    
}


