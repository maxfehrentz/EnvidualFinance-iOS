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

class CompanyViewModel {
    
    private(set) var company: CompanyData
    
    init(company: CompanyData) {
        self.company = company
    }

}
