//
//  SearchViewController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 14.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import shared
import SnapKit

class SearchViewController: UIViewController {
    
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let viewModel = SearchViewModel()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
        layout()
        viewModel.vc = self
        viewModel.startObservingSearches()
    }

    private func addAllSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.title = "Search"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = DesignConstants.navConBlue
        let navigationTitleFont = UIFont.systemFont(ofSize: 29, weight: .light)
        appearance.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CompanySearchCell.self, forCellReuseIdentifier: "CompanySearchCell")
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
    }
    
    private func layout() {
        tableView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(DesignConstants.activityIndicatorWidthAndHeightToSuperview)
            make.height.equalTo(activityIndicator.snp.width)
        }
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func showError(for errorMessage: String) {
        let alertController = UIAlertController(title: "Ups!", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        activityIndicator.stopAnimating()
        present(alertController, animated: true, completion: nil)
    }
    
    func startSpinning() {
        activityIndicator.startAnimating()
    }
    
    func stopSpinning() {
        activityIndicator.stopAnimating()
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchForCompany(with: searchBar.text)
    }
    
    // function restores the displayedSearches to show everything in the tableView
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.restoreDisplayedSearches()
    }
    
    func collapseSearchBar() {
        // collapse search bar to indicate that something has been found
        searchController.isActive = false
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayedSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanySearchCell", for: indexPath) as! CompanySearchCell
        cell.delegate = viewModel
        let model = viewModel.displayedSearches[indexPath.row]
        cell.tickerLabel.text = model.ticker
        cell.companyNameLabel.text = model.name
        cell.likeButton.isSelected = (model.isFavourite as? Bool) ?? false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DesignConstants.cellHeight
    }
    
}


extension SearchViewController: UISearchResultsUpdating {
    
    // filter the tableView by user input in the searchBar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.applySearchFilter(for: searchText)
        }
    }
    
}


