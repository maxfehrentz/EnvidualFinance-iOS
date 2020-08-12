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
    
    private let model = CompanyListViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        setupNavigationBar()
        setupTableView()
        // Do any additional setup after loading the view.
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        cell.ticker = model.companies[indexPath.row].ticker
        return cell
    }

}
