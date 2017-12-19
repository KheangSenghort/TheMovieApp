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
    private let recentSearchesKey = "recentSearchesKey"

    func resetStorage() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: recentSearchesKey)
        userDefaults.synchronize()
    }
    
    func fetchRecentSearches() -> [String] {
        return UserDefaults.standard.value(forKey: recentSearchesKey) as? [String] ?? [String]()
    }
    
    func addSuccessfulRecentSearch(recentSearch: String, completion: (Bool) -> Void) {
        var recentSearches: [String] = fetchRecentSearches()
        
        let index: Int? = recentSearches.index { (searchItem: String) -> Bool in
            return searchItem.lowercased() == recentSearch.lowercased()
        }
        
        if let currentIndex = index {
            if currentIndex == 0 {
                completion(false)
                return
            }
            recentSearches.remove(at: currentIndex)
        }
        //TODO: Keep only 10 items in 'recentSearches'
        recentSearches.insert(recentSearch, at: 0)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(recentSearches, forKey: recentSearchesKey)
        userDefaults.synchronize()
        
        completion(true)
    }
}
