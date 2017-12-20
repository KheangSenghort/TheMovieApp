//
//  MovieListInteractor.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol MovieListInteractorInput {
    func fetchFirstPageList()
    func fetchNextPageIfAvailable()
    func isNextPageAvailable() -> Bool
    func currentMoviesList() -> [MovieListDataModel.Movies]
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

    var lastPageAvailable = 1
    var lastPageRequested = 0
    var totalPages = 1

    init(searchText: String, movieListService: MovieListService = MovieListServiceBuilder().build()) {
        self.searchText = searchText
        self.movieListService = movieListService
    }

    func fetchFirstPageList() {//TODO: rename
        let request = MovieListRequest(queryText: searchText, pageNumber: 1)
        fetchMoviesForRequest(request: request)
    }
    
    private func fetchMoviesForRequest(request: MovieListRequest) {
        lastPageRequested = request.pageNumber
        movieListService.getMoviesForQueryText(request: request) { (response: MovieListResponse) in
            
            switch response.status {
            case .success(listViewModel: let listDataModel):
                self.lastPageAvailable = listDataModel.page
                self.totalPages = listDataModel.total_pages
                self.movies.append(contentsOf: listDataModel.results)
                self.output?.updateMovieListWithResults()
            default:
                self.output?.showError()
            }
        }
    }
    
    func fetchNextPageIfAvailable() {
        let pageToFetch = lastPageAvailable + 1
        if isNextPageAvailable() && pageToFetch != lastPageRequested {
            let request = MovieListRequest(queryText: searchText, pageNumber: pageToFetch)
            fetchMoviesForRequest(request: request)
        } else {
            self.output?.finishedLoadingAllMovies()
        }
    }
    
    func currentMoviesList() -> [MovieListDataModel.Movies] {
        return movies
    }
    
    func isNextPageAvailable() -> Bool {
        return lastPageAvailable < totalPages
    }
}
