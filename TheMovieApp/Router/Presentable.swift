//
//  Presentable.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

public protocol Presentable {
    func toPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    public func toPresentable() -> UIViewController {
        return self
    }
}

