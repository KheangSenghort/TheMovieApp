//
//  SearchInteractor.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol SearchInteractorInput {
    func insertRecentSearch(searchString: String)
    func fetchRecentSearches()
}

/**
 An Interactor is a link between the presenter and the storage/API.
 Here, the SearchInteractor communicates with the user defaults to save and retrieve
 the list of most recent successful searches.
 */
class SearchInteractor: SearchInteractorInput {

    weak var output: SearchInteractorOutput?
    private let storageManager: Storage

    init(storageManager: Storage = UserDefaultsStorageImplementation()) {
        self.storageManager = storageManager
    }

    func insertRecentSearch(searchString: String) {
        storageManager.addSuccessfulRecentSearch(recentSearch: searchString) { (needsUpdate: Bool) in
            if (needsUpdate) {
                output?.updateWithRecentSearches(recentSearches: storageManager.fetchRecentSearches())
            }
        }
    }

    func fetchRecentSearches() {
        output?.updateWithRecentSearches(recentSearches: storageManager.fetchRecentSearches())
    }
}
