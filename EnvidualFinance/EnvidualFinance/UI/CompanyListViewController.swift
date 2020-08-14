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


class CompanyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var data = [CompanyData]()
    

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
        setupNavigationBar()
        setupTableView()
        adapter.getCompanyByTicker(ticker: "AAPL")
        adapter.getCompanyByTicker(ticker: "AAPL")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        adapter.onDestroy()
    }
    
    private func viewUpdate(for company: CompanyData) {
        data.append(company)
        tableView.reloadData()
    }
    
    private func errorUpdate(for errorMessage: String) {
        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true, completion: nil)
    }
    
    private func addAllSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Companies"
//        navigationController?.navigationBar.titleTextAttributes =
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "CompanyCell")
    }
    
    private func layoutTableView() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        cell.ticker = data[indexPath.row].ticker
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CompanyListConstants.cellHeight
    }

}


//class BreedsViewController: UIViewController {
//
//    @IBOutlet weak var breedTableView: UITableView!
//    var data: [Breed] = []
//
//    let log = koin.get(objCClass: Kermit.self, parameter: "ViewController") as! Kermit
//
//    lazy var adapter: NativeViewModel = NativeViewModel(
//        viewUpdate: { [weak self] summary in
//            self?.viewUpdate(for: summary)
//        }, errorUpdate: { [weak self] errorMessage in
//            self?.errorUpdate(for: errorMessage)
//        }
//    )
//
//    // MARK: View Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        breedTableView.dataSource = self
//
//        //We check for stalk data in this method
//        adapter.getBreedsFromNetwork()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        adapter.onDestroy()
//    }
//
//    // MARK: BreedModel Closures
//
//    private func viewUpdate(for summary: ItemDataSummary) {
//        log.d(withMessage: {"View updating with \(summary.allItems.count) breeds"})
//        data = summary.allItems
//        breedTableView.reloadData()
//    }
//
//    private func errorUpdate(for errorMessage: String) {
//        log.e(withMessage: {"Displaying error: \(errorMessage)"})
//        let alertController = UIAlertController(title: "error", message: errorMessage, preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//        present(alertController, animated: true, completion: nil)
//    }
//
//}
//
//// MARK: - UITableViewDataSource
//extension BreedsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell", for: indexPath)
//        if let breedCell = cell as? BreedCell {
//            let breed = data[indexPath.row]
//            breedCell.bind(breed)
//            breedCell.delegate = self
//        }
//        return cell
//    }
//}
//
//// MARK: - BreedCellDelegate
//extension BreedsViewController: BreedCellDelegate {
//    func toggleFavorite(_ breed: Breed) {
//        adapter.updateBreedFavorite(breed: breed)
//    }
//}
