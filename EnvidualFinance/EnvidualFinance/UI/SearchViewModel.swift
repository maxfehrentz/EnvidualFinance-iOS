//
//  SearchViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 25.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared

class SearchViewModel {
    
    private var previousSearches = [CompanyData]()
    // displayedSearches is necessary to filter already exisiting searches by their ticker
    var displayedSearches = [CompanyData]()
    var vc: SearchViewController!
    
    lazy var adapter: NativeViewModel = NativeViewModel(
        viewUpdate: { [weak self] companies in
            self?.dataUpdate(for: companies)
        }, errorUpdate: { [weak self] errorMessage in
            self?.errorUpdate(for: errorMessage)
        }
    )
    
    deinit {
          adapter.onDestroy()
    }
    
    private func dataUpdate(for companies: [CompanyData]) {
        previousSearches = companies
        // reverse the searches to show latest first
        previousSearches.reverse()
        displayedSearches = previousSearches
        vc.updateUI()
        vc.stopSpinning()
        vc.collapseSearchBar()
    }
    
    private func errorUpdate(for errorMessage: String) {
        vc.showError(for: errorMessage)
    }
    
    func startObservingSearches() {
        adapter.startObservingSearches()
    }
    
    func searchForCompany(with ticker: String?) {
        if var possibleTicker = ticker {
            // make ticker uppercased to avoid problems
            possibleTicker = possibleTicker.uppercased()
            // check if a company with this ticker is already in the list; if it is, we don't want to start a new request
            let companiesMappedToTickers = displayedSearches.map {
                company in
                company.ticker
            }
            if companiesMappedToTickers.contains(possibleTicker) {
                return
            }
            // if it is not in the list, we start a new request
            vc.startSpinning()
            adapter.getCompanyByTicker(ticker: possibleTicker)
        }
    }
    
    // function restores the displayedSearches to show everything in the tableView
    func restoreDisplayedSearches() {
        displayedSearches = previousSearches
        vc.updateUI()
    }
    
    func applySearchFilter(for searchText: String) {
        displayedSearches = previousSearches.filter { company in
            company.ticker!.localizedCaseInsensitiveContains(searchText)
        }
        vc.updateUI()
    }
    
}

extension SearchViewModel: SearchDelegate {
    func addCompanyToFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches {
            if ticker == displayedSearch.ticker {
                adapter.addFavourite(company: displayedSearch)
                break
            }
        }
    }
    
    func removeCompanyFromFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches {
            if ticker == displayedSearch.ticker {
                adapter.removeFavourite(company: displayedSearch)
                break
            }
        }
    }
    
}


