//
//  SearchViewController+UISearchResultsUpdating.swift
//  EnvidualFinance
//
//  Created by Max on 18.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchResultsUpdating {
    // filter the tableView by user input in the searchBar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.applySearchFilter(for: searchText)
        }
    }
}
