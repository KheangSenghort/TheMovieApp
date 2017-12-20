//
//  MockObjects.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul (Agoda) on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit
@testable import TheMovieApp

final class MockRouter: Router {
    
    var isPresentModuleCalled = false
    override func present(_ module: Presentable, animated: Bool) {
        isPresentModuleCalled = true
    }
    
    var isPushModuleCalled = false
    override func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
        isPushModuleCalled = true
        completion?()
    }
    
    var isNavigationControllerDidShowCalled = false
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        isNavigationControllerDidShowCalled = true
    }
    
    var mockViewController = UIViewController()
    var isToPresentableCalled = false
    override func toPresentable() -> UIViewController {
        isToPresentableCalled = true
        return mockViewController
    }
    
    var isSetRootModuleCalled = false
    override func setRootModule(_ module: Presentable, hideBar: Bool) {
        isSetRootModuleCalled = true
    }
}

final class MockCoordinator: Coordinator {
    
    var isAddChildCalled = false
    override func addChild(_ coordinator: Coordinator) {
        isAddChildCalled = true
    }
    
    var isRemoveChildCalled = false
    override func removeChild(_ coordinator: Coordinator) {
        isRemoveChildCalled = true
    }
}

final class MockSearchViewOutput: SearchViewOutput {
    func viewIsReady() {
    }
    
    var isGetTitleForSearchPageCalled = false
    var mockTitle = "MockSearchTitle"
    func getTitleForSearchPage() -> String {
        isGetTitleForSearchPageCalled = true
        return mockTitle
    }
    
    var isGetTitleForSearchButtonCalled = false
    func getTitleForSearchButton() -> String {
        isGetTitleForSearchButtonCalled = true
        return ""
    }
    
    var isUserActivatedTextFieldCalled = false
    func userActivatedTextField() {
        isUserActivatedTextFieldCalled = true
    }
    
    var didUserTappedOnSearchButton = false
    var searchTextWhenTapOnSearchButton = ""
    func userTappedOnSearchButton(withSearchText searchText: String) {
        didUserTappedOnSearchButton = true
        searchTextWhenTapOnSearchButton = searchText
    }
    
    var isUserDeactivatedTextFieldCalled = false
    func userDeactivatedTextField() {
        isUserDeactivatedTextFieldCalled = true
    }
    
    func needsUpdateRecentSearch() {
    }
    
    func recentSearchCount() -> Int {
        return 10
    }
    
    func cellViewModelForRow(atIndexPath indexPath: IndexPath) -> RecentSearchCellDataModel {
        return RecentSearchCellDataModel(searchText: "Last Search")
    }
    
    func user(didSelectRecentSearchAt indexPath: IndexPath) {
    }
}

final class MockSearchCoordinatorInput: SearchCoordinatorInput {
    
    var isPresentMovieCoordinatorCalled = false
    var presentMovieListPageForString = ""
    func presentMovieCoordinator(forSearchText searchText: String) {
        isPresentMovieCoordinatorCalled = true
        presentMovieListPageForString = searchText
    }
}

final class MockSearchViewInput: SearchViewInput {
    
    var isShowRecentSearchTableCalled = false
    func showRecentSearchTable() {
        isShowRecentSearchTableCalled = true
    }
    
    var isHideRecentSearchTableCalled = false
    func hideRecentSearchTable() {
        isHideRecentSearchTableCalled = true
    }
    
    var isRefreshRecentSearchDataCalled = false
    func refreshRecentSearchData() {
        isRefreshRecentSearchDataCalled = true
    }
    
    var isShowErrorAlertCalled = false
    func showErrorAlert(withTitle title: String, message: String) {
        isShowRecentSearchTableCalled = true
    }
    
    var isUpdateTextFieldWithRecentSearchCalled = false
    var recentSearchStringToUpdate = ""
    func updateTextFieldWithRecentSearch(searchString: String) {
        isUpdateTextFieldWithRecentSearchCalled = true
        recentSearchStringToUpdate = searchString
    }
}

final class MockSearchInteractorInput: SearchInteractorInput {
    
    var isInsertRecentSearchCalled = false
    func insertRecentSearch(searchString: String) {
        isInsertRecentSearchCalled = true
    }
    
    var isFetchRecentSearchesCalled = false
    func fetchRecentSearches() {
        isFetchRecentSearchesCalled = true
    }
}

final class MockSearchInteractorOutput: SearchInteractorOutput {
    
    var isUpdateWithRecentSearchesCalled = false
    func updateWithRecentSearches(recentSearches: [String]) {
        isUpdateWithRecentSearchesCalled = true
    }
}

final class MockStorage: Storage {
   
    var isResetStorageCalled = false
    func resetStorage() {
       isResetStorageCalled = true
    }
    
    var isFetchRecentSearchesCalled = false
    func fetchRecentSearches() -> [String] {
       isFetchRecentSearchesCalled = true
        return ["ABC", "XYZ"]
    }
    
    var isAddSuccessfulRecentSearchCalled = false
    func addSuccessfulRecentSearch(recentSearch: String, completion: (Bool) -> Void) {
       isAddSuccessfulRecentSearchCalled = true
        completion(true)
    }
}

final class MockMovieListInteractorOutput: MovieListInteractorOutput {
    
    var isUpdateMovieListWithResultsCalled = false
    func updateMovieListWithResults() {
        isUpdateMovieListWithResultsCalled = true
    }
    
    var isFinishedLoadingAllMoviesCalled = false
    func finishedLoadingAllMovies() {
        isFinishedLoadingAllMoviesCalled = true
    }
    
    var isShowErrorCalled = false
    func showError() {
        isShowErrorCalled = true
    }
}

final class MockMovieListService: MovieListService {
    
    var isGetMoviesForQueryTextCalled = false
    var requestForQuery = MovieListRequest(queryText: "", pageNumber: 0)
    func getMoviesForQueryText(request: MovieListRequest, completion: @escaping MovieListService.Completion) {
        isGetMoviesForQueryTextCalled = true
        requestForQuery = request
    }
}

final class MockUserDefaults : UserDefaults {
    
    var isSetValueForKeyCalled = false
    var newValue: Any? = nil
    var forKey: String = ""
    override func set(_ value: Any?, forKey key: String) {
        isSetValueForKeyCalled = true
        newValue = value
        forKey = key
    }
    
    var isValueForKeyCalled = false
    var requestedValueForKey: String = ""
    var returnValue: Any? = nil
    override func value(forKey key: String) -> Any? {
        isValueForKeyCalled = true
        requestedValueForKey = key
        return returnValue
    }
}
