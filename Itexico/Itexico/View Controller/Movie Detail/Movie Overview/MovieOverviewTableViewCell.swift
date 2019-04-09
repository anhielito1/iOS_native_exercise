//
//  MovieOverviewTableViewCell.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/6/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Kingfisher

class MovieOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearReleaseLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var markAsFavoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.markAsFavoriteButton.setTitle("MARK AS \n FAVORITE", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillInfoWith(movie: Movie) {
        let urlPoster = URL(string: movie.posterPath)
        self.posterImageView.kf.indicatorType = .activity
        self.posterImageView.kf.setImage(with: urlPoster, placeholder: Images.placeholderMovie)
        let date = movie.releaseDate.toDate()
        let year = date.getYear()
        self.yearReleaseLabel.text = year
        self.ratingLabel.text = movie.voteAvarage.description + "/10"
        self.movieDescriptionLabel.text = movie.overview
    }
    
    
    
    @IBAction func markAsFavoriteAction(_ sender: UIButton) {
        self.markAsFavoriteButton.setTitle("FAVORITE", for: .normal)
    }
    
}

extension String {
    func toDate(withFormat format: String = "yyyy-mm-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}

extension Date {
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: self)
        return year
    }
}
