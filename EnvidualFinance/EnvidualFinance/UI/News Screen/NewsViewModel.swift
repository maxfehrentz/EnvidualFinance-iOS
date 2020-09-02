//
//  NewsViewModel.swift
//  EnvidualFinance
//
//  Created by Max on 01.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import shared

class NewsViewModel {
    
    private(set) var news: CompanyNews
    
    init(news: CompanyNews) {
        self.news = news
    }
}
