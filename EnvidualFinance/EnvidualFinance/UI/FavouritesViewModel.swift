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
    
    var companies = BehaviorRelay<[CompanyData]>(value: [])
    var vc: FavouritesViewController!
        
    lazy var adapter: NativeViewModel = NativeViewModel(
        viewUpdate: { [weak self] companies in
            self?.dataUpdate(companies: companies)
        }, newsUpdate: {news in},
           errorUpdate: { [weak self] errorMessage in
            self?.errorUpdate(for: errorMessage)
        }
    )
    
    deinit {
        adapter.onDestroy()
    }
    
    private func dataUpdate(companies: [CompanyData]) {
        self.companies.accept(companies)
        vc.stopSpinning()
    }
    
    private func errorUpdate(for errorMessage: String) {
        vc.showError(for: errorMessage)
    }
    
    func startObservingFavourites() {
        vc.startSpinning()
        adapter.startObservingFavourites()
    }
    
    func removeFavourite(company: CompanyData) {
        adapter.removeFavourite(company: company)
    }
    
}

    
