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
import RxDataSources
import RxSwift

class SearchViewController: UIViewController {
    
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    
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
        appearance.titleTextAttributes = DesignConstants.attributesForNavBar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CompanySearchCell.self, forCellReuseIdentifier: "CompanySearchCell")
        bindTableView()
        tableView.delegate = self
        enableDeleteBySwipe()
    }
    
    private func bindTableView() {
        viewModel.displayedSearches
            .bind(to: tableView.rx.items(cellIdentifier: "CompanySearchCell")) { [weak self] indexPath, company, cell in
                if let companySearchCell = cell as? CompanySearchCell {
                    companySearchCell.delegate = self?.viewModel
                    companySearchCell.tickerLabel.text = company.ticker
                    companySearchCell.companyNameLabel.text = company.name
                    companySearchCell.likeButton.isSelected = company.isFavourite as? Bool ?? false
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func enableDeleteBySwipe() {
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] in
            self?.viewModel.removeCompanyFromSearches(company: self!.viewModel.displayedSearches.value[$0.row])
            }).disposed(by: disposeBag)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = DesignConstants.activityIndicatorColor
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
    
    func showError(for errorMessage: String) {
        let alertController = UIAlertController(title: "Ups!", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
    
    func startSpinning() {
        activityIndicator.startAnimating()
    }
    
    func stopSpinning() {
        activityIndicator.stopAnimating()
    }

    func collapseSearchBar() {
        // collapse search bar to indicate that something has been found
        searchController.isActive = false
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
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    // filter the tableView by user input in the searchBar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.applySearchFilter(for: searchText)
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DesignConstants.cellHeight
    }
}


