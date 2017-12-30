//
//  StorageTests.swift
//  TheMovieAppTests
//
//  Created by Parmar, Mehul on 21/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit
import XCTest
@testable import TheMovieApp

final class StorageTests: XCTestCase {
    private var storage: UserDefaultsStorageImplementation!
    private var mockUserDefaults: MockUserDefaults!

    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        storage = UserDefaultsStorageImplementation(userDefaults: mockUserDefaults)
    }

    func testResetStorage() {
        storage.resetStorage()
        XCTAssertTrue(mockUserDefaults.isSetValueForKeyCalled)
        XCTAssertNil(mockUserDefaults.newValue)
    }

    func testFetchRecentSearches() {
        mockUserDefaults.returnValue = ["ABC", "XYZ"]
        let recentSearches = storage.fetchRecentSearches()
        XCTAssertTrue(mockUserDefaults.isValueForKeyCalled)
        XCTAssertEqual(recentSearches, ["ABC", "XYZ"])
    }

    func testAddSuccessfulRecentSearchForStringSameAsLastSearch() {
        mockUserDefaults.returnValue = ["ABC", "XYZ"]
        storage.addSuccessfulRecentSearch(recentSearch: "ABC") { needsUpdate in
            XCTAssertFalse(needsUpdate)
        }
        XCTAssertFalse(mockUserDefaults.isSetValueForKeyCalled)
    }

    func testAddSuccessfulRecentSearchForNewString() {
        mockUserDefaults.returnValue = ["ABC", "XYZ"]
        storage.addSuccessfulRecentSearch(recentSearch: "PQR") { needsUpdate in
            XCTAssertTrue(needsUpdate)
        }
        XCTAssertTrue(mockUserDefaults.isSetValueForKeyCalled)
        XCTAssertNotNil(mockUserDefaults.newValue as? [String])
        XCTAssertEqual(mockUserDefaults.newValue as! [String], ["PQR", "ABC", "XYZ"])
    }

    func testAddSuccessfulRecentSearchForExistingString() {
        mockUserDefaults.returnValue = ["ABC", "PQR", "XYZ"]
        storage.addSuccessfulRecentSearch(recentSearch: "PQR") { needsUpdate in
            XCTAssertTrue(needsUpdate)
        }
        XCTAssertTrue(mockUserDefaults.isSetValueForKeyCalled)
        XCTAssertNotNil(mockUserDefaults.newValue as? [String])
        XCTAssertEqual(mockUserDefaults.newValue as! [String], ["PQR", "ABC", "XYZ"])
    }
}
