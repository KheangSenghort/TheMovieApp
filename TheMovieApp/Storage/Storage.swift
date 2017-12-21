//
//  Storage.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
    Classes implementing this protocol provide a storage/persistance layer that saves and retrives
    recent search data fomr it's respective backing store.
 */

protocol Storage {//maybe rename to SearchStorage
    func resetStorage()
    func fetchRecentSearches() -> [String]
    func addSuccessfulRecentSearch(recentSearch: String, completion: (Bool) -> Void)
}
