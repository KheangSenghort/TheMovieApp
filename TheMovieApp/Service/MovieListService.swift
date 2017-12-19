//
//  MovieListService.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
    Provides a service layer to fetch data from API, parse the data, and handle the errors.
 */

protocol MovieListService {
    typealias Completion = (MovieListResponse) -> Void
    func getMoviesForQueryText(request: MovieListRequest, completion: Completion)
}

struct MovieListResponse {
    enum Status {
        case success
        case error
    }
    
    let status: Status
}

struct MovieListRequest {
    let queryText: String
    let pageNumber: Int
}
