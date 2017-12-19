//
//  MovieListViewController.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

protocol MovieListViewInput: class {
    
}

class MovieListViewController: UIViewController {
    var output: MovieListViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
}

extension MovieListViewController : MovieListViewInput {
    
}
