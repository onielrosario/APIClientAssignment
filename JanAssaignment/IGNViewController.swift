//
//  ViewController.swift
//  JanAssaignment
//
//  Created by Oniel Rosario on 12/17/18.
//  Copyright © 2018 Oniel Rosario. All rights reserved.
//

import UIKit
import SafariServices


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
        searBarch.delegate = self
        IgnAPIClient.getArticles { (articles, error) in
            if let error = error {
                print("error: \(error)")
            }
            if let articles = articles {
                self.articles = articles
            }
        }
        title = "🎮 Gaming News 🎮"
    }
    
    @objc func tapFunction(sender: TapGestureRecognizer) {
        let safari = SFSafariViewController.init(url: URL(string: sender.url)!)
        safari.delegate = self
        present(safari, animated: true, completion: nil)
    }
}
func convertDate(str: String) -> String {
    var arr = str.components(separatedBy: "T")
    let string = arr[0]
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    let date = dateFormater.date(from: string) // Date
    dateFormater.dateFormat = "MMMM dd, yyyy"
    let finalStr = dateFormater.string(from: date!)
    return finalStr
}

extension IGNViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell()}
        let indexpath = articles[indexPath.row]
        cell.headlineLabel.text = indexpath.title
        cell.headlineLabel.textColor = .white
        cell.backgroundColor = UIColor(displayP3Red: CGFloat(101)/255, green: CGFloat(16)/255, blue: CGFloat(32)/255, alpha: 1)
        cell.articleImage.image = IgnAPIClient.getImage(url: indexpath.urlToImage)
        if indexpath.author != nil {
            cell.articleAuthor.textColor = .white
            cell.articleAuthor.text = "Author: \(indexpath.author ?? "Anonymous")"
        }
        
        cell.articleDescription.text = indexpath.description
        
        cell.articleDate.text = convertDate(str: indexpath.publishedAt)
        cell.articleDate.textColor = .white
        cell.articleLink.isUserInteractionEnabled = true
        cell.articleLink.text = ">>Click for full Article<<"
        cell.articleLink.textColor = .orange
        let tap = TapGestureRecognizer(target: self, action: #selector(IGNViewController.tapFunction))
        tap.url = indexpath.url
        cell.articleLink.addGestureRecognizer(tap)
        return cell
    }
}

extension IGNViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension IGNViewController: SFSafariViewControllerDelegate {
}

extension IGNViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchtext = searchBar.text else {
            return
        }
        
    }
    
}
