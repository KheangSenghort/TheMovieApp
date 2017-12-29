//
//  SearchPresenter.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewOutput {
    func viewIsReady()
    func getTitleForSearchPage() -> String
    func getTitleForSearchButton() -> String
    
    func userActivatedTextField()
    func userTappedOnSearchButton(withSearchText searchText: String)
    func userDeactivatedTextField()
    
    func needsUpdateRecentSearch()
    func recentSearchCount() -> Int
    func cellViewModelForRow(atIndexPath indexPath: IndexPath) -> RecentSearchCellDataModel
    func user(didSelectRecentSearchAt indexPath: IndexPath)
}

protocol SearchInteractorOutput: class {
    func updateWithRecentSearches(recentSearches: [String])
}

/**
    Contains view logic for preparing content for display, and react to user inputs.
    Requests data from the interactor when needed.
 */

class SearchPresenter {
    
    weak var view: SearchViewInput?
    var interactor: SearchInteractorInput!
    var coordinator: SearchCoordinatorInput!//TODO: check for reference cycle
    var searchText = ""
    
    private var recentSearches = [RecentSearchCellDataModel]()
    
    init() {
        registerObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //can be moved to a seperate 'EventHandler' class.
    private func registerObservers() {
        let center = NotificationCenter.default
        center.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self] notification in
            
            let userInfo = notification.userInfo
            let keyboardFrame = userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
            self?.view?.keyboardPresented(withHeight: keyboardFrame?.height ?? CGFloat(0.0))
        }
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewIsReady() {
        view?.hideRecentSearchTable()
        interactor.fetchRecentSearches()
    }
    
    func userActivatedTextField() {
        if recentSearchCount() > 0 {
            view?.showRecentSearchTable()
        }
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
        let selectedSearch = recentSearches[indexPath.row]
        view?.updateTextFieldWithRecentSearch(searchString: selectedSearch.searchText)
    }
    
    func userTappedOnSearchButton(withSearchText searchText: String) {
        if isValidSearchText(searchText: searchText) {
            self.searchText = searchText
            coordinator.presentMovieCoordinator(forSearchText: searchText)
        }
    }
    
    func needsUpdateRecentSearch() {
        interactor.insertRecentSearch(searchString: searchText)
    }
    
    func getTitleForSearchPage() -> String {
        return "Search"
    }
    
    func getTitleForSearchButton() -> String {
        return "🔍"
    }
    
    private func isValidSearchText(searchText: String) -> Bool {
        return !searchText.isEmpty
    }
}

extension SearchPresenter: SearchInteractorOutput {
    
    func updateWithRecentSearches(recentSearches: [String]) {
        self.recentSearches = recentSearches.map {RecentSearchCellDataModel(searchText: $0)}
        view?.refreshRecentSearchData()
    }
}

struct RecentSearchCellDataModel {
    let searchText: String
}
