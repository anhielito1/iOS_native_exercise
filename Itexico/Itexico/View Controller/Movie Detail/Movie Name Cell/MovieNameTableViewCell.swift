//
//  MovieNameTableViewCell.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/6/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class MovieNameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
   
    var name : String? {
        didSet {
            self.nameLabel.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
