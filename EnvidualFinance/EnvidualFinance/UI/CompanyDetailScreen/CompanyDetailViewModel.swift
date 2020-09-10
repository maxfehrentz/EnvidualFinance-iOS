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
    private(set) var news = BehaviorRelay<[CompanyNews]>(value: [])
    private let useCases = UseCases()
    private lazy var getCompanyNewsByTickerUseCase = useCases.getCompanyNewsByTickerUseCase
    var isLoadingNews = BehaviorRelay<Bool>(value: false)
    
    init(company: CompanyData) {
        self.company = company
        getNews()
    }
    
    private func getNews() {
        isLoadingNews.accept(true)
        if let ticker = company.ticker {
            getCompanyNewsByTickerUseCase.invoke(ticker: ticker, completionHandler: {[weak self] data, error in
                if let newNews = data {
                    self?.news.accept(newNews)
                }
            })
        }
    }
    
    private func newsUpdate(for news: [CompanyNews]) {
        isLoadingNews.accept(false)
        self.news.accept(news)
    }
    
    private func errorUpdate(for errorMessage: String) {
        print("An error occured but I don't know what to do with it yet. Error message is: \(errorMessage)")
    }
}
