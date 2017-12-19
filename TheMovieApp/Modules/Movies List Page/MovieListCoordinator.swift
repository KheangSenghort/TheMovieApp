//
//  MovieListCoordinator.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

protocol MovieListCoordinatorInput: class {
    
}

/**
 Coordinates the creation as well as presence and dismissal of the Movies list module.
 */
class MoviesCoordinator: Coordinator   {
    
    lazy var viewController: MovieListViewController = {
        let controller = MovieListViewController()
        let presenter = MoviesPresenter()
        presenter.view = controller
        presenter.coordinator = self
        let interactor = MoviesInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        controller.output = presenter
        
        return controller
    }()
    
    /// We must override toPresentable() so it doesn't
    /// default to the router's navigationController
    override func toPresentable() -> UIViewController {
        return viewController
    }
}

extension MoviesCoordinator : MovieListCoordinatorInput {
    
}
