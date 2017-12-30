//
//  AppDelegate.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var config: ConfigType = Config(bundle: .main, locale: .current)
    private lazy var appNavigationController: UINavigationController = UINavigationController()
    private lazy var appRouter: RouterType = Router(navigationController: self.appNavigationController)
    private lazy var rootCoordinator: SearchCoordinator = SearchCoordinator(router: self.appRouter)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCoordinator.toPresentable()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}
