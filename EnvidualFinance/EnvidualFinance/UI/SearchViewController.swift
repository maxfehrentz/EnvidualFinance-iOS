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
    
    private var searchController = UISearchController()
    private var tableView = UITableView()
    private var activityIndicator = UIActivityIndicatorView()
    private var previousSearches = [CompanyData]()
    // displayedSearches is necessary to filter already exisiting searches by their ticker
    private var displayedSearches = [CompanyData]()
    
    lazy var adapter: NativeViewModel = NativeViewModel(
        viewUpdate: { [weak self] company in
            self?.viewUpdate(for: company)
        }, errorUpdate: { [weak self] errorMessage in
            self?.errorUpdate(for: errorMessage)
        }
    )
    
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
        adapter.startObservingSearches()
    }
    
    deinit {
        adapter.onDestroy()
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
    
    private func viewUpdate(for companies: [CompanyData]) {
        previousSearches = companies
        // reverse the searches to show latest first
        previousSearches.reverse()
        displayedSearches = previousSearches
        tableView.reloadData()
        activityIndicator.stopAnimating()
        // makes search bar collaps to indicate that something has been found
        searchController.isActive = false
    }
    
    private func errorUpdate(for errorMessage: String) {
        let alertController = UIAlertController(title: "Ups!", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        activityIndicator.stopAnimating()
        present(alertController, animated: true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // make the searchbar text uppercased to avoid problems
        if let possibleTicker = searchBar.text?.uppercased() {
            // check if a company with this ticker is already in the list; if it is, we don't want to start a new request
            let companiesMappedToTickers = displayedSearches.map { company in
                company.ticker
            }
            if companiesMappedToTickers.contains(possibleTicker) {
                return
            }
            // if it is not in the list, we start a new request
            activityIndicator.startAnimating()
            adapter.getCompanyByTicker(ticker: possibleTicker)
        }
    }
    
    // function restores the displayedSearches to show everything in the tableView
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        displayedSearches = previousSearches
        tableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanySearchCell", for: indexPath) as! CompanySearchCell
        cell.delegate = self
        cell.ticker = displayedSearches[indexPath.row].ticker
        cell.name = displayedSearches[indexPath.row].name
        cell.isFavorite = displayedSearches[indexPath.row].isFavourite as? Bool
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DesignConstants.cellHeight
    }
    
}

extension SearchViewController: SearchDelegate {
    
    func addCompanyToFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches {
            if ticker == displayedSearch.ticker {
                adapter.addFavorite(company: displayedSearch)
                break
            }
        }
    }
    
    func removeCompanyFromFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches {
            if ticker == displayedSearch.ticker {
                adapter.removeFavorite(company: displayedSearch)
                break
            }
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    // filter the tableView by user input in the searchBar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            displayedSearches = previousSearches.filter { company in
                company.ticker!.localizedCaseInsensitiveContains(searchText)
            }
        }
        tableView.reloadData()
    }
    
}


