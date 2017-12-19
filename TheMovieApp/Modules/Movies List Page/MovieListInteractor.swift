//
//  MovieListInteractor.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol MovieListInteractorInput {

}

/**
 An Interactor is a link between the presenter and the storage/API.
 Here, the MoviesInteractor communicates with the API to fetch the movies for the given search query.
 This class also handles the pagination logic.
 */
class MoviesInteractor : MovieListInteractorInput {
    
    weak var output: MovieListInteractorOutput?
    let movieListService: MovieListService
    var movies = [MovieListDataModel.Movies]()
    let searchText: String

    init(searchText: String, movieListService: MovieListService = MovieListServiceBuilder().build()) {
        self.searchText = searchText
        self.movieListService = movieListService
    }


}
