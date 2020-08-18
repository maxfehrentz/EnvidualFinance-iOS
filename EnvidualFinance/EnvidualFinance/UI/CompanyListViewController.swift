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


class CompanyListViewController: UIViewController {
    
    private let tableView = UITableView()
    private var companies = [CompanyData]()
    private var activityIndicator = UIActivityIndicatorView()
    

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
        adapter.startObservingFavorites()
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(activityIndicator.snp.width)
        }
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.barTintColor = Constants.envidualBlue
        let navigationTitleFont = UIFont.systemFont(ofSize: 29, weight: .light)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationTitleFont, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "CompanyCell")
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
    }
    
}


extension CompanyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        cell.ticker = companies[indexPath.row].ticker
        cell.name = companies[indexPath.row].name
        cell.marketCapitalization = companies[indexPath.row].marketCapitalization as? Float
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
}
