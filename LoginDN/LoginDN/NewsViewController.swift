//
//  ViewController.swift
//  MovieList
//
//  Created by Mac Pro on 02/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NewsViewController: UIViewController {
    
    var selected:Int = 0
    let notificationCenter = UNUserNotificationCenter.current()
    
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

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.leftBarButtonItem = nil
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selected = indexPath.row
        
        self.performSegue(withIdentifier: "detailSegue", sender: nil)
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {

            let news: News = arrayNews[selected]
            destination.newsURL = news.url
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
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let notification = swipeAction(index: indexPath)
        
        return UISwipeActionsConfiguration(actions: [notification])
    
    }
    
    func swipeAction(index: IndexPath) -> UIContextualAction{
        let arraynews = self.arrayNews[index.row]
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            
            
            
            
            completion(true)
            
          //  action.image =
        
            print("clicou na linha \(index.row)")
        }
        
    
     return action
    }
    
    
    
    func notification(){
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (bool, error) in
            if error != nil{
                print("Usuario nao autorizou a notificação")
            } else{
                print("Usuario autorizou a notificacao")
            }
        }
    }
    
    func scheduleNotification(){
        
        
        
        
    }
    
    
    
    
}


