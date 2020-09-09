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
    static let tabNames = ["Favourites", "Search"]
    
    static let cellHeight: CGFloat = 150
//    static let envidualBlue = #colorLiteral(red: 0.01252049021, green: 0.3257434964, blue: 0.4525720477, alpha: 1)
    static let navConBlue = #colorLiteral(red: 0.2514986992, green: 0.2871406078, blue: 0.5895476341, alpha: 1)
    static let pinkColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    static let standardPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    static let standardInsetFromEdges: CGFloat = 20
    static let minInsetFromEdges: CGFloat = 10
    static let standardOffsetBetweenElements: CGFloat = 10
    static let activityIndicatorWidthAndHeightToSuperview = 0.75
    static let activityIndicatorColor = UIColor.black
    static let detailVcNameLabelOffsetFromTop = 20
    static let flatLabelHeightToSuperview = 0.2
    static let highLabelHeightToSuperview = 0.25
    static let half = 0.5
    static let quarter = 0.25
    static let detailVcOffsetBetweenLargeElements = 20
    static let logoCornerRadius: CGFloat = 20
    static let detailVcNameFont = UIFont.systemFont(ofSize: 40, weight: .heavy)
    static let detailVcNameFontColor = UIColor.white
    static let detailVcCardViewLabelsFontSize: CGFloat = 25
    static let detailVcCardViewLabelsFont = UIFont.systemFont(ofSize: DesignConstants.detailVcCardViewLabelsFontSize, weight: .light)
    static let cardViewCornerRadius: CGFloat = 30
    static let sfSymbolNotLiked = "heart"
    static let sfSymbolLiked = "heart.fill"
    static let companySearchCellTickerFont = UIFont.systemFont(ofSize: 29, weight: .heavy)
    static let companySearchCellNameFont = UIFont.systemFont(ofSize: 29, weight: .ultraLight)
    static let insetForHeartSymbolVertical: CGFloat = 33
    static let insetForHeartSymbolHorizontal: CGFloat = 31
    static let companyCellNameFont = UIFont.systemFont(ofSize: 39, weight: .light)
    static let marketCapitalizationLabelFontColor = UIColor.green
    static let borderColorForCompanyCell = UIColor.black.cgColor
    static let borderWidthForCompanyCell: CGFloat = 0.5
    static let cornerRadiusForCompanyCell: CGFloat = 20
    static let insetForContainerViewInContentView: CGFloat = 10
    static let fontForNavBar = UIFont.systemFont(ofSize: 29, weight: .light)
    static let attributesForNavBar = [NSAttributedString.Key.font: fontForNavBar, NSAttributedString.Key.foregroundColor: UIColor.white]
    static let newsTableViewHeightToCardHeight: CGFloat = 0.8
    static let shadowRadiusForCompanyCells: CGFloat = 3
    static let shadowOffsetForCompanyCells: CGSize = .zero
    static let shadowOpacityForCompanyCells: Float = 1
    static let shadowColor = DesignConstants.navConBlue.cgColor
    static let fontForNewsHeadline = UIFont.systemFont(ofSize: 29, weight: .bold)
    static let fontForNewsViewControllerLabels = UIFont.systemFont(ofSize: 20, weight: .light)
    static let offsetBetweenNewsViewControllerLabels = 20
    static let heightOfPageControlToSuperviewHeight: CGFloat = 0.1
    static let fontForHeadlineInNewsCell = UIFont.systemFont(ofSize: 20, weight: .bold)
    
    
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
