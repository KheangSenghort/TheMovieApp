//
//  SearchCoordinator.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import Foundation

protocol SearchCoordinatorInput: class {
    func presentMovieCoordinator(forSearchText searchText: String)
}

/**
 Coordinates the creation as well as presence and dismissal of the search module.
 */
class SearchCoordinator: Coordinator {
    
    lazy var homeViewController: SearchViewController = {
        let controller = SearchViewController()
        let presenter = SearchPresenter()
        presenter.view = controller
        presenter.coordinator = self
        let interactor = SearchInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        controller.output = presenter
        return controller
    }()
    
    override init(router: RouterType) {
        super.init(router: router)
        router.setRootModule(homeViewController, hideBar: false)
    }
}

extension SearchCoordinator: SearchCoordinatorInput {
    
    func presentMovieCoordinator(forSearchText searchText: String) {
        
        let coordinator = MoviesCoordinator(withSearchString: searchText, router: router)
        
        // Maintain a strong reference to avoid deallocation
        addChild(coordinator)
        
        router.push(coordinator, animated: true) { [weak self, weak coordinator] in
            guard let weakSelf = self, let weakMovieCoordinator = coordinator else {
                return
            }
            
            if (weakMovieCoordinator.movieListStatus == .available) {
                //update recent searches
                weakSelf.homeViewController.output.needsUpdateRecentSearch()
                
            } else if (weakMovieCoordinator.movieListStatus == .error) {
                //show error.
                weakSelf.homeViewController.showErrorAlert(withTitle: "Oops !!", message: "Something went wrong 🤷‍♂️ \n Try searching with another keyword.")
            }
            
            weakSelf.removeChild(weakMovieCoordinator)
        }
    }
}
