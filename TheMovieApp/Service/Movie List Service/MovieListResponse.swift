//
//  MovieListResponse.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
 The JSON response from API gets parsed to this struct.
 */
struct MovieListDataModel: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    
    struct Movies: Codable {
        let id: Int
        let title: String
        let poster_path: String?
        let overview: String?
        let release_date : String? //"YYYY-MM-DD"
        var completePosterURLString: String?
    }
    
    let results: [Movies]
}

struct MovieListResponse {
    enum Status {
        case success(listViewModel: MovieListDataModel)
        case validationIssue(message: String)
        case failure(error: Error)
    }
    
    let status: Status
}
