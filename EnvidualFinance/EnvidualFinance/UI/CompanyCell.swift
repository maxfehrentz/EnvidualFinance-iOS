//
//  CompanyCell.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 14.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit
import SnapKit

class CompanyCell: UITableViewCell {
    
    var ticker: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var name: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var marketCapitalization: Float? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var currency: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var tickerLabel = UILabel()
    
    private var companyNameLabel = UILabel()
    
    private var marketCapitalizationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        layout()
        configureTickerLabel()
        configureCompanyNameLabel()
        configureMarketCapitalizationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tickerLabel.text = ticker
        companyNameLabel.text = name
        if let value = marketCapitalization, let curr = currency {
            marketCapitalizationLabel.text = "\(value) \(curr)"
        }
        else {
            marketCapitalizationLabel.text = ""
        }
    }
    
    private func addAllSubviews() {
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(tickerLabel)
        contentView.addSubview(marketCapitalizationLabel)
    }

    private func layout() {
        companyNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.leading.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.trailing.equalToSuperview().offset(-DesignConstants.standardInsetFromEdges)
            make.height.equalToSuperview().multipliedBy(DesignConstants.highLabelHeightToSuperview)
        }
        tickerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(companyNameLabel).offset(DesignConstants.standardOffsetBetweenElements)
            make.leading.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.bottom.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.right.equalTo(companyNameLabel.snp.centerX)
        }
        marketCapitalizationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(companyNameLabel).offset(DesignConstants.standardOffsetBetweenElements)
            make.bottom.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.right.equalToSuperview().offset(-DesignConstants.standardInsetFromEdges)
        }
    }
    
    private func configureTickerLabel() {
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.adjustsFontSizeToFitWidth = true
        tickerLabel.numberOfLines = 0
        tickerLabel.textAlignment = .left
    }
     
    private func configureCompanyNameLabel() {
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.numberOfLines = 0
        companyNameLabel.textAlignment = .left
        companyNameLabel.font = DesignConstants.companyCellNameFont
    }
    
    private func configureMarketCapitalizationLabel() {
        marketCapitalizationLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapitalizationLabel.adjustsFontSizeToFitWidth = true
        marketCapitalizationLabel.numberOfLines = 0
        marketCapitalizationLabel.textAlignment = .center
        marketCapitalizationLabel.textColor = DesignConstants.marketCapitalizationLabelFontColor
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
