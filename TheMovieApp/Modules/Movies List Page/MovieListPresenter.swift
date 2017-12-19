//
//  MovieListPresenter.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol MovieListViewOutput {
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()

}

protocol MovieListInteractorOutput: class {
    
}

class MoviesPresenter {
    weak var view: MovieListViewInput?
    var interactor: MovieListInteractorInput!
    var coordinator: MovieListCoordinatorInput!    
}

extension MoviesPresenter: MovieListViewOutput {
    func viewIsReady() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }

}

extension MoviesPresenter: MovieListInteractorOutput {

}
