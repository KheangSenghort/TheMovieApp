//
//  SearchViewControllerTests.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import XCTest
@testable import TheMovieApp

final class SearchViewControllerTests: XCTestCase {
    private var output: MockSearchViewOutput!
    private var viewController: SearchViewController!

    override func setUp() {
        super.setUp()
        output = MockSearchViewOutput()
        viewController = SearchViewController()
        viewController.output = output
    }

    func testSearchTextPassedCorrectlyWhenSearchButtonTapped() {
        viewController.textField.text = "Test Movie"
        viewController.didTapSearchButton(UIButton())

        XCTAssertTrue(output.didUserTappedOnSearchButton)
        XCTAssertEqual(viewController.textField.text, output.searchTextWhenTapOnSearchButton)
    }

    func testViewGetsTitleStringFromPresenter() {
        XCTAssertNil(viewController.title)
        output.mockTitle = "ABC"
        viewController.viewWillAppear(false)

        XCTAssertTrue(output.isGetTitleForSearchPageCalled)
        XCTAssertNotNil(viewController.title)
        XCTAssertEqual(viewController.title, output.mockTitle)
    }

    func testSearchButtonGetsTitleStringFromPresenter() {
        XCTAssertNil(viewController.searchButton.title(for: .normal))
        viewController.viewWillAppear(false)

        XCTAssertTrue(output.isGetTitleForSearchButtonCalled)
        XCTAssertNotNil(viewController.searchButton.title(for: .normal))
    }

    func testTextFieldEditingUpdatesPresenter() {
        viewController.textFieldDidBeginEditing(UITextField())
        XCTAssertTrue(output.isUserActivatedTextFieldCalled)

        viewController.textFieldDidEndEditing(UITextField())
        XCTAssertTrue(output.isUserDeactivatedTextFieldCalled)
    }
}
