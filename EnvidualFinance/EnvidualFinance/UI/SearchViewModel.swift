//
//  SearchViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 25.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared
import RxCocoa

class SearchViewModel {
    
    private var previousSearches = [CompanyData]()
    // displayedSearches is necessary to filter already exisiting searches by their ticker
    var displayedSearches = BehaviorRelay<[CompanyData]>(value: [])
    var vc: SearchViewController!
    
    lazy var adapter: NativeViewModel = NativeViewModel(
        viewUpdate: { [weak self] companies in
            self?.dataUpdate(for: companies)
        }, newsUpdate: {news in},
           errorUpdate: { [weak self] errorMessage in
            self?.errorUpdate(for: errorMessage)
        }
    )
    
    deinit {
        adapter.onDestroy()
    }
    
    private func dataUpdate(for companies: [CompanyData]) {
        previousSearches = companies
        displayedSearches.accept(previousSearches)
        vc.stopSpinning()
        vc.collapseSearchBar()
    }
    
    private func errorUpdate(for errorMessage: String) {
        vc.showError(for: errorMessage)
        vc.stopSpinning()
    }
    
    func startObservingSearches() {
        adapter.startObservingSearches()
    }
    
    func searchForCompany(with ticker: String?) {
        if let possibleTicker = ticker {
            vc.startSpinning()
            adapter.getCompanyByTicker(ticker: possibleTicker)
        }
    }
    
    func removeCompanyFromSearches(company: CompanyData) {
        adapter.removeCompanyFromSearches(company: company)
    }
    
    // function restores the displayedSearches to show everything in the tableView
    func restoreDisplayedSearches() {
        displayedSearches.accept(previousSearches)
    }
    
    func applySearchFilter(for searchText: String) {
        displayedSearches.accept(previousSearches.filter { company in
            company.ticker!.localizedCaseInsensitiveContains(searchText)
        })
    }
    
}

extension SearchViewModel: SearchDelegate {
    func addCompanyToFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches.value {
            if ticker == displayedSearch.ticker {
                adapter.addFavourite(company: displayedSearch)
                break
            }
        }
    }
    
    func removeCompanyFromFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches.value {
            if ticker == displayedSearch.ticker {
                adapter.removeFavourite(company: displayedSearch)
                break
            }
        }
    }
    
}


