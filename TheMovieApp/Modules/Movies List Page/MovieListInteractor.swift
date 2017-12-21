//
//  MovieListInteractor.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol MovieListInteractorInput {
    func fetchFirstPageList()
    func fetchNextPageIfAvailable()
    func isNextPageAvailable() -> Bool
    func currentMoviesList() -> [MovieListCellViewModel]
}

/**
 An Interactor is a link between the presenter and the storage/API.
 Here, the MoviesInteractor communicates with the API to fetch the movies for the given search query.
 This class also handles the pagination logic.
 */
class MoviesInteractor : MovieListInteractorInput {
    
    weak var output: MovieListInteractorOutput?
    let movieListService: MovieListService
    private var movies = [MovieListCellViewModel]()
    private let searchText: String
    
    private var lastPageAvailable = 1
    private var lastPageRequested = 0
    private var totalPages = 1

    init(searchText: String, movieListService: MovieListService = MovieListServiceBuilder().build()) {
        self.searchText = searchText
        self.movieListService = movieListService
    }

    func fetchFirstPageList() {
        let request = MovieListRequest(queryText: searchText, pageNumber: 1)
        fetchMoviesForRequest(request: request)
    }
    
    private func fetchMoviesForRequest(request: MovieListRequest) {
        lastPageRequested = request.pageNumber
        movieListService.getMoviesForQueryText(request: request) { [weak self] (response: MovieListResponse) in
            guard let weakSelf = self else {
                return
            }
            switch response.status {
            case .success(listViewModel: let listDataModel):
                weakSelf.lastPageAvailable = listDataModel.page
                weakSelf.totalPages = listDataModel.total_pages
                let baseImageURL =  "https://image.tmdb.org/t/p/w92/"

                let moviesArray = listDataModel.results.map({ movieData -> MovieListCellViewModel in
                    var posterUrl: URL? = nil
                    if let imageURL = movieData.poster_path {
                        posterUrl = URL(string: baseImageURL + imageURL)
                    }
                    return MovieListCellViewModel(title: movieData.title,
                                                  releaseDate: movieData.release_date,
                                                  overview: movieData.overview,
                                                  posterUrl: posterUrl)
                })
                weakSelf.movies.append(contentsOf: moviesArray)
                weakSelf.output?.updateMovieListWithResults()
            default:
                weakSelf.output?.showError()
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
    
    func currentMoviesList() -> [MovieListCellViewModel] {
        return movies
    }
    
    func isNextPageAvailable() -> Bool {
        return lastPageAvailable < totalPages
    }
}
