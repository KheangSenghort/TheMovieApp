//
//  MovieListViewController.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

public struct MovieListCellViewModel {
    let title: String
    let releaseDate: String?
    let overview: String?
    let posterUrl: URL?
    var movieImage: UIImage? = nil
}

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
        releaseDateLabel.text = nil
        overviewLabel.text = nil
    }
    
    func configure(withModel model: Any) {
        guard let movieCellViewModel = model as? MovieListCellViewModel else {
            fatalError("Expected to have MovieListCellDataModel")
        }

        self.titleLabel.text = movieCellViewModel.title
        self.releaseDateLabel.text = movieCellViewModel.releaseDate
        self.overviewLabel.text = movieCellViewModel.overview

    }
}
