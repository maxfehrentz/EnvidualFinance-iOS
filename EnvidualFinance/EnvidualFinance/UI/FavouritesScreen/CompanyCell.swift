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
    
    private let containerView = UIView()
    let tickerLabel = UILabel()
    let companyNameLabel = UILabel()
    let marketCapitalizationLabel = UILabel()
    
    override var bounds: CGRect {
        didSet {
            configureShadow()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        layout()
        configureCellAppearance()
        configureTickerLabel()
        configureCompanyNameLabel()
        configureMarketCapitalizationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAllSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(tickerLabel)
        containerView.addSubview(marketCapitalizationLabel)
    }

    private func layout() {
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
                .inset(DesignConstants.insetForContainerViewInContentView)
        }
        companyNameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.trailing.equalToSuperview().offset(-DesignConstants.standardInsetFromEdges)
            make.bottom.equalTo(tickerLabel.snp.top).offset(-DesignConstants.standardOffsetBetweenElements)
        }
        tickerLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(DesignConstants.standardInsetFromEdges)
            make.bottom.equalToSuperview()
                .offset(-DesignConstants.standardInsetFromEdges)
            make.trailing.equalTo(companyNameLabel.snp.centerX).offset(-DesignConstants.standardInsetFromEdges)
        }
        marketCapitalizationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(companyNameLabel.snp.bottom)
                .offset(DesignConstants.standardOffsetBetweenElements)
            make.bottom.trailing.equalToSuperview().offset(-DesignConstants.standardInsetFromEdges)
            make.leading.equalTo(companyNameLabel.snp.centerX).offset(DesignConstants.standardInsetFromEdges)
        }
    }
    
    private func configureCellAppearance() {
        // we do not want selected cells to be highlighted
        selectionStyle = .none
        // make cells round
        containerView.layer.borderColor = DesignConstants.borderColorForCompanyCell
        containerView.layer.borderWidth = DesignConstants.borderWidthForCompanyCell
        containerView.layer.cornerRadius = DesignConstants.cornerRadiusForCompanyCell
        // prepare for adding shadows later
        contentView.backgroundColor = .white
        containerView.backgroundColor = .white
    }
    
    private func configureTickerLabel() {
        tickerLabel.numberOfLines = 0
        tickerLabel.textAlignment = .left
    }
     
    private func configureCompanyNameLabel() {
        companyNameLabel.numberOfLines = 0
        companyNameLabel.textAlignment = .left
        companyNameLabel.font = DesignConstants.companyCellNameFont
    }
    
    private func configureMarketCapitalizationLabel() {
        marketCapitalizationLabel.numberOfLines = 0
        marketCapitalizationLabel.textAlignment = .center
        marketCapitalizationLabel.layer.cornerRadius = DesignConstants.marketCapitalizationLabelCornerRadius
        marketCapitalizationLabel.textColor = DesignConstants.marketCapitalizationLabelFontColor
        marketCapitalizationLabel.layer.backgroundColor =  DesignConstants.marketCapitalizationLabelBackgroundColor
    }
    
    func configureShadow() {
        containerView.layer.shadowColor = DesignConstants.shadowColor
        containerView.layer.shadowRadius = DesignConstants.shadowRadiusForCompanyCells
        containerView.layer.shadowOffset = DesignConstants.shadowOffsetForCompanyCells
        containerView.layer.shadowOpacity = DesignConstants.shadowOpacityForCompanyCells
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
