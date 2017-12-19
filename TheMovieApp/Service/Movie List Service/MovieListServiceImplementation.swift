//
//  MovieListServiceImplementation.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
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
        
        //TODO: how to test? maybe a mock class with same name, and check for method call...
        Alamofire.request(requestURLString).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            let decoder = JSONDecoder()
            do {
                let listViewModel = try decoder.decode(MovieListDataModel.self, from: response.data!)
                completion(MovieListResponse(status: .success(listViewModel: listViewModel)))
            } catch {
                print(error)//
                completion(MovieListResponse(status: .failure(error: error)))
            }
        }
    }
    
    private func getMovieSearchURL(forRequest request: MovieListRequest) -> String? {
        let encodedQueryText = request.queryText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if let encodedQueryText = encodedQueryText {
            let movieSearchURL = "\(baseURLString + APIEndpoint)?api_key=\(APIKey)&query=\(encodedQueryText)&page=\(request.pageNumber)"
            print(movieSearchURL) //TODO: remove all print
            return movieSearchURL
        }
        return nil
    }
}
