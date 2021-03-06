//
//  RouterType.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

/**
 Provides a wrapper around UINavigationController.
 There is just 1 router object, and the coordinators are responsible for maintaining
 the navigation stack for the router. The router looks after the presentation, dismissal,
 and transition amongst different view controllers in the nvigation hierarchy.
 */
protocol RouterType: class, Presentable {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func present(_ module: Presentable, animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
    func popModule(animated: Bool)
    func setRootModule(_ module: Presentable, hideBar: Bool)
    func popToRootModule(animated: Bool)
}
