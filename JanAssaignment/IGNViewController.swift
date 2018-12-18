//
//  ViewController.swift
//  JanAssaignment
//
//  Created by Oniel Rosario on 12/17/18.
//  Copyright © 2018 Oniel Rosario. All rights reserved.
//

import UIKit

class IGNViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searBarch: UISearchBar!
    var articles =  [IGN.Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        IgnAPIClient.getArticles { (articles, error) in
            if let error = error {
                print("error: \(error)")
            }
            if let articles = articles {
            self.articles = articles
            }
        }
        title = "IGN Network"
    }

}

extension IGNViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell()}
        let indexpath = articles[indexPath.row]
       cell.headlineLabel.text = indexpath.title
        cell.articleImage.image = IgnAPIClient.getImage(url: indexpath.urlToImage)
        if indexpath.author != nil {
            cell.articleAuthor.text = "Author: \(indexpath.author ?? "Anonymous")"
        }
        cell.articleDescription.text = indexpath.description
        cell.articleDate.text = indexpath.publishedAt
        cell.articleLink.text = indexpath.url
        
        return cell
    }
}

extension IGNViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}
