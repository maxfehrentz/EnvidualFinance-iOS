//
//  FavouritesViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 25.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared
import RxCocoa

class FavouritesViewModel {
    
    private(set) var companies = BehaviorRelay<[CompanyData]>(value: [])
    private lazy var getCompaniesForFavouritesUseCase: GetCompaniesForFavouritesUseCase = resolve()
    private lazy var deleteCompanyFromFavouritesUseCase: DeleteCompanyFromFavouritesUseCase = resolve()
    private lazy var collector = CustomFlowCollector<CompanyData>(viewUpdate: {[weak self] favourites in
        if let companies = favourites as? [CompanyData] {
            self?.dataUpdate(companies: companies)
        }
    })
    let showLoading = BehaviorRelay<Bool>(value: false)
    
    private func dataUpdate(companies: [CompanyData]) {
        self.companies.accept(companies)
        showLoading.accept(false)
    }
    
    func startObservingFavourites() {
        showLoading.accept(true)
        getCompaniesForFavouritesUseCase.invoke {[weak self] (flow, error) in
            guard let self = self else {
                return
            }
            flow?.collect(collector: self.collector, completionHandler: {_,_ in})
        }
    }
    
    func removeFavourite(company: CompanyData) {
        deleteCompanyFromFavouritesUseCase.invoke(companyData: company, completionHandler: {_,_ in})
    }
    
}

    
