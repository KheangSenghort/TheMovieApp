//
//  Coordinator.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

class Coordinator: NSObject, CoordinatorType {

    private var childCoordinators: [Coordinator ] = []

    var router: RouterType

    init(router: RouterType) {
        self.router = router
        super.init()
    }

    func addChild(_ coordinator: Coordinator ) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.index(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    func toPresentable() -> UIViewController {
        return router.toPresentable()
    }
}
