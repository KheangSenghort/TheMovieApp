//
//  SearchPresenter.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol SearchViewOutput {
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    
    func userActivatedTextField()
    func userTappedOnSearchButton(withSearchText searchText: String)
    func userDeactivatedTextField() //resignfirstResponder
    
    func needsUpdateRecentSearch()
    func recentSearchCount() -> Int
    func cellViewModelForRow(atIndexPath indexPath: IndexPath) // returns some RecentSearchCellDataModel
    func user(didSelectRecentSearchAt indexPath: IndexPath)
}

protocol SearchInteractorOutput: class {
    func updateWithRecentSearches(recentSearches: [String])
    func recentSearchNotAvailable()
}


class SearchPresenter {
    
    weak var view: SearchViewInput?
    var interactor: SearchInteractorInput!
    var coordinator: SearchCoordinatorInput!//TODO: check for reference cycle
    var searchText = ""
    
    private var recentSearches = [RecentSearchCellDataModel]()
}

extension SearchPresenter: SearchViewOutput {
    
    //MARK: SearchViewOutput
    
    func viewIsReady() {
        view?.hideRecentSearchTable()
        interactor.fetchRecentSearches()
    }
    
    func viewWillAppear() {
        showRecentSearchTableIfNeeded()
    }
    
    func viewDidAppear() {
    }
    
    func viewWillDisappear() {
    }
    
    func userActivatedTextField() {
        showRecentSearchTableIfNeeded()
    }
    
    private func showRecentSearchTableIfNeeded() {
        view?.showRecentSearchTable()
    }
    
    func userDeactivatedTextField() {
        view?.hideRecentSearchTable()
    }
    
    func cellViewModelForRow(atIndexPath indexPath: IndexPath) -> RecentSearchCellDataModel {
        return recentSearches[indexPath.row]
    }
    
    func recentSearchCount() -> Int {
        return recentSearches.count
    }
    
    func user(didSelectRecentSearchAt indexPath: IndexPath) {

    }
    
    func userTappedOnSearchButton(withSearchText searchText: String) {

    }
    
    func needsUpdateRecentSearch() {
        interactor.insertRecentSearch(searchString: searchText)
    }
    
    private func isValidSearchText(searchText: String) -> Bool {
        //TODO:
        return true
    }
}

extension SearchPresenter: SearchInteractorOutput {
    
    func updateWithRecentSearches(recentSearches: [String]) {
        //refresh list
        view?.refreshRecentSearchData()
    }
    
    func recentSearchNotAvailable() {
        view?.hideRecentSearchTable()
    }
}

struct RecentSearchCellDataModel {
    let searchText: String
}

