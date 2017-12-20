//
//  MovieListViewController.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ConfigurableCell {
    func configure(withModel model: Any)
}

class MovieCell: UITableViewCell, ConfigurableCell {
    private let placeHolderImageName = "movie_placeholder"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func prepareForReuse() {
        titleLabel.text = ""
        posterImage.image = UIImage(named: placeHolderImageName)
        releaseDateLabel.text = nil
        overviewLabel.text = nil
    }
    
    func configure(withModel model: Any) {
        guard let movieCellViewModel = model as? MovieListCellViewModel else {
            fatalError("Expected to have MovieListCellViewModel")
        }

        self.titleLabel.text = movieCellViewModel.title
        self.releaseDateLabel.text = movieCellViewModel.releaseDate
        self.overviewLabel.text = movieCellViewModel.overview
        
        let placeholderImage = UIImage(named: placeHolderImageName)
        if let imageURL = movieCellViewModel.posterUrl {
            self.posterImage.af_setImage(withURL: imageURL, placeholderImage: placeholderImage)
        }
    }
}
