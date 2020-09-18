//
//  CompanyListViewController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 12.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit
import shared
import SnapKit
import RxDataSources
import RxSwift


class FavouritesViewController: UIViewController {
    
    private lazy var viewModel = FavouritesViewModel(errorDelegate: self)
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private var companyForSegue: CompanyData?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        setupTableView()
        setupActivityIndicator()
        layout()
        viewModel.startObservingFavourites()
    }
    
    private func addAllSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    
    private func layout() {
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
                .multipliedBy(DesignConstants.activityIndicatorWidthAndHeightToSuperview)
            make.height.equalTo(activityIndicator.snp.width)
        }
        
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "CompanyCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
        // create binding between viewModel and tableView
        bindTableView()
        // prepare the tableView to make segues possible later on
        setupSegues()
        // enable deleting
        enableDeleteBySwipe()
    }
    
    private func bindTableView() {
        viewModel.companies
            .bind(to: tableView.rx.items(cellIdentifier: "CompanyCell")) { indexPath, company, cell in
                if let companyCell = cell as? CompanyCell {
                    companyCell.tickerLabel.text = company.ticker
                    companyCell.companyNameLabel.text = company.name
                    if let marketCap = company.marketCapitalization, let currency = company.currency {
                        companyCell.marketCapitalizationLabel.text =  "\(marketCap) \(currency)"
                    }
                    else {
                        companyCell.marketCapitalizationLabel.text = ""
                    }
                    companyCell.configureShadow()
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func setupSegues() {
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] in
            self?.companyForSegue = self?.viewModel.companies.value[$0.row]
            self?.performSegue(withIdentifier: "SegueToCompanyDetails", sender: self)
        }).disposed(by: disposeBag)
    }
    
    private func enableDeleteBySwipe() {
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] in
            self?.viewModel.removeFavourite(company: self!.viewModel.companies.value[$0.row])
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToCompanyDetails" {
            if let viewController = segue.destination as? CompanyViewController {
                viewController.viewModel = CompanyViewModel(company: self.companyForSegue!)
            }
        }
    }
}
