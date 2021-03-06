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
    private(set) lazy var viewModel = SearchViewModel(errorDelegate: self)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        setupSearchController()
        setupTableView()
        setupActivityIndicator()
        layout()
        viewModel.startObservingSearches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.searchController = searchController
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.topItem?.searchController = nil
    }

    private func addAllSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        viewModel.searchBarIsActive
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind { [weak self] in self?.searchController.isActive = $0 }
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CompanySearchCell.self, forCellReuseIdentifier: "CompanySearchCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
        bindTableView()
//        tableView.delegate = self
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
        viewModel.showLoading
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
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

}



