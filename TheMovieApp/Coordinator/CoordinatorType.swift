//
//  CoordinatorType.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

/**
 This is a link between the Router, and the individual modules. It is respnsible for
 1. Presenting the relevant view-controller for it's own module,
 2. Creating the coordinator for the next module to be presented, and passing the appropriate data if needed
 3. Keep track of the modules that are pushed above the current module, on the router.
 */
protocol CoordinatorType: Presentable {
    var router: RouterType { get }
}
