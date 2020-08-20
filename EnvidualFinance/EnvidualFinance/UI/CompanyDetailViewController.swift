//
//  CompanyDetailViewController.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 18.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import shared
import SnapKit
import Kingfisher

class CompanyDetailViewController: UIViewController {
    
    var company: CompanyData!
    
    private var logo = UIImageView()
    private var cardView = CardView()
    private var nameLabel = UILabel()
    private var tickerLabel = UILabel()
    private var countryLabel = UILabel()
    private var valueLabel = UILabel()
    private var industryLabel = UILabel()
    private var ipoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DesignConstants.setGradientBackground(for: view, colorTop: DesignConstants.standardPurple, colorBottom: DesignConstants.pinkColor)
        addAllSubviews()
        layout()
        configureLogo()
        configureCardView()
        configureLabels()
        // Do any additional setup after loading the view.
    }
    
    private func addAllSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(logo)
        view.addSubview(cardView)
        cardView.addSubview(tickerLabel)
        cardView.addSubview(countryLabel)
        cardView.addSubview(valueLabel)
        cardView.addSubview(industryLabel)
        cardView.addSubview(ipoLabel)
    }
    
    private func layout() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DesignConstants.detailVcNameLabelOffsetFromTop)
            make.left.right.equalToSuperview().inset(DesignConstants.minInsetFromEdges)
            make.height.equalToSuperview().multipliedBy(DesignConstants.flatLabelHeightToSuperview)
        }
        logo.snp.makeConstraints { (make) in make.top.equalTo(nameLabel.snp.bottom).offset(DesignConstants.detailVcOffsetBetweenLargeElements)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(DesignConstants.half)
            make.height.equalTo(logo.snp.width)
        }
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom)
            .offset(DesignConstants.detailVcOffsetBetweenLargeElements)
            make.left.right.bottom.equalToSuperview()
        }
        tickerLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tickerLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(countryLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        industryLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        ipoLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalTo(industryLabel.snp.bottom)
            make.leading.equalTo(cardView.snp.centerX)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
    }
    
    private func configureLogo() {
        logo.kf.setImage(with: URL(string: company.logo!))
        logo.contentMode = .scaleAspectFit
        logo.layer.cornerRadius = DesignConstants.logoCornerRadius
        logo.layer.masksToBounds = true
    }
    
    private func configureCardView() {
        cardView.backgroundColor = cardView.color
        cardView.layer.cornerRadius = cardView.cornerRadius
    }
    
    private func configureLabels() {
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        let nameLabelFont = DesignConstants.detailVcNameFont
        let attributes = [NSAttributedString.Key.font : nameLabelFont, NSAttributedString.Key.foregroundColor : DesignConstants.detailVcNameFontColor]
        let attributedString = NSAttributedString(string: company.name ?? "", attributes: attributes)
        nameLabel.attributedText = attributedString

        
        setBasicLabelProperties(for: tickerLabel)
        if let ticker = company.ticker {
            tickerLabel.text = "Ticker:\n\(ticker)"
        }
        else {
            tickerLabel.text = "Ticker:\n"
        }
        
        setBasicLabelProperties(for: countryLabel)
        if let country = company.country {
            countryLabel.text = "Country:\n\(country)"
        }
        else {
            countryLabel.text = "Country:\n"
        }
        
        setBasicLabelProperties(for: valueLabel)
        if let value = company.marketCapitalization, let curr = company.currency {
            valueLabel.text = "Value:\n\(value) \(curr)"
        }
        else {
            valueLabel.text = "Value:\n"
        }
        
        setBasicLabelProperties(for: industryLabel)
        if let industry = company.finnhubIndustry {
            industryLabel.text = "Industry:\n\(industry)"
        }
        else {
            industryLabel.text = "Industry:\n"
        }
        
        setBasicLabelProperties(for: ipoLabel)
        if let ipo = company.ipo {
            ipoLabel.text = "IPO:\n\(ipo)"
        }
        else {
            ipoLabel.text = "IPO:\n"
        }
    }
    
    private func setBasicLabelProperties(for label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = DesignConstants.detailVcCardViewLabelsFont
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
