//
//  MovieListViewController.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul (Agoda) on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

protocol MovieListViewInput: class {
    func reloadTable()
    func removeFetchingMoreSpinner()
    func dismiss()
}

class MovieListViewController: UIViewController {
    private let cellReuseIdentifier = "MovieCellView"
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var output: MovieListViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        view.addSubview(tableView)
        
        let movieCellNib = UINib(nibName: "MovieCell", bundle: nil)//move to some nibLoadable protocol.
        tableView.register(movieCellNib, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.allowsSelection = false
        
        setupConstraints()
        view.backgroundColor = .lightGray
        output.viewIsReady()
    }
    
    private func setupConstraints () {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        tableView.tableFooterView = UIView()
        output.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output.viewWillDisappear()
    }
}

extension MovieListViewController : MovieListViewInput {
    func reloadTable() {
        tableView.reloadData()
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func removeFetchingMoreSpinner() {
        tableView.backgroundView = nil
        tableView.tableFooterView = UIView()
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MovieListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MovieCell
            else {
                return UITableViewCell()
        }
        
        let cellViewModel = output.cellViewModelForRow(atIndexPath: indexPath)
        cell.configure(withModel: cellViewModel)
        return cell
    }
}

extension MovieListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetching \(indexPaths.first!.row) to \(indexPaths.last!.row)")
        output.fetchNextCellsIfAvailable()
    }
}
