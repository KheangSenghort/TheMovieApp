//
//  MovieListServiceBuilder.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 20/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
    The MovieListServiceBuilder takes the app config from AppDelegate, extracts only what is
    useful to the service, and passes only that information to the newly created service class.
 */
struct MovieListServiceBuilder {

    let configuration: ConfigType // the base URl, env., etc.
    
    init(config: ConfigType = Config(bundle: Bundle.main, locale: Locale.current)) {
        configuration = config
    }
    
    func build() -> MovieListService {        
        let baseURLString = configuration.baseURLString
        let APIKey = configuration.APIKey
        return MovieListServiceImplementation(baseURLString: baseURLString, APIKey: APIKey)
    }
}
