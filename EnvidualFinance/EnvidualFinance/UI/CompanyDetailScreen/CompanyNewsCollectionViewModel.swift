//
//  CompanyNewsCollectionViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 10.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared
import RxCocoa
import shared

class CompanyNewsCollectionViewModel {
    
    private let company: CompanyData
    private(set) var news = BehaviorRelay<[CompanyNews]>(value: [])
    private let useCases = UseCases()
    lazy private var getCompanyNewsByTickerUseCase = useCases.getCompanyNewsByTickerUseCase
    var isLoadingNews = BehaviorRelay<Bool>(value: false)
    var errorDelegate: ErrorDelegate!
    
    init(company: CompanyData) {
        self.company = company
    }
    
    func getNews() {
        isLoadingNews.accept(true)
        if let ticker = company.ticker {
            getCompanyNewsByTickerUseCase.invoke(ticker: ticker, completionHandler: {[weak self] data, error in
                if let newNews = data {
                    self?.newsUpdate(for: newNews)
                }
                if let newError = error {
                    self?.errorUpdate(for: newError.localizedDescription)
                }
            })
        }
    }
    
    private func newsUpdate(for news: [CompanyNews]) {
        isLoadingNews.accept(false)
        self.news.accept(news)
    }
    
    private func errorUpdate(for errorMessage: String) {
        isLoadingNews.accept(false)
        errorDelegate.showError(for: errorMessage)
    }
}
