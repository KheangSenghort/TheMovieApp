//
//  SearchPresenterTests.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import XCTest
import Foundation
@testable import TheMovieApp

final class SearchPresenterTests: XCTestCase {

    var presenter: SearchPresenter!
    var coordinator: MockSearchCoordinatorInput!
    var view: MockSearchViewInput!
    var interactor: MockSearchInteractorInput!

    override func setUp() {
        super.setUp()
        coordinator = MockSearchCoordinatorInput()
        view = MockSearchViewInput()
        interactor = MockSearchInteractorInput()

        presenter = SearchPresenter()
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        presenter.view = view
    }

    func testRecentSearchTableIsHiddenWhenViewLoads() {
        presenter.viewIsReady()
        XCTAssertTrue(view.isHideRecentSearchTableCalled)
    }

    func testRecentSearchTableShowsWhenTextFieldIsActivated() {
        presenter.userActivatedTextField()
        XCTAssertFalse(view.isShowRecentSearchTableCalled)

        presenter.updateWithRecentSearches(recentSearches: ["ABC", "XYZ"])
        presenter.userActivatedTextField()
        XCTAssertTrue(view.isShowRecentSearchTableCalled)
    }

    func testRecentSearchTableHidesWhenTextFieldIsDeactivated() {
        presenter.userDeactivatedTextField()
        XCTAssertTrue(view.isHideRecentSearchTableCalled)
    }

    func testUpdatedRecentSearchDataUpdatesView() {
        presenter.updateWithRecentSearches(recentSearches: ["ABC", "XYZ"])
        XCTAssertTrue(view.isRefreshRecentSearchDataCalled)
    }

    func testSelectingRecentSearchRowUpdatesTextField() {
        presenter.updateWithRecentSearches(recentSearches: ["ABC", "XYZ"])
        presenter.user(didSelectRecentSearchAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(view.isUpdateTextFieldWithRecentSearchCalled)
        XCTAssertEqual(view.recentSearchStringToUpdate, "ABC")
    }

    func testPresenterAsksInteractorToUpdateRecentSearches() {
        presenter.needsUpdateRecentSearch()
        XCTAssertTrue(interactor.isInsertRecentSearchCalled)
    }

    func testMovieListPagePresentedForValidString() {
        presenter.userTappedOnSearchButton(withSearchText: "Valid Text")
        XCTAssertTrue(coordinator.isPresentMovieCoordinatorCalled)
        XCTAssertEqual(coordinator.presentMovieListPageForString, "Valid Text")
    }

    func testMovieListPageNOTPresentedForEmptyString() {
        presenter.userTappedOnSearchButton(withSearchText: "")
        XCTAssertFalse(coordinator.isPresentMovieCoordinatorCalled)
    }

    func testKeyboardWillShowNotificationUpdatesView() {
        NotificationCenter.default.post(name: Notification.Name.UIKeyboardWillShow, object: nil)
        XCTAssertTrue(view.isKeyboardPresentedCalled)
    }
}
