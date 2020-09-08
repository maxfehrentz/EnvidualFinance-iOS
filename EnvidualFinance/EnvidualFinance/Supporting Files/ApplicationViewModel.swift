//
//  ApplicationViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 02.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared

class ApplicationViewModel {
    
    private let useCases = UseCases()
    private lazy var updateCompaniesUseCase = useCases.updateCompaniesUseCase
    
    func refreshDataBase() {
        updateCompaniesUseCase.invoke(completionHandler: {_,_ in})
    }
}
