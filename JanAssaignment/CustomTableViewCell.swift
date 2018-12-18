//
//  CustomTableViewCell.swift
//  JanAssaignment
//
//  Created by Oniel Rosario on 12/17/18.
//  Copyright © 2018 Oniel Rosario. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleLink: UILabel!
    @IBOutlet weak var articleDescription: UITextView!
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
