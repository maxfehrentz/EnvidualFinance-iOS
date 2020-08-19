//
//  CompanyListConstants.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 13.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

struct DesignConstants {
    // MARK: TabBarController stuff
    static let sfSymbolsTabBar = ["suit.heart", "magnifyingglass"]
    static let tabNames = ["Favorites", "Search"]
    
    static let cellHeight: CGFloat = 200
//    static let envidualBlue = #colorLiteral(red: 0.01252049021, green: 0.3257434964, blue: 0.4525720477, alpha: 1)
    static let navConBlue = #colorLiteral(red: 0.2514986992, green: 0.2871406078, blue: 0.5895476341, alpha: 1)
    static let pinkColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    static let standardPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    static let standardInsetFromEdges: CGFloat = 20
    static let minInsetFromEdges: CGFloat = 10
    static let standardOffsetBetweenElements: CGFloat = 10
    static let activityIndicatorWidthAndHeightToSuperview = 0.75
    static let activityIndicatorColor = UIColor.black
    static let detailVcNameLabelOffsetFromTop = 80
    static let flatLabelHeightToSuperview = 0.2
    static let highLabelHeightToSuperview = 0.33333
    static let half = 0.5
    static let detailVcOffsetBetweenLargeElements = 30
    static let logoCornerRadius: CGFloat = 20
    static let detailVcNameFont = UIFont.systemFont(ofSize: 40, weight: .heavy)
    static let detailVcNameFontColor = UIColor.white
    static let detailVcCardViewLabelsFont = UIFont.systemFont(ofSize: 25, weight: .light)
    static let cardViewCornerRadius: CGFloat = 30
    static let sfSymbolNotLiked = "heart"
    static let sfSymbolLiked = "heart.fill"
    static let companySearchCellTickerFont = UIFont.systemFont(ofSize: 25, weight: .heavy)
    static let companySearchCellNameFont = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
    static let companyCellNameFont = UIFont.systemFont(ofSize: 39, weight: .light)
    static let marketCapitalizationLabelFontColor = UIColor.green
    
    
    static func setGradientBackground(for view: UIView, colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
