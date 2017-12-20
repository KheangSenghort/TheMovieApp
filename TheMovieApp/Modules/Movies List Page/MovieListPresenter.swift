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

    func numberOfCells() -> Int
    func cellViewModelForRow(atIndexPath indexPath: IndexPath) -> MovieListCellViewModel
    func fetchNextCellsIfAvailable()

}

protocol MovieListInteractorOutput: class {
    func updateMovieListWithResults()
    func finishedLoadingAllMovies()
    func showError()
}

class MoviesPresenter {
    weak var view: MovieListViewInput?
    var interactor: MovieListInteractorInput!
    var coordinator: MovieListCoordinatorInput!
    var moviesListStatus: MovieListStatus = .fetching
    
    private var recentSearches = [MovieListCellViewModel]()
    
}

extension MoviesPresenter: MovieListViewOutput {
    func viewIsReady() {
        
    }
    
    func viewWillAppear() {
        interactor.fetchFirstPageList()
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }

    func cellViewModelForRow(atIndexPath indexPath: IndexPath) -> MovieListCellViewModel {
        let movieData = interactor.currentMoviesList()[indexPath.row]
        var posterUrl: URL? = nil
        if let imageURL = movieData.poster_path {//TODO: shouldn't be here
            let baseImageURL =  "https://image.tmdb.org/t/p/w92/"
            posterUrl = URL(string: baseImageURL + imageURL)
        }
        
        return MovieListCellViewModel(title: movieData.title,
                                      releaseDate: movieData.release_date,
                                      overview: movieData.overview,
                                      posterUrl: posterUrl,
                                      movieImage: nil)
    }

    func numberOfCells() -> Int {
        let currentCount = interactor.currentMoviesList().count
        return currentCount
    }
    
    func fetchNextCellsIfAvailable() {
        interactor.fetchNextPageIfAvailable()
    }
}

extension MoviesPresenter: MovieListInteractorOutput {
    
    func finishedLoadingAllMovies() {
        view?.removeFetchingMoreSpinner()
    }
    
    func showError() {
        moviesListStatus = .notAvailable
        view?.dismiss()
    }
    
    func updateMovieListWithResults() {
        if(numberOfCells() > 0) {
            moviesListStatus = .available
            view?.reloadTable()
        } else {
            moviesListStatus = .notAvailable
            view?.dismiss()
        }
    }
}
