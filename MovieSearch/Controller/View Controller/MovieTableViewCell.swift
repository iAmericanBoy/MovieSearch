//
//  MoviewTableViewCell.swift
//  MovieSearch
//
//  Created by Dominic Lanzillotta on 2/8/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Private Functions
    private func updateViews() {
        guard let movie = movie else {return}
        MovieController.fetchImageFrom(movie: movie) { (movieImage) in
            DispatchQueue.main.async {
                self.movieImageView.image = movieImage
            }
        }
        nameLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.rating ?? 0)"
        summaryLabel.text = movie.overview
    }
}
