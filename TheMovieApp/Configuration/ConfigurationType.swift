//
//  ConfigurationType.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

/**
 Provides App-level information such as the build number, API key/token, environment, locale, etc.
 This information is read from Info.plist 
 */
protocol ConfigType {
    var apiVersion: String { get }
    var apiEndpoint: String { get }
    var baseURLString: String { get }
    var APIKey: String { get }

    var environment: Environment { get }
    var buildNumber: String { get }
    var locale: Locale { get }
    init(bundle: Bundle, locale: Locale)
}
