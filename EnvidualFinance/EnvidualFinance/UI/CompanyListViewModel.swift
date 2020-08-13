//
//  CompanyListViewModel.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 12.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared

struct CompanyListViewModel {
    
    private(set) var companies: [CompanyData] = []
    private let getCompanyByTickerUseCase = GetCompanyByTickerUseCase()
    
    func getCompany(_ ticker: String) {
    }
    
}
