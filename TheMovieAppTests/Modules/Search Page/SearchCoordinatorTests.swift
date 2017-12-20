//
//  SearchCoordinatorTests.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul (Agoda) on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import XCTest
@testable import TheMovieApp

final class SearchCoordinatorTests: XCTestCase {

    private var router: MockRouter!
    private var coordinator: SearchCoordinator!
    
    override func setUp() {
        super.setUp()
        router = MockRouter()
    }
    
    func testSearchCoordinatorIsSetAsRootModule() {
        coordinator = SearchCoordinator(router: router)
        XCTAssertTrue(router.isSetRootModuleCalled)
    }
    
    func testPresentMovieCoordinatorPresentsMovieListPage() {
        coordinator = SearchCoordinator(router: router)
        coordinator.presentMovieCoordinator(forSearchText: "Mehul")
        XCTAssertTrue(router.isPushModuleCalled)
    }
}
