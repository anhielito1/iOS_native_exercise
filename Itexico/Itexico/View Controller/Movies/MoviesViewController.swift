//
//  MoviesViewController.swift
//  Itexico
//
//  Created by Angel Coronado Quintero on 4/6/19.
//  Copyright © 2019 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    // MARK: - Properties
    let movieCellIdentifier = "MovieCollectionViewCell"
    var movies: [Movie] = []
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        requestMovies()
    }
    
    func configureCollectionView() {
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.register(UINib(nibName: self.movieCellIdentifier, bundle: nil), forCellWithReuseIdentifier: self.movieCellIdentifier)
    }

    func requestMovies() {
        WebServicesManager.getMoviesList { (movies) in
            self.movies = movies
            self.moviesCollectionView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "movieDetailSegue" {
            let movieDetailViewController = segue.destination as! MovieDetailViewController
            movieDetailViewController.movie = self.selectedMovie
        }
    }
    @IBAction func languageAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Language", message: "Select Language", preferredStyle: .actionSheet)
        let spanishAction = UIAlertAction(title: "Spanish", style: .default) { (alert) in
            WebLinks.language = .spanish
            WebLinks.createMovieListPath()
            self.requestMovies()
        }
        let englishAction = UIAlertAction(title: "English", style: .default) { (alert) in
            WebLinks.language = .english
            WebLinks.createMovieListPath()
            self.requestMovies()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            
        }
        alert.addAction(spanishAction)
        alert.addAction(englishAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            
        }

    }
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Filter", message: "Select Filter", preferredStyle: .actionSheet)
        let popularAction = UIAlertAction(title: "Popular", style: .default) { (alert) in
            WebLinks.filter = .popular
            WebLinks.createMovieListPath()
            self.requestMovies()
        }
        let topAction = UIAlertAction(title: "Top", style: .default) { (alert) in
            WebLinks.filter = .top
            WebLinks.createMovieListPath()
            self.requestMovies()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            
        }
        alert.addAction(popularAction)
        alert.addAction(topAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            
        }
    }
    
}

extension MoviesViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = self.movies[indexPath.row]
        self.performSegue(withIdentifier: "movieDetailSegue", sender: self)
    }
}

extension MoviesViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movies[indexPath.row]
        let movieCell = self.moviesCollectionView.dequeueReusableCell(withReuseIdentifier: self.movieCellIdentifier, for: indexPath) as! MovieCollectionViewCell
        movieCell.imageUrl = movie.posterPath
        return movieCell
    }
}

extension MoviesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 2
        let height = self.view.frame.height / 3
        return CGSize(width: width, height: height)
    }
    
}
