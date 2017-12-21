//
//  SearchViewController.swift
//  TheMovieApp
//
//  Created by Parmar, Mehul on 19/12/17.
//  Copyright © 2017 Mehul Parmar. All rights reserved.
//

import UIKit

protocol SearchViewInput: class {
    func showRecentSearchTable()
    func hideRecentSearchTable()
    func refreshRecentSearchData()
    func showErrorAlert(withTitle title: String, message: String)
    func updateTextFieldWithRecentSearch(searchString: String)
}

/**
    Displays the search page containing search textfield, search button, and recent search table.
    Relays user input back to the Presenter.
 */
class SearchViewController: UIViewController {
    
    let searchButton = UIButton()
    let textField = UITextField()
    let recentSearchTable = UITableView()
    
    var output: SearchViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(searchButton)
        view.addSubview(textField)
        view.addSubview(recentSearchTable)
        
        searchButton.addTarget(self, action: #selector(didTapSearchButton(_:)), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        recentSearchTable.delegate = self
        recentSearchTable.dataSource = self
        recentSearchTable.estimatedRowHeight = 45.0
        recentSearchTable.rowHeight = UITableViewAutomaticDimension
        recentSearchTable.tableFooterView = UIView()
        recentSearchTable.backgroundColor = .white
        recentSearchTable.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = output.getTitleForSearchPage()
        searchButton.setTitle(output.getTitleForSearchButton(), for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        textField.placeholder = " Enter movie to search"
    }
    
    private func setupConstraints () {
        let padding: CGFloat = 8 // left/right padding
        let verticalSpacing: CGFloat = 20
        
        searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalSpacing).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalSpacing).isActive = true
        textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        textField.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -padding).isActive = true
        textField.heightAnchor.constraint(equalTo: searchButton.heightAnchor).isActive = true
        
        recentSearchTable.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: verticalSpacing).isActive = true
        recentSearchTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: padding).isActive = true
        recentSearchTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -padding).isActive = true
        recentSearchTable.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
    }
    
    @objc func didTapSearchButton(_ sender: UIButton) {
        self.textField.endEditing(true)
        output.userTappedOnSearchButton(withSearchText: textField.text ?? "")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.recentSearchCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SearchCell")
        let cellViewModel = output.cellViewModelForRow(atIndexPath: indexPath)
        cell.textLabel?.text = cellViewModel.searchText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.user(didSelectRecentSearchAt: indexPath)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        output.userActivatedTextField()
        //TODO: check keyboard notification and resize recentSearchTable accordingly.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        output.userDeactivatedTextField()
    }
}

extension SearchViewController : SearchViewInput {
    func showErrorAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Okay 😕", style: .cancel, handler: nil)
        alert.addAction(alertButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRecentSearchTable() {
        recentSearchTable.isHidden = false
    }
    
    func hideRecentSearchTable() {
        recentSearchTable.isHidden = true
    }
    
    func refreshRecentSearchData() {
        recentSearchTable.reloadData()
    }
    
    func updateTextFieldWithRecentSearch(searchString: String) {
        textField.text = searchString
    }
}
