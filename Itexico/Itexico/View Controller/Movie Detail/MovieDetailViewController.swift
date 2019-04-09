//
//  MovieDetailViewController.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/6/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit

enum MoviesCell {
    case MovieNameTableViewCell
    case MovieOverviewTableViewCell
    case TrailerHeaderTableViewCell
    case MovieTrailerTableViewCell
}

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let movieNameTableViewCellIdentfier = "MovieNameTableViewCell"
    let movieOverviewTableViewCellIdentifier = "MovieOverviewTableViewCell"
    let trailerHeaderTableViewCell = "TrailerHeaderTableViewCell"
    let movieTrailerTableViewCell = "MovieTrailerTableViewCell"
    var form = [MoviesCell.MovieNameTableViewCell, MoviesCell.MovieOverviewTableViewCell, MoviesCell.TrailerHeaderTableViewCell]
    var movie: Movie?
    var trailers: [Trailer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureView()
        self.requestTrailers(movieId: (self.movie?.id)!)
    }
    
    func configureView() {
        self.title = self.movie?.title
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: movieNameTableViewCellIdentfier, bundle: nil), forCellReuseIdentifier: movieNameTableViewCellIdentfier)
        self.tableView.register(UINib(nibName: movieOverviewTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: movieOverviewTableViewCellIdentifier)
        self.tableView.register(UINib(nibName: trailerHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: trailerHeaderTableViewCell)
        self.tableView.register(UINib(nibName: movieTrailerTableViewCell, bundle: nil), forCellReuseIdentifier: movieTrailerTableViewCell)
    }
    
    func requestTrailers(movieId: Int) {
        WebServicesManager.getTrailersList(movieId: movieId) { (trailers) in
            self.trailers = trailers
            for _ in self.trailers {
                self.form.append(MoviesCell.MovieTrailerTableViewCell)
            }
            self.tableView.reloadData()
        }
    }

}

extension MovieDetailViewController : UITableViewDelegate {
    
}

extension MovieDetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.form.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = form[indexPath.row]
        switch cellType {
        case .MovieNameTableViewCell:
            let movieNameCell = self.tableView.dequeueReusableCell(withIdentifier: movieNameTableViewCellIdentfier, for: indexPath) as! MovieNameTableViewCell
            movieNameCell.name = self.movie?.title
            return movieNameCell
        case .MovieOverviewTableViewCell:
            let movieOverviewCell = self.tableView.dequeueReusableCell(withIdentifier: movieOverviewTableViewCellIdentifier, for: indexPath) as! MovieOverviewTableViewCell
            movieOverviewCell.fillInfoWith(movie: self.movie!)
            return movieOverviewCell
        case .TrailerHeaderTableViewCell:
            let trailerHeaderCell = self.tableView.dequeueReusableCell(withIdentifier: trailerHeaderTableViewCell, for: indexPath) as! TrailerHeaderTableViewCell
            return trailerHeaderCell
        case .MovieTrailerTableViewCell:
            let triler = self.trailers[indexPath.row - 3]
            let movieTrailerCell = self.tableView.dequeueReusableCell(withIdentifier: movieTrailerTableViewCell, for: indexPath) as! MovieTrailerTableViewCell
            movieTrailerCell.name = triler.name
            return movieTrailerCell
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = form[indexPath.row]
        switch cellType {
        case .MovieNameTableViewCell:
            return  165
        case .MovieOverviewTableViewCell:
            return UITableView.automaticDimension
        case .TrailerHeaderTableViewCell:
            return 44
        case .MovieTrailerTableViewCell:
            return 57
        }
    }
}
