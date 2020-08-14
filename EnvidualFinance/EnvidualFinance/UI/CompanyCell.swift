//
//  CompanyCell.swift
//  EnvidualFinance
//
//  Created by Maximilian Fehrentz on 12.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    var ticker: String? {
        didSet {
            setNeedsLayout()
        }
    }
    
//    var companyName: String? {
//        didSet {
//            setNeedsLayout()
//        }
//    }
    
//    private var stackView = UIStackView()
    private var tickerLabel = UILabel()
//    private var companyNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        layoutTickerLabel()
        configureTickerLabel()
//        layoutCompanyNameLabel()
//        configureCompanyNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tickerLabel.text = ticker
//        companyNameLabel.text = companyName
    }
    
    private func addAllSubviews() {
        contentView.addSubview(tickerLabel)
//        contentView.addSubview(companyNameLabel)
    }
    
    private func layoutTickerLabel() {
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tickerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tickerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func configureTickerLabel() {
        tickerLabel.adjustsFontSizeToFitWidth = true
        tickerLabel.numberOfLines = 0
        tickerLabel.textAlignment = .center
    }
    
//    private func layoutCompanyNameLabel() {
//        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        companyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        companyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        companyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        companyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//
//    private func configureCompanyNameLabel() {
//        tickerLabel.adjustsFontSizeToFitWidth = true
//        tickerLabel.numberOfLines = 0
//        tickerLabel.textAlignment = .center
//    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    

}
