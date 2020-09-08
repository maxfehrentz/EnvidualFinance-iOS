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
    private let useCases = UseCases()
    private lazy var getCompanyNewsByTickerUseCase = useCases.getCompanyNewsByTickerUseCase
    private lazy var collector: CustomFlowCollector<CompanyData> = CustomFlowCollector<CompanyData>(viewUpdate: {[weak self] news in
        if let news = news as? [CompanyNews] {
            self?.newsUpdate(for: news)
        }
    })
    
    init(company: CompanyData) {
        self.company = company
        getNews()
    }
    
    private func getNews() {
        if let ticker = company.ticker {
            getCompanyNewsByTickerUseCase.invoke(ticker: ticker) {[weak self] (flow, error) in
                flow?.collect(collector: self?.collector as! Kotlinx_coroutines_coreFlowCollector, completionHandler: {_,_ in})
            }
        }
    }
    
    private func newsUpdate(for news: [CompanyNews]) {
        self.news.accept(news)
    }
    
    private func errorUpdate(for errorMessage: String) {
        print("An error occured but I don't know what to do with it yet. Error message is: \(errorMessage)")
    }
}
