//
//  ViewController.swift
//  MovieList
//
//  Created by Mac Pro on 02/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var musicTableView: UITableView!
    
    var arrayMusic: [Music] = []{
        didSet{
            musicTableView.reloadData()
        }
    }
    
    var getMusicHotSpot: MusicAPI = MusicAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicTableView.delegate = self
        musicTableView.dataSource = self
        
        musicTableView.register(UINib(nibName: "CellMusic", bundle: nil), forCellReuseIdentifier: "CellMusic")
        
        getMusicHotSpot.getMusic { (music, erro) in
            if erro != nil{
                
                if let array = music{
                    
                    self.arrayMusic = array
                    self.musicTableView.reloadData()
                }
                
                print("Deu Erro ao carregar o filme \(erro)")
            }else{
                print("Show de bola!!! \(music)")
                
                //self.arrayMusic = music?.results ?? []
                
            }
        }
        
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = musicTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellMusic{
            
            cell.setCell(music: arrayMusic[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayMusic.count
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
    
}

