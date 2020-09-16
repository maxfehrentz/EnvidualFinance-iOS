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
    // previousSearches is necessary for storing to filter already exisiting searches by their ticker when the user types stuff into the searchbar
    private(set) var displayedSearches = BehaviorRelay<[CompanyData]>(value: [])
    var errorDelegate: ErrorDelegate!
    let showLoading = BehaviorRelay<Bool>(value: false)
    let searchBarIsActive = BehaviorRelay<Bool>(value: false)

    private let getCompaniesForSearchesUseCase: GetCompaniesForSearchesUseCase = resolve()
    private let getCompanyByTickerUseCase: GetCompanyByTickerUseCase = resolve()
    private let deleteCompanyFromSearchesUseCase: DeleteCompanyFromSearchesUseCase = resolve()
    private let addCompanyToFavouritesUseCase: AddCompanyToFavouritesUseCase = resolve()
    private let deleteCompanyFromFavouritesUseCase: DeleteCompanyFromFavouritesUseCase = resolve()
    private lazy var collector = CustomFlowCollector<CompanyData>(viewUpdate: {[weak self] data in
        if let companies = data as? [CompanyData] {
            self?.dataUpdate(for: companies)
        }
    })
    
    private func dataUpdate(for companies: [CompanyData]) {
        previousSearches = companies
        displayedSearches.accept(previousSearches)
        showLoading.accept(false)
        searchBarIsActive.accept(false)
    }
    
    private func errorUpdate(for errorMessage: String) {
        errorDelegate.showError(for: errorMessage)
        showLoading.accept(false)
        searchBarIsActive.accept(false)
        restoreDisplayedSearches()
    }
    
    func startObservingSearches() {
        getCompaniesForSearchesUseCase.invoke {[weak self] (flow, error) in
            guard let self = self else {
                return
            }
            flow?.collect(collector: self.collector, completionHandler: {_,_ in})
        }
    }
    
    func searchForCompany(with ticker: String?) {
        if let possibleTicker = ticker {
            showLoading.accept(true)
            getCompanyByTickerUseCase.invoke(ticker: possibleTicker, completionHandler: {[weak self] _,error in
                if let error = error {
                    self?.errorUpdate(for: error.localizedDescription)
                }
            })
        }
    }
    
    func removeCompanyFromSearches(company: CompanyData) {
        deleteCompanyFromSearchesUseCase.invoke(companyData: company, completionHandler: {_,_ in})
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
                addCompanyToFavouritesUseCase.invoke(companyData: displayedSearch, completionHandler: {_,_ in})
                break
            }
        }
    }
    
    func removeCompanyFromFavourites(forTicker ticker: String) {
        // find the CompanyData corresponding to the ticker of the cell and call the corresponding use case
        for displayedSearch in displayedSearches.value {
            if ticker == displayedSearch.ticker {
                deleteCompanyFromFavouritesUseCase.invoke(companyData: displayedSearch, completionHandler: {_,_ in})
                break
            }
        }
    }
    
}


