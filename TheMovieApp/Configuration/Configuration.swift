//
//  Configuration.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

enum Environment: String {
    case debug
    case mock
    case qa
    case release
}

class Config: ConfigType {
    
    let apiVersion: String
    let apiEndpoint: String
    let APIKey: String
    
    let environment: Environment
    let buildNumber: String
    let locale: Locale
    
    lazy var baseURLString = self.apiEndpoint + self.apiVersion + "/"
    
    required init(bundle: Bundle, locale: Locale) {
        self.locale = locale
        
        let endpoints = bundle.object(forInfoDictionaryKey: "API Endpoints") as! [String: String]
        let env = bundle.object(forInfoDictionaryKey: "Environment") as! String
        
        apiVersion = bundle.object(forInfoDictionaryKey: "API Version") as! String
        APIKey = bundle.object(forInfoDictionaryKey: "API Key") as! String
        apiEndpoint = endpoints[env]!
        
        environment = Environment(rawValue: env.lowercased()) ?? .release
        buildNumber = bundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}

