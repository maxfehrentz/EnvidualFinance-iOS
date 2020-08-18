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
        navigationItem.title = "Search"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.envidualBlue
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
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func viewUpdate(for companies: [CompanyData]) {
        previousSearches = companies
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    private func errorUpdate(for errorMessage: String) {
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let possibleTicker = searchBar.text?.uppercased() {
            activityIndicator.startAnimating()
            adapter.getCompanyByTicker(ticker: possibleTicker)
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previousSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanySearchCell", for: indexPath) as! CompanySearchCell
        cell.delegate = self
        cell.ticker = previousSearches[indexPath.row].ticker
        cell.name = previousSearches[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
}

extension SearchViewController: Delegate {
    
    func addCompanyToFavourites(forTicker ticker: String) {
        for previousSearch in previousSearches {
            if ticker == previousSearch.ticker {
                adapter.addFavorite(company: previousSearch)
                break
            }
        }
    }
    
    func removeCompanyFromFavourites(forTicker ticker: String) {
        for previousSearch in previousSearches {
            if ticker == previousSearch.ticker {
                adapter.removeFavorite(company: previousSearch)
                break
            }
        }
    }
    
}

//class CompanyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    private let tableView = UITableView()
//    private var data = [CompanyData]()
//    
//
//    lazy var adapter: NativeViewModel = NativeViewModel(
//        viewUpdate: { [weak self] company in
//            self?.viewUpdate(for: company)
//        }, errorUpdate: { [weak self] errorMessage in
//            self?.errorUpdate(for: errorMessage)
//        }
//    )
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addAllSubviews()
//        setupNavigationBar()
//        setupTabBarItem()
//        setupTableView()
//        adapter.getCompaniesForExplore()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        adapter.onDestroy()
//    }
//    
//    private func viewUpdate(for companies: [CompanyData]) {
//        data += companies
//        tableView.reloadData()
//    }
//    
//    private func errorUpdate(for errorMessage: String) {
//        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    private func addAllSubviews() {
//        view.addSubview(tableView)
//    }
//    
//    private func setupNavigationBar() {
//        navigationItem.title = "Favorites"
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
//    }
//    
//    private func setupTabBarItem() {
//        title = "Favourites"
//    }
//    
//    private func setupTableView() {
//        layoutTableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(CompanyCell.self, forCellReuseIdentifier: "CompanyCell")
//    }
//    
//    private func layoutTableView() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
//        cell.ticker = data[indexPath.row].ticker
//        cell.name = data[indexPath.row].name
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CompanyListConstants.cellHeight
//    }
//
//}


