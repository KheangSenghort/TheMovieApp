//
//  MovieListPresenter.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol MovieListViewOutput {
    func viewWillAppear()
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
    var moviesListStatus: MovieListStatus = .awaitingResponse

    private var recentSearches = [MovieListCellViewModel]()

}

extension MoviesPresenter: MovieListViewOutput {

    func viewWillAppear() {
        interactor.fetchFirstPageList()
    }

    func viewWillDisappear() {
        coordinator.setMoviesListAvailabilityStatus(status: moviesListStatus)
    }

    func cellViewModelForRow(atIndexPath indexPath: IndexPath) -> MovieListCellViewModel {
        return interactor.currentMoviesList()[indexPath.row]
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
        moviesListStatus = .error
        view?.dismiss()
    }

    func updateMovieListWithResults() {
        if(numberOfCells() > 0) {
            moviesListStatus = .available
            view?.reloadTable()
        } else {
            moviesListStatus = .error
            view?.dismiss()
        }
    }
}
