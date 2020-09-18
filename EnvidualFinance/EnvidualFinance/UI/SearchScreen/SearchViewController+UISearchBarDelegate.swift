//
//  SearchViewController+UISearchBarDelegate.swift
//  EnvidualFinance
//
//  Created by Max on 18.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchForCompany(with: searchBar.text)
    }
    
    // function restores the displayedSearches to show everything in the tableView
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.restoreDisplayedSearches()
    }
}
