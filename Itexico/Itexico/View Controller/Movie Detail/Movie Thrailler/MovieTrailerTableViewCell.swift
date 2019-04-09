//
//  MovieTrailerTableViewCell.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/7/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class MovieTrailerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String? {
        didSet {
            self.nameLabel.text = name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
