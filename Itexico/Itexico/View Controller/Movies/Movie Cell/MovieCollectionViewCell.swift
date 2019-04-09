//
//  MovieCollectionViewCell.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/6/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
   
    var imageUrl : String? {
        didSet {
            if let url = imageUrl {
            let urlPoster = URL(string: url)
            self.posterImageView.kf.indicatorType = .activity
            self.posterImageView.kf.setImage(with: urlPoster, placeholder: Images.placeholderMovie)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
