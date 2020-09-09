//
//  SearchDelegate.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 17.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared

protocol SearchDelegate {
    func addCompanyToFavourites(forTicker ticker: String)
    func removeCompanyFromFavourites(forTicker ticker: String)
}
