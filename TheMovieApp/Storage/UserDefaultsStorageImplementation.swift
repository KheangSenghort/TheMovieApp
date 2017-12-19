//
//  UserDefaultsStorageImplementation.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
 Provide a NSUserDefaults based storage for recent searches.
 */

class UserDefaultsStorageImplementation : Storage {
    
    func resetStorage() {
        
    }
    
    func fetchRecentSearches() -> [String] {
        return ["", ""]
    }
    
    func addSuccessfulRecentSearch(recentSearch: String, completion: (Bool) -> Void) {
        completion(false)
    }
}
