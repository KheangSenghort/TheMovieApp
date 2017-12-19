//
//  Router.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

final class Router: NSObject, RouterType, UINavigationControllerDelegate {
    
    private var completions: [UIViewController : () -> Void]
    
    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        self.navigationController.delegate = self
    }
    
    // MARK: Presentable
    
    func toPresentable() -> UIViewController {
        return navigationController
    }
    
}
