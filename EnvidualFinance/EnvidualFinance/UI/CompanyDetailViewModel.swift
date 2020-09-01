//
//  CompanyDetailViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 01.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared
import RxCocoa

class CompanyDetailViewModel {
    
    private(set) var company: CompanyData
    var news = BehaviorRelay<[CompanyNews]>(value: [])
    
    init(company: CompanyData) {
        self.company = company
        getNews()
    }
    
    lazy var adapter: NativeViewModel = NativeViewModel(
        viewUpdate: {companies in},
        newsUpdate: {[weak self] news in
            self?.newsUpdate(for: news)
        },
        errorUpdate: { [weak self] errorMessage in
            self?.errorUpdate(for: errorMessage)
        }
    )
    
    deinit {
        adapter.onDestroy()
    }
    
    private func getNews() {
        if let ticker = company.ticker {
            adapter.startObservingNewsFor(ticker: ticker)
        }
    }
    
    private func newsUpdate(for news: [CompanyNews]) {
        self.news.accept(news)
    }
    
    private func errorUpdate(for errorMessage: String) {
        print("An error occured but I don't know what to do with it yet. Error message is: \(errorMessage)")
    }
}
