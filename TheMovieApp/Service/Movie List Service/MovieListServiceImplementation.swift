//
//  MovieListServiceImplementation.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation
import Alamofire

enum MovieListServiceError: Error {
    case invalidQuery
    case genericError
}

class MovieListServiceImplementation: MovieListService {

    private let baseURLString: String
    private let APIKey: String
    private let APIEndpoint = "search/movie"

    init(baseURLString: String, APIKey: String) {
        self.baseURLString = baseURLString
        self.APIKey = APIKey
    }

    func getMoviesForQueryText(request: MovieListRequest, completion: @escaping (MovieListResponse) -> Void) {

        guard let requestURLString = getMovieSearchURL(forRequest: request) else {
            completion(MovieListResponse(status: .failure(error: MovieListServiceError.invalidQuery)))
            return
        }

        Alamofire.request(requestURLString).responseJSON { response in

            let decoder = JSONDecoder()
            do {
                let listViewModel = try decoder.decode(MovieListDataModel.self, from: response.data!)
                completion(MovieListResponse(status: .success(listViewModel: listViewModel)))
            } catch {
                completion(MovieListResponse(status: .failure(error: error)))
            }
        }
    }

    private func getMovieSearchURL(forRequest request: MovieListRequest) -> String? {
        let encodedQueryText = request.queryText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        if let encodedQueryText = encodedQueryText {
            let movieSearchURL = "\(baseURLString + APIEndpoint)?api_key=\(APIKey)&query=\(encodedQueryText)&page=\(request.pageNumber)"
            return movieSearchURL
        }
        return nil
    }
}
