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
    
    private let viewModel = FavouritesViewModel()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private var companyForSegue: CompanyData?

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        layout()
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
        viewModel.vc = self
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
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func showError(for errorMessage: String) {
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true, completion: nil)
    }
    
    func startSpinning() {
        activityIndicator.startAnimating()
    }
    
    func stopSpinning() {
        activityIndicator.stopAnimating()
    }
    
}


extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.companies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        let model = viewModel.companies[indexPath.section]
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
    
    // handle deleting
    func tableView(_ tableView: UITableView, canEditSection indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            viewModel.removeFavourite(company: viewModel.companies[indexPath.section])
        }
    }
    
    // preparation for segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        companyForSegue = viewModel.companies[indexPath.section]
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
