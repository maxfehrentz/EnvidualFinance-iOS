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


class FavouritesViewController: UIViewController {
    
    private let tableView = UITableView()
    private var companies = [CompanyData]()
    private let activityIndicator = UIActivityIndicatorView()
    private var companyForSegue: CompanyData?
    

    lazy var adapter: NativeViewModel = NativeViewModel(
        viewUpdate: { [weak self] company in
            self?.viewUpdate(for: company)
        }, errorUpdate: { [weak self] errorMessage in
            self?.errorUpdate(for: errorMessage)
        }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        layout()
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
        activityIndicator.startAnimating()
        adapter.startObservingFavourites()
    }
    
    deinit {
        adapter.onDestroy()
    }
    
    private func viewUpdate(for companies: [CompanyData]) {
        self.companies = companies
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    private func errorUpdate(for errorMessage: String) {
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true, completion: nil)
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
                .multipliedBy(DesignConstants.activityIndicatorWidthAndHeightToSuperview)
            make.height.equalTo(activityIndicator.snp.width)
        }
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Favourites"
        navigationController?.navigationBar.barTintColor = DesignConstants.navConBlue
        let navigationTitleFont = UIFont.systemFont(ofSize: 29, weight: .light)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "CompanyCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = DesignConstants.activityIndicatorColor
    }
    
}


extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        let model = companies[indexPath.section]
        cell.tickerLabel.text = model.ticker
        cell.companyNameLabel.text = model.name
        if let value = model.marketCapitalization, let curr = model.currency {
            cell.marketCapitalizationLabel.text = "\(value) \(curr)"
        }
        else {
            cell.marketCapitalizationLabel.text = ""
        }
        cell.configureShadow()
        return cell
    }
        
    
//    // configure cells to look like small cards
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        DesignConstants.spacingBetweenCompanyCells
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        // only the last section gets a footer so that there is space to the TabBar at the bottom
//        if(section == companies.count - 1) {
//            return DesignConstants.spacingBetweenCompanyCells
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView()
//        footerView.backgroundColor = UIColor.clear
//        return footerView
//    }
    
    // handle deleting
    func tableView(_ tableView: UITableView, canEditSection indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            adapter.removeFavourite(company: companies[indexPath.section])
        }
    }
    
    // preparation for segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        companyForSegue = companies[indexPath.section]
        performSegue(withIdentifier: "SegueToCompanyDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToCompanyDetails" {
            if let viewController = segue.destination as? CompanyDetailViewController {
                viewController.company = self.companyForSegue
            }
        }
    }
}
