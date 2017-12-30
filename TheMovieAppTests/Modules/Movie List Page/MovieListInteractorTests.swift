//
//  MovieListInteractorTests.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import XCTest
@testable import TheMovieApp

final class MovieListInteractorTests: XCTestCase {

    private var moviesInteractor: MoviesInteractor!
    private var output: MockMovieListInteractorOutput!
    private var movieListService: MockMovieListService!
    private let searchString = "Mehul Returns !!"

    override func setUp() {
        super.setUp()
        output = MockMovieListInteractorOutput()
        movieListService = MockMovieListService()
        moviesInteractor = MoviesInteractor(searchText: searchString, movieListService: movieListService)
        moviesInteractor.output = output
    }

    func testFetchFirstPageListCallsServiceCorrectly() {
        moviesInteractor.fetchFirstPageList()
        XCTAssertTrue(movieListService.isGetMoviesForQueryTextCalled)

        XCTAssertEqual(movieListService.requestForQuery.pageNumber, 1)
        XCTAssertEqual(movieListService.requestForQuery.queryText, searchString)
    }

    func testfetchNextPageIfAvailableCallsServiceCorrectly() {
        //mock complete response to obtain total pages
        //for every call to fetchNextPageIfAvailable(), check movieListService.requestForQuery.pageNumber
        //page numbers should be incremental.
        //no more calls once total pages is reached.
    }
}
