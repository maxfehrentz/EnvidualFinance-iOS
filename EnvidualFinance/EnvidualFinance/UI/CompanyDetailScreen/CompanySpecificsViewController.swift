//
//  CompanyDetailDataViewController.swift
//  EnvidualFinance
//
//  Created by Max on 10.09.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

class CompanySpecificsViewController: UIViewController {
    
    private let viewModel: CompanySpecificsViewModel
    private let tickerLabel = UILabel()
    private let countryLabel = UILabel()
    private let valueLabel = UILabel()
    private let industryLabel = UILabel()
    private let ipoLabel = UILabel()
    private let shareOutstandingLabel = UILabel()
    
    override func viewDidLoad() {
        configureAppearance()
        addAllSubviews()
        layout()
        configureLabels()
    }
    
    init(viewModel: CompanySpecificsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        view.backgroundColor = .clear
    }
    
    private func addAllSubviews() {
        view.addSubview(tickerLabel)
        view.addSubview(countryLabel)
        view.addSubview(valueLabel)
        view.addSubview(industryLabel)
        view.addSubview(ipoLabel)
        view.addSubview(shareOutstandingLabel)
    }
    
    private func layout() {
        tickerLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(view.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.third)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tickerLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(view.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.third)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(countryLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(view.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.third)
        }
        industryLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(view.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.third)
        }
        ipoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(industryLabel.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalTo(view.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.third)
        }
        shareOutstandingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ipoLabel.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalTo(view.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.third)
        }
    }
    
    private func configureLabels() {
        setBasicLabelProperties(for: tickerLabel)
        var boldText = "Ticker:\n"
        var normalText = ""
        if let ticker = viewModel.company.ticker {
            normalText = "\(ticker)"
        }
        setAttributedTitle(for: tickerLabel, boldText: boldText, normalText: normalText)
        
        setBasicLabelProperties(for: countryLabel)
        boldText = "Country:\n"
        normalText = ""
        if let country = viewModel.company.country {
            normalText = "\(country)"
        }
        setAttributedTitle(for: countryLabel, boldText: boldText, normalText: normalText)
        
        setBasicLabelProperties(for: valueLabel)
        boldText = "Value:\n"
        normalText = ""
        if let value = viewModel.company.marketCapitalization, let currency = viewModel.company.currency {
            normalText = "\(value) \(currency)"
        }
        setAttributedTitle(for: valueLabel, boldText: boldText, normalText: normalText)
        
        setBasicLabelProperties(for: industryLabel)
        boldText = "Industry:\n"
        normalText = ""
        if let industry = viewModel.company.finnhubIndustry {
            normalText = "\(industry)"
        }
        setAttributedTitle(for: industryLabel, boldText: boldText, normalText: normalText)
        
        setBasicLabelProperties(for: ipoLabel)
        boldText = "IPO:\n"
        normalText = ""
        if let ipo = viewModel.company.ipo {
            normalText = "\(ipo)"
        }
        setAttributedTitle(for: ipoLabel, boldText: boldText, normalText: normalText)
        
        setBasicLabelProperties(for: shareOutstandingLabel)
        boldText = "Share Outstanding:\n"
        normalText = ""
        if let shareOutstanding = viewModel.company.shareOutstanding, let currency = viewModel.company.currency {
            normalText = "\(shareOutstanding) \(currency)"
        }
        setAttributedTitle(for: shareOutstandingLabel, boldText: boldText, normalText: normalText)
    }
    
    private func setBasicLabelProperties(for label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = DesignConstants.detailVcCardViewLabelsFont
    }
    
    private func setAttributedTitle(for label: UILabel, boldText: String, normalText: String) {
        let attributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: DesignConstants.detailVcCardViewLabelsFontSize)]
        let boldString = NSMutableAttributedString(string: boldText, attributes: attributes)
        let normalString = NSMutableAttributedString(string: normalText)
        boldString.append(normalString)
        label.attributedText = boldString
    }
    
}
