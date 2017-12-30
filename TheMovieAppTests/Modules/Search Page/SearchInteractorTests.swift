//
//  SearchInteractorTests.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import XCTest
@testable import TheMovieApp

final class SearchInteractorTests: XCTestCase {
    private var interactor: SearchInteractor!
    private var output: MockSearchInteractorOutput!
    private var storage: MockStorage!

    override func setUp() {
        super.setUp()
        output = MockSearchInteractorOutput()
        storage = MockStorage()
        interactor = SearchInteractor(storageManager: storage)
        interactor.output = output
    }

    func testInsertRecentSearchAddsSearchStringAndUpdatesPresenter() {
        interactor.insertRecentSearch(searchString: "ABC")
        XCTAssertTrue(storage.isAddSuccessfulRecentSearchCalled)
        XCTAssertTrue(output.isUpdateWithRecentSearchesCalled)
    }

    func testFetchRecentSearchFetchesFromTheStoreAndUpdatesPresenter() {
        interactor.fetchRecentSearches()
        XCTAssertTrue(storage.isFetchRecentSearchesCalled)
        XCTAssertTrue(output.isUpdateWithRecentSearchesCalled)
    }
}
