//
//  MovieListService.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
    Provides a service layer to fetch data from API, parse the data, and handle the errors.
 */
protocol MovieListService {
    typealias Completion = (MovieListResponse) -> Void
    func getMoviesForQueryText(request: MovieListRequest, completion: @escaping Completion)
}
