//
//  ViewController.swift
//  MovieList
//
//  Created by Mac Pro on 02/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import UserNotificationsUI

class NewsViewController: UIViewController {
    
    var selected:Int = 0
    var indexIdentifier: Int = 0
    var notificationCenter = UNUserNotificationCenter.current()
    
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
        notificationCenter.delegate = self
        
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
        
        let swipe = swipeIndex(index: indexPath)
        
        let swipeAction = UISwipeActionsConfiguration(actions: [swipe])
        
        return swipeAction
    }
    
    
    func swipeIndex(index: IndexPath) -> UIContextualAction{
        
        //   let array = self.arrayNews[index.row]
        
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            self.createNotification(index: index)
            self.selected = index.row
            completion(true)
            print("clicou na linha \(index)")
        }
        // action.image =
        // action.backgroundColor
        
        return action
    }
    
    
    func identifierURL(object: News) -> String{
        
        let url = object.url
        
        return url
        
    }
    
    func index() -> Int{
        
        let index = selected
        
        return index
    }
    
    
    func createNotification(index: IndexPath){
        
        let url = identifierURL(object: arrayNews[index.row])
        
        let feature = arrayNews[index.row].featured
        let subtitle = arrayNews[index.row].headline
        let body = arrayNews[index.row].inserted
        
        let content = UNMutableNotificationContent()
        content.title = feature
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = url
        
        let date = Date(timeIntervalSinceNow: 10)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: url, content: content, trigger: trigger)
        
        
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    func scheduleNotification(){
    }
    
}


extension NewsViewController: UNUserNotificationCenterDelegate{
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        indexIdentifier = index()
        //let sender = identifierURL(object: arrayNews[indexIdentifier])
        
        
        if !response.notification.request.identifier.isEmpty {
            
            switch response.actionIdentifier {
                
            case UNNotificationDefaultActionIdentifier:
                self.performSegue(withIdentifier: "detailSegue", sender: response.notification.request.identifier)
                print("Açao no Local Notificarion")
            case UNNotificationDismissActionIdentifier:
                print("Dismiss no Local Notification")
            default:
                print("Default local notification")
            }
            
        }
        
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailsViewController {
                
                let news: News = arrayNews[selected]
                destination.newsURL = news.url
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
    
}
