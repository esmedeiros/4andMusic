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
    var notificationCenter = UNUserNotificationCenter.current()
    let colors = Colors()
    let newsController = NewsController()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func loadData(){
        newsController.getNewsApi { (success) in
            if success{
                self.tableview.reloadData()
            }
        }
    }
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        notificationCenter.delegate = self
        tableview.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "cellNews")
    }
}

extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "cellNews", for: indexPath) as? NewsCell{
            cell.setCellNews(news: newsController.getElementAt(index: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsController.getArraySize()
    }
}

extension NewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "detailSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            let news: News = newsController.getElementAt(index: sender as! Int)
            destination.newsURL = news.url
        }
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipe = leftSwipeIndex(index: indexPath)
        
        let swipeAction = UISwipeActionsConfiguration(actions: [swipe])
        
        return swipeAction
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipe = swipeIndex(index: indexPath)
        
        let swipeAction = UISwipeActionsConfiguration(actions: [swipe])
        
        return swipeAction
    }
    
    func leftSwipeIndex(index: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Shared") { (action, view, completion) in
            let URLToShare = self.newsController.getElementAt(index: index.row).url

            let activityVC = UIActivityViewController(activityItems: [URLToShare], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
        }
        action.image = UIImage(named: "share")
        action.backgroundColor = colors.orange
        
        return action
    }
    
    func swipeIndex(index: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Schedule") { (action, view, completion) in
            self.newsController.requestAuthorization(completion: { (sucesso) in
                if sucesso {
                    self.createNotification(index: index)
                    AlertController.showAlert(self, title: "Alert", message: "Lembrete salvo com sucesso")
                } else {
                    AlertController.showAlert(self, title: "Alert", message: "Você precisa autorizar as notificações do 4andMusic.")
                }
            })
        }
        
        action.image = UIImage(named: "relogio")
        action.backgroundColor = colors.orange
        return action
    }
    
    
    func identifierURL(object: News) -> String{
        let url = object.url
        return url
    }
    
    func createNotification(index: IndexPath){
        
        let url = identifierURL(object: newsController.getElementAt(index: index.row))
        
        let feature = newsController.getElementAt(index: index.row).featured
        let subtitle = newsController.getElementAt(index: index.row).headline
        let body = newsController.getElementAt(index: index.row).inserted
        
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
}
extension NewsViewController: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
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
                let news: News = newsController.getElementAt(index: sender as! Int)
                destination.newsURL = news.url
            }
        }
    }
}
