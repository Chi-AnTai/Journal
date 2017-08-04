//
//  ViewController.swift
//  Jonrnal
//
//  Created by 戴其安 on 2017/8/4.
//  Copyright © 2017年 戴其安. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var articles: [ArticleCoreData] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ArticleCell {
            if let targetViewController = segue.destination as? AddJournalViewController {
                
                targetViewController.articleTitle = cell.artiecleTitleLabel.text
            
            }
        }
    }
    
    
    
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        cell.articleImageView.clipsToBounds = true
        //cell.articleImageView.layer.masksToBounds = true
        cell.articleImageView.layer.cornerRadius = 8
        
        cell.circleImageView.clipsToBounds = true
        cell.circleImageView.layer.borderWidth = 0.5
        cell.circleImageView.layer.borderColor = UIColor(colorLiteralRed: 171/225, green: 179/225, blue: 176/225, alpha: 1).cgColor
        
        cell.circleImageView.layer.cornerRadius = 5
        cell.articleImageView.image = UIImage(data: articles[indexPath.row].image! as Data)
        cell.artiecleTitleLabel.text = articles[indexPath.row].title
        
        cell.shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        cell.shadowView.layer.shadowRadius = 8
        cell.shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.shadowView.layer.shadowOpacity = 0.5
        
//        let shadowLayer = CALayer()
//        shadowLayer.shadowColor = UIColor.darkGray.cgColor
//        
//        shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
//        shadowLayer.shadowOpacity = 1
//        shadowLayer.shadowRadius = 3
//        cell.articleImageView.layer.addSublayer(shadowLayer)
        
        
        
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        do {
            let tasks = try self.context.fetch(ArticleCoreData.fetchRequest())
            
            articles = (tasks as? [ArticleCoreData])!
            
            //self.collectionView.reloadData()
        } catch {}
        articleTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

