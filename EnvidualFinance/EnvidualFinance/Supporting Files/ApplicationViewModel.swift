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
    
    lazy var adapter: NativeViewModel = NativeViewModel(viewUpdate: {_ in}, newsUpdate: {_ in}, errorUpdate: {_ in}
    )
    
    func refreshDataBase() {
        adapter.updateCompanies()
    }
}
